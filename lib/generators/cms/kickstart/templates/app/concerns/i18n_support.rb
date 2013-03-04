module I18nSupport
  extend ActiveSupport::Concern

  included do
    before_filter :set_locale
  end

  private

  def set_locale
    I18n.locale = session[:locale] = @obj.try(:locale) || session[:locale].presence || I18n.default_locale
  end
end