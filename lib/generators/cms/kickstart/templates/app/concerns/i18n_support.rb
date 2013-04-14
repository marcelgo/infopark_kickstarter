module I18nSupport
  extend ActiveSupport::Concern

  included do
    before_filter :set_locale
  end

  private

  def set_locale
    locale = if @obj.respond_to?(:locale)
      @obj.locale
    else
      session[:locale].presence || I18n.default_locale
    end

    I18n.locale = session[:locale] = locale
  end
end