require 'minitest_helper'

# TODO: explain the testing using vagrant and Maildir sample
class TestIMAPAdapter < Minitest::Test
  include TestAdapterInterface

  def setup
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
    assert_equal "INBOX", mailboxes.first[:name]
  end
end