module TestAdapterInterface

  def test_respond_to_list_subscribed_mailboxes
    assert @object.respond_to?(:list_subscribed_mailboxes)
  end

  def test_respond_to_list_messages_in_mailbox
    assert @object.respond_to?(:list_messages_in_mailbox)
  end

  def test_respond_to_get_message_in_mailbox
    assert @object.respond_to?(:get_message_in_mailbox)
  end
end