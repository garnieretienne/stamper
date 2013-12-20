require "net/imap"

module Stamper

  module Adapter

    class IMAPAdapter

      attr_reader :imap_manager
      attr_accessor :current_mailbox, :current_mailbox_messages

      def initialize(*args)
        @imap_manager = Stamper::IMAPConnectionManager.new(*args)
        @current_mailbox = nil
        @current_mailbox_messages = nil
      end

      def imap
        imap_manager.open
      end

      def list_subscribed_mailboxes
        imap.lsub("", "%").map do |list_data| 
          convert_list_data(list_data)
        end
      end

      def list_messages_in_mailbox(mailbox: nil, index: nil, results: 20)
        open_mailbox(mailbox)
        last_seqno = current_mailbox_messages
        end_at = (index) || last_seqno
        start_at = (last_seqno > results) ? end_at - results + 1 : 1

        fetch_rfc822(start_at..end_at, header_only: true)
      end

      def get_message_in_mailbox(mailbox: nil, seqno: nil)
        open_mailbox(mailbox)
        fetch_rfc822(seqno)
      end

      private

      def fetch_rfc822(search_param, header_only: false)
        attribute = (header_only) ? "RFC822.HEADER" : "RFC822"
        fetch_data = imap.fetch(search_param, attribute)
        
        case search_param
        when Enumerable
          fetch_data.map{ |imap_data| convert_fetch_data(imap_data, attribute) }
        else
          convert_fetch_data(fetch_data.first, attribute)
        end
      end

      def convert_fetch_data(imap_data, attribute)
        rfc822 = imap_data.attr[attribute]
        Stamper::Converter::RFC822Converter.convert(rfc822)
      end

      def convert_list_data(list_data)
        Stamper::Mailbox.new name: list_data.name
      end

      def open_mailbox(mailbox)
        if current_mailbox != mailbox
          imap.select(mailbox)
          @current_mailbox = mailbox
          @current_mailbox_messages = imap.status(mailbox, ["MESSAGES"])["MESSAGES"]
        end
      end
    end
  end
end