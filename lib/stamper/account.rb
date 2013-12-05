module Stamper

  class Account

    attr_reader :address, :adapter

    def initialize(address: nil, adapter: nil)
      raise "No address provided" unless address
      raise "No adapter provided" unless adapter
      @address = address
      @adapter = adapter
    end

    def list_subscribed_mailboxes
      @adapter.list_subscribed_mailboxes.map do |mailbox_attributes|
        Mailbox.new mailbox_attributes
      end
    end

    def list_messages_in_mailbox(mailbox: "INBOX")
      @adapter.list_messages_in_mailbox.map do |message_attributes|
        Message.new message_attributes
      end
    end
  end
end