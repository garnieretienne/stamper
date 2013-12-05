require "net/imap"

module Stamper

  module Adapter

    class IMAPAdapter

      def initialize(host: nil, port: 993, ssl: true, user: nil, password: nil)
        @imap = Net::IMAP.new(host, port: port, ssl: ssl)
        @imap.login(user, password)
      end

      # TODO: Use the `STATUS` command to get informations on:
      # * MESSAGES: the number of messages in the mailbox.
      # * RECENT: the number of recent messages in the mailbox.
      # * UNSEEN: the number of unseen messages in the mailbox.
      def list_subscribed_mailboxes
        result = @imap.lsub("", "%")
        return result.map do |imap_mailbox| 
          {
            name: imap_mailbox.name
          }
        end
      end
    end
  end
end