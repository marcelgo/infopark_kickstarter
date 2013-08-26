class LoginPage < Obj
  cms_attribute :headline, type: :string
  cms_attribute :content, type: :html
  cms_attribute :show_in_navigation, type: :boolean
  cms_attribute :sort_key, type: :string

  # Most CMS objects are either a page or a box. In order for them to
  # have common behavior, uncomment one of the following lines.
  include Page
  # include Widget

  # Returns the first ResetPasswordPage child.
  def reset_password_page
    @reset_password_page ||= children.detect do |child|
      child.is_a?(ResetPasswordPage)
    end
  end
end