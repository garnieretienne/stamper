require 'mail'

module Stamper

  module Converter

    # Use the Mail gem by Mikel Lindsaar to convert a plain text RFC822 
    # message into a Stamper message.
    # Mail gem github: https://github.com/mikel/mail
    class RFC822Converter

      attr_reader :rfc822

      def initialize(rfc822)
        @rfc822 = rfc822
      end

      def to_message(options = {})
        message = Stamper::Message.new({header: header, body: body}.merge(options))
        return message
      end

      def self.convert(rfc822, options = {})
        RFC822Converter.new(rfc822).to_message(options)
      end

      private

      def mail
        @mail || (@mail = Mail.new(rfc822))
      end

      def header
        header_hash = {}
        Stamper::Message::HEADER_FIELDS.each do |field|
          header_hash[field] = mail.header[field].to_s if mail.header[field]
        end
        return header_hash
      end

      def body
        mail.text_part.body.to_s if mail.text_part
      end
    end
  end
end