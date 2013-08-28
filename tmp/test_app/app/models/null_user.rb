class NullUser
  attr_reader :id
  attr_reader :email
  attr_reader :login

  def logged_in?
    false
  end

  def admin?
    false
  end

  def cache_attributes
    nil
  end
end
