class NullUser
  attr_reader :id
  attr_reader :email

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