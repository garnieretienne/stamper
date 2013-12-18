require "net/imap"

module Stamper

  module Adapter

    class IMAPAdapter

      attr_reader :imap
      attr_accessor :current_mailbox, :current_mailbox_messages

      def initialize(host: nil, port: 993, ssl: true, user: nil, password: nil)
        @imap = Net::IMAP.new(host, port: port, ssl: ssl)
        imap.login(user, password)
        @current_mailbox = nil
        @current_mailbox_messages = nil
      end

      # TODO: Use the `STATUS` command to get informations on:
      # * MESSAGES: the number of messages in the mailbox.
      # * RECENT: the number of recent messages in the mailbox.
      # * UNSEEN: the number of unseen messages in the mailbox.
      def list_subscribed_mailboxes
        imap.lsub("", "%").map do |imap_data| 
          IMAPAdapter.convert(imap_data)
        end
      end

      def list_messages_in_mailbox(mailbox: nil, index: nil, results: 20)
        open_mailbox(mailbox)
        last_seqno = current_mailbox_messages
        end_at = (index) || last_seqno
        start_at = (last_seqno > results) ? end_at - results + 1 : 1
        imap.fetch(start_at..end_at, "ENVELOPE").map do |imap_data|
          IMAPAdapter.convert(imap_data)
        end
      end

      # Convert data returned by the Net::IMAP methods to simple Hash
      def self.convert(imap_data)
        case imap_data

        when Net::IMAP::FetchData
          envelope = imap_data.attr["ENVELOPE"]
          return {
            header: {
              date: envelope.date,
              from: "#{envelope.from.first.name} <#{envelope.from.first.mailbox}@#{envelope.from.first.host}>",
              to: "#{envelope.from.first.name} <#{envelope.to.first.mailbox}@#{envelope.to.first.host}>",
              subject: envelope.subject
            }
          }

        when Net::IMAP::MailboxList
          return {
            name: imap_data.name
          }

        else
          raise "Cannot convert these data"
        end
      end

      private

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