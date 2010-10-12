class Inquiry < ActiveRecord::Base

  filters_spam :message_field => :message,
               :email_field => :email,
               :author_field => :name,
               :other_fields => [:phone],
               :extra_spam_words => %w()

  validates :name, :presence => true
  validates :message, :presence => true
  validates :email, :format=> { :with =>  /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i }

  acts_as_indexed :fields => [:name, :email, :message, :phone]

  default_scope :order => 'created_at DESC' # previously scope :newest

  def self.latest(number = 7, include_spam = false)
    unless include_spam
      ham.limit(number)
    else
      limit(number)
    end
  end

end
