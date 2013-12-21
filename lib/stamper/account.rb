module Stamper

  class Account

    attr_reader :address, :adapter

    def initialize(address: nil, adapter: nil)
      raise "No address provided" unless address
      raise "No adapter provided" unless adapter
      @address = address
      @adapter = adapter
    end

    def subscribed_mailboxes
      if @mailboxes.nil?
        @mailboxes = adapter.list_subscribed_mailboxes.map do |mailbox_struct|
          Stamper::Mailbox.new(name: mailbox_struct.name, account: self)
        end
      end
      @mailboxes
    end
  end
end