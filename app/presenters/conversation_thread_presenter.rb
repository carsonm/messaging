class ConversationThreadPresenter

  def initialize(messages)
    messages = messages
  end

  def user_account
    @user_account ||= UserAccount.new
  end

  def address
    @address ||= Address.new
  end

  def user_credentials
    @credentials ||= UserCredential.new
  end

  def save
    user_account.save && address.save && user_credentials.save
  end
end