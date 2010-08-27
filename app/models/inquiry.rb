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

  scope :newest, :order => 'created_at DESC'

  def self.latest(number = 7, include_spam = false)
    unless include_spam
      ham.find(:all, :limit => number)
    else
      newest.find(:all, :limit => number)
    end
  end

end
