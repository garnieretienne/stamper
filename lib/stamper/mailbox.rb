module Stamper

  class Mailbox

    attr_reader :name, :account

    def initialize(name: nil, account: nil)
      raise "No name provided" if !name
      raise "No account provided" if !account
      @name = name
      @account = account
    end

    def messages
      @messages = adapter.list_messages_in_mailbox(mailbox: name) if @messages.nil?
      @messages
    end

    private

    def adapter
      account.adapter
    end
  end
end