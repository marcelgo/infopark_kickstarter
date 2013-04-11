module HostnameSelection
  extend ActiveSupport::Concern

  included do
    before_filter :select_hostname
  end

  private

  def select_hostname
    if check_hostname? && switch_hostname?
      desired_hostname = @obj.homepage.desired_hostname
      redirect_to(cms_url(@obj, host: desired_hostname))
    end
  end

  def check_hostname?
    request.host !~ /elb\.amazonaws\.com|\.dev|localhost$/ && request.get?
  end

  def switch_hostname?
    Homepage.for_hostname(request.host) != @obj.homepage
  end
end