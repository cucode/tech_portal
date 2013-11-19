class Organization < ActiveRecord::Base
  has_paper_trail

  PENDING   = "pending"
  PUBLISHED = "published"
  STATUSES  = [PENDING, PUBLISHED]


  # Relationships and scopes

  has_many :contacts, dependent: :destroy
  accepts_nested_attributes_for :contacts, reject_if: :all_blank, allow_destroy: true
  acts_as_taggable_on :category
  has_one :feed, dependent: :destroy

  scope :published, -> { where(status: PUBLISHED) }
  scope :pending,   -> { where(status: PENDING) }


  # Validations

  validates :name, presence: {
    message: "Please provide the organization's name." }
  validates :synopsis, presence: {
    message: "Please provide a summary of the organization's purpose." }
  validates :email, allow_blank: true, email_format: {
    message: "Please provide a valid email address." }
  validates :website, allow_blank: true, format: {
    with: URI::regexp(%w(http)),
    message: "Please provide a complete AND and valid url (http://www.mysite.com)."
  }
  #validates :phone, :allow_blank: true, format: {
  # with: /\A\([0-9]{3}\)\s[0-9]{3}-[0-9]{4}/,
  # message: "Please provide a complete phone number, including the area code."
  #}
  validates :status, inclusion: { in: STATUSES }, presence: true

  validates :submitter_name, presence: { message:
    "Please provide your name in case we need to contact you about your organization." }
  validates :submitter_email, presence: {
    message: "Please provide your an email address in case we need to contact you about your organization." },
    email_format: {
      message: "Please provide a valid email address." }
  #validates :submitter_phone, :allow_blank: true, format: {
  #  with: /\A\([0-9]{3}\)\s[0-9]{3}-[0-9]{4}/,
  #  message: "Please provide a complete phone number, including the area code."
  #}

  validates :slug, uniqueness: true


  # Filters

  after_initialize do
    @new_feed_uri = nil
  end

  before_validation do |org|
    if org.name_changed?
      try = org.name.parameterize.to_s
      while org.class.where(slug: try).count > 0
        try += "-#{1}"
      end
      org.slug = try
    end
  end

  after_save do |org|
    feed.destroy if feed.present? && (feed.uri != @new_feed_uri)
    feed = Feed.create(organization: self, uri: @new_feed_uri) if @new_feed_uri
  end


  # Public Methods

  def feed_uri
    feed.try(:uri)
  end

  def feed_uri=(feed_uri)
    @new_feed_uri = feed_uri
  end

end