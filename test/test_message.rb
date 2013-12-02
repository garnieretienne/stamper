require 'minitest_helper'

class TestMessage < Minitest::Test

  def setup
    @body = "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
    @date = "Mon, 7 Feb 1994 21:52:25 -0800 (PST)"
    @from_address = "Contact name <contact_address@provider.tld>"
    @header = {date: @date, from: @from_address}
    @message = Stamper::Message.new(header: @header, body: @body)
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
    error = assert_raises(RuntimeError){ Stamper::Message.new(header: {date: @date}) }
    assert_equal "No 'from' header field provided", error.message
  end

  def test_raising_error_if_no_date_field_is_provided
    error = assert_raises(RuntimeError){ Stamper::Message.new(header: {from: @from_address}) }
    assert_equal "No 'date' header field provided", error.message
  end
end