require 'minitest_helper'

# TODO: explain the testing using vagrant and Maildir sample
# TODO: clean up the reset_maildir! method
class TestIMAPAdapter < Minitest::Test
  include TestAdapterInterface

  def setup
    reset_maildir!
    @adapter = @object = Stamper::Adapter::IMAPAdapter.new(
      host: 'localhost',
      user: 'vagrant',
      password: 'vagrant',
      ssl: {verify_mode: 0}
    )
  end

  def test_list_subscribed_mailboxes
    mailboxes = @adapter.list_subscribed_mailboxes
    assert_equal 1, mailboxes.count
  end

  def test_list_messages_in_mailbox
    messages = @adapter.list_messages_in_mailbox(mailbox: 'Mailbox1')
    assert_kind_of Enumerable, messages
    assert_equal 3, messages.count
    messages = @adapter.list_messages_in_mailbox(mailbox: 'INBOX', index: 100, results: 50)
    assert_equal 50, messages.count
  end

  def test_get_message_in_mailbox
    message = @adapter.get_message_in_mailbox(mailbox: 'INBOX', seqno: 1)
    refute_kind_of Enumerable, message
    refute_nil message
  end

  private

  def reset_maildir!
    `rm -rf /home/vagrant/Maildir`
    `cp -r /vagrant/test/Maildir /home/vagrant/`
  end
end