module ForceHttps
  extend ActiveSupport::Concern

  included do
    before_filter :force_https
  end

  private

  def force_https
    if Rails.env.production? && request.protocol == 'http://'
      redirect_to('https://' + request.host_with_port + request.fullpath, status: :moved_permanently)
    end
  end
end