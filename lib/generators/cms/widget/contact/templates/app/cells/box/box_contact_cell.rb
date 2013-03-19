class Box::BoxContactCell < BoxCell
  def show(page, box)
    @contact = box.contact

    super(page, box)
  end

  def contact(contact)
    full_name = []
    full_name << @contact.first_name
    full_name << @contact.last_name
    @full_name = full_name.compact.join(' ')

    if @contact.email.present?
      hash = Digest::MD5.hexdigest(@contact.email)
      @avatar = "http://www.gravatar.com/avatar/#{hash}?d=mm"
    end

    render
  end
end