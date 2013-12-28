require 'minitest_helper'

class TestRFC822Converter < Minitest::Test

  def test_rfc822_header_sample
    refute_nil rfc822_header_sample
  end

  def test_rfc822_sample
    refute_nil rfc822_sample
  end

  def test_rfc822_convertion_into_message
    message = Stamper::Converter::RFC822Converter.convert(rfc822_sample, mailbox: Object.new)
    assert_instance_of Stamper::Message, message
    Stamper::Message::HEADER_FIELDS.each do |field|
      refute_nil message.send(field)
    end
    refute_nil message.send(:body)
  end

  def test_rfc822_header_convertion_into_message
    message = Stamper::Converter::RFC822Converter.convert(rfc822_header_sample, mailbox: Object.new)
    assert_instance_of Stamper::Message, message
    Stamper::Message::HEADER_FIELDS.each do |field|
      refute_nil message.send(field)
    end
  end
end