class Box::BoxContactCell < BoxCell
  cache(:show, if: proc {|cell, page, box| cell.session[:live_environment]}) do |cell, page, box|
    [
      RailsConnector::Workspace.current.revision_id,
      box.id,
    ]
  end

  def show(page, box)
    @contact = box.contact

    full_name = []
    full_name.push(@contact.first_name) if @contact.first_name.present?
    full_name.push(@contact.last_name) if @contact.last_name.present?
    @full_name = full_name.join(" ")

    if @contact.email.present?
      hash = Digest::MD5.hexdigest(@contact.email)
      @avatar = "http://www.gravatar.com/avatar/#{hash}?d=mm"
    end

    super
  end
end