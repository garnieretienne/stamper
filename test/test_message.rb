require 'minitest_helper'
require 'ostruct'

class TestMessage < Minitest::Test

  def setup
    @body = "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
    @date = "Mon, 7 Feb 1994 21:52:25 -0800 (PST)"
    @from_address = "Contact name <contact_address@provider.tld>"
    @header = {date: @date, from: @from_address}
    @adapter = MiniTest::Mock.new
    @account = OpenStruct.new(address: "testing@domain.tld", adapter: @adapter)
    @mailbox = OpenStruct.new(name: "INBOX", account: @account)
    @message = Stamper::Message.new(seqno: 1, header: @header, body: @body, mailbox: @mailbox)
  end

  def test_body_reader
    assert_equal @body, @message.body
  end

  def test_header_reader
    assert_equal @header, @message.header
  end

  def test_date_reader
    assert_equal @date, @message.date
  end

  def test_from_reader
    assert_equal @from_address, @message.from
  end

  def test_raising_error_if_no_from_field_is_provided
    error = assert_raises(RuntimeError){ Stamper::Message.new(header: {date: @date}, mailbox: @mailbox) }
    assert_equal "No 'from' header field provided", error.message
  end

  def test_raising_error_if_no_date_field_is_provided
    error = assert_raises(RuntimeError){ Stamper::Message.new(header: {from: @from_address}, mailbox: @mailbox) }
    assert_equal "No 'date' header field provided", error.message
  end

  def test_seqno_reader
    assert_equal 1, @message.seqno
  end

  def test_raising_error_if_the_message_belongs_to_no_mailbox
    error = assert_raises(RuntimeError){ Stamper::Message.new(seqno: 1, header: @header, body: @body) }
    assert_equal "A message must belongs to a mailbox", error.message
  end

  def test_fetch_the_message_body
    partial_message = Stamper::Message.new(seqno: 10, header: @header, mailbox: @mailbox)
    @adapter.expect :get_message_in_mailbox, 
      Stamper::Adapter::IMAPAdapter::Message.new(partial_message.seqno, rfc822_sample), 
      [mailbox: @mailbox.name, seqno: partial_message.seqno]
    partial_message.body
    @adapter.verify
    refute_nil partial_message.body
  end
end