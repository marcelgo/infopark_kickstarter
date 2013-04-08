class ShareCell < BoxCell
  # Cell actions:

  def show(url, provider = [])
    @url = url

    if provider.present?
      @provider = provider.find_all{|item| available_provider.include?(item); }
    else
      @provider = available_provider
    end

    render
  end

  def facebook
    render
  end

  def google
    render
  end

  def twitter
    render
  end

  def linkedin
    render
  end

  private

  def available_provider
    @valid_provider ||= [:facebook, :google, :twitter, :linkedin]
  end
end