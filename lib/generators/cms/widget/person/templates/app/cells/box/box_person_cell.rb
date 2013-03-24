class Box::BoxPersonCell < BoxCell
  # Cell actions:

  def show(page, box)
    @person = box.person

    if @person
      super(page, box)
    end
  end

  # Cell states:
  # The following states assume @person to be given.

  def name
    @first_name = @person.first_name
    @last_name = @person.last_name

    if @first_name.present? || @last_name.present?
      render
    end
  end

  def email
    @email = @person.email

    if @email.present?
      render
    end
  end
end