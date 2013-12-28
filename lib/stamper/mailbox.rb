module Stamper

  class Mailbox

    attr_reader :name, :account

    def initialize(name: nil, account: nil)
      raise "No name provided" if !name
      raise "No account provided" if !account
      @name = name
      @account = account
    end

    def messages(search_options = {index: nil, results: 20})
      if @search_options != search_options
        @search_options = search_options
        @messages = adapter.list_messages_in_mailbox({mailbox: name}.merge(search_options)).map do |message_struct|
          message = Stamper::Converter::RFC822Converter.convert(message_struct.rfc822, 
            seqno: message_struct.seqno, 
            mailbox: self
          )
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