module Stamper

  class Message
    HEADER_FIELDS = :date, :from

    attr_reader *HEADER_FIELDS, :header, :mailbox, :seqno

    def initialize(seqno: nil, header: {}, body: nil, mailbox: nil)
      raise "A message must belongs to a mailbox" if !mailbox
      @seqno = seqno
      @header = header
      @body = body
      @mailbox = mailbox
      parse_header
      validate_header!
    end

    def mailbox?
      !mailbox.nil?
    end

    def body
      if @body.nil?
        message_struct = adapter.get_message_in_mailbox(mailbox: mailbox.name, seqno: seqno)
        retrieved_message = Stamper::Converter::RFC822Converter.convert(message_struct.rfc822, 
          seqno: message_struct.seqno, 
          mailbox: self
        )
        @body = retrieved_message.body
      end
      @body
    end

    private

    # Generate getter for each fields in the header
    def parse_header
      header.each do |field, value|
        self.instance_variable_set("@#{field}", value) if HEADER_FIELDS.include? field
      end
    end

    # Verify a `date` and `from` fields are present
    def validate_header!
      [:date, :from].each do |field|
        raise "No '#{field}' header field provided" unless self.send(field)
      end
    end

    def account
      mailbox.account
    end

    # Mailbox MUST be provided
    def adapter
      account.adapter
    end
  end
end