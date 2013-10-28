class Authentication < ActiveRecord::Base

  # Mixins

  has_paper_trail


  # Relationships

  belongs_to :user


end
