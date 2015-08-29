class Message < ActiveRecord::Base

  scope :unread, ->{ where(is_read: false) }

  belongs_to :recipient, class_name: "User", inverse_of: :incoming_messages
  belongs_to :sender, class_name: "User", inverse_of: :sent_messages
  belongs_to :conversation

  validates_presence_of :body

  def is_unread_by?(user)
    if user == sender
      false
    else
      ! self.is_read
    end
  end

end