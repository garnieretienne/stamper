module TestAdapterInterface

  def test_respond_list_subscribed_mailboxes
    assert @object.respond_to?(:list_subscribed_mailboxes)
  end
end