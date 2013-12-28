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
      if @messages.nil?
        @messages = adapter.list_messages_in_mailbox(mailbox: name).map do |message_struct|
          message = Stamper::Converter::RFC822Converter.convert(message_struct.rfc822)
          message.mailbox = self
          message
        end
      end
      @messages
    end

    private

    def adapter
      account.adapter
    end
  end
end