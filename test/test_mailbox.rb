require 'minitest_helper'

class TestMailbox < Minitest::Test

  def setup
    @name = "INBOX"
    @mailbox = Stamper::Mailbox.new name: @name
  end

  def test_raising_error_if_no_name_provided
    error = assert_raises(RuntimeError){ Stamper::Mailbox.new }
    assert_equal "No name provided", error.message
  end

  def test_name_reader
    assert_equal @name, @mailbox.name
  end
end