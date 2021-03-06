class Contact < ActiveRecord::Base

  # Mixins

  has_paper_trail


  # Relationships

  belongs_to :organization


  # Validations

  validates :name, presence: { message: "Please provide the contacts's name." }
  validates :email, allow_blank: true, email_format: {
    message: "Please provide a valid email address." }
  #validates :phone, :allow_blank => true

end
