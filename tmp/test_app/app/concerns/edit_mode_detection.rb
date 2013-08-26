module EditModeDetection
  extend ActiveSupport::Concern

  included do
    before_filter :detect_editing_allowed
  end

  private

  def detect_editing_allowed
    session[:editing_allowed] = Rails.env.development? || current_user.admin?
  end

  def self.editing_allowed?(session)
    session[:editing_allowed]
  end

  def editing_allowed?
    self.class.editing_allowed?(session)
  end
end