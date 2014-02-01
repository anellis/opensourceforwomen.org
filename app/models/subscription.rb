class Subscription

  include Mongoid::Document
  include Mongoid::Timestamps

  field :email
  field :synced_to_mailchip, :type => Boolean, :default => false

#  attr_accessible :email, :message, :synced_to_mailchimp
  attr_accessor :message

  validates_presence_of :email
  validates_uniqueness_of :email
  validates_format_of :email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i

  def default_mailing_list_id
    "ae537a59f9"
  end

  def register_with_mailchimp
    return unless Gibbon::API.new.api_key
    if Gibbon::API.new.list_subscribe(:id => default_mailing_list_id, :email_address => self.email)
      self.update_attribute(:synced_to_mailchip, true)
    end
  end

  def reset
    self.email = nil
    self.message = "Invalid email or already subscribed."
  end

end