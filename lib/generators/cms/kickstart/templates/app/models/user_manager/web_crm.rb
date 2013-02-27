module UserManager
  class WebCrm
    # Authenticates a login and password pair against the user manager.
    def authenticate(login, password)
      contact = Infopark::Crm::Contact.authenticate(login, password)

      create_user(contact.attributes)
    rescue Infopark::Crm::Errors::AuthenticationFailed, ActiveResource::ResourceInvalid
      raise AuthenticationFailed.new
    end

    # Checks if the user is an admin or not.
    def admin?(user)
      user.role_names.include?('cmsadmin')
    end

    # Finds a remote user with the given id and provides an application user in
    # return.
    def find_user(id)
      contact = find(id)

      create_user(contact.attributes)
    end

    # Creates a new using and prefills it with the given attributes. As a new
    # user needs an ID, it has to be provided in the attributes.
    def create_user(attributes)
      user = User.new(id: attributes.delete(:id))

      mapper.update(user, attributes)
    end

    # Saves the given user attributes at the remote user.
    def save_user(user)
      contact = find(user.id)

      mapper.save(contact, user.attributes)
    end

    # Updates the given user with attributes from the remote user.
    def update_user(user)
      contact = find(user.id)

      mapper.update(user, contact.attributes)
    end

    private

    # Retrieves a remote user model given an identifying id.
    def find(id)
      Infopark::Crm::Contact.find(id)
    rescue ActiveResource::ResourceNotFound
      raise UserNotFound.new
    end

    # Holds the mapper specific to this user manager.
    def mapper
      @mapper ||= WebCrmMapper.new
    end
  end
end