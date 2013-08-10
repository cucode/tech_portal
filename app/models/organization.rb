class Organization < ActiveRecord::Base
  has_paper_trail

  PENDING = "pending"
  PUBLISHED = "published"
  STATUSES = [PENDING, PUBLISHED]

  has_many :contacts, :dependent => :destroy
  accepts_nested_attributes_for :contacts, reject_if: :all_blank, :allow_destroy => true
  acts_as_taggable_on :category

  scope :published, -> { where(:status => PUBLISHED)}
  scope :pending, -> { where(:status => PENDING)}

  validates :name, :presence => {:message => "Please provide the organization's name."}
  validates :synopsis, :presence => {:message => "Please provide a summary of the organization's purpose."}
  validates :email, :allow_blank => true, :email_format => {:message => 'Please provide a valid email address.'}
  #validates :website, :allow_blank => true, :url => {:message => 'Please provide a complete AND and valid url (http://www.mysite.com).'}
  #validates :phone, :allow_blank => true, :phone => {:message => 'Please provide a complete phone number as 10 consecutive digits (no dashes or parens), including the area code.'}
  validates :status, inclusion: { in: STATUSES }, presence: true

  validates :submitter_name, :presence => {:message => "Please provide your name in case we need to contact you about your organization."}
  validates :submitter_email, :presence => {:message => "Please provide your an email address in case we need to contact you about your organization."},
    :email_format => {:message => 'Please provide a valid email address.'}
  #validates :submitter_phone, :presence => true, :phone => {:message => 'Please provide a complete phone number as 10 consecutive digits (no dashes or parens), including the area code.'}

  validates :slug, :uniqueness => true
  before_validation do |org|
    if org.name_changed?
      try = org.name.parameterize.to_s
      while org.class.where(:slug => try).count > 0
        try += "-#{1}"
      end
      org.slug = try
    end
  end
end
