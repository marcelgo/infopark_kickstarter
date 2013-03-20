module BlogHelper
  def tag_path(blog, tag)
    "#{cms_path(blog)}?tag=#{tag}"
  end

  def tag_link_list(entry)
    links = entry.tags.inject([]) do |links, tag|
      links << link_to(tag, tag_path(entry.blog, tag))
    end

    (links * ' | ').html_safe
  end

  def rss_feed_path(obj)
    feed_path(obj, 'rss')
  end

  def atom_feed_path(obj)
    feed_path(obj, 'atom')
  end

  def tag_list_item_class(tags, current)
    if tags.include?(current)
      'active'
    end
  end

  private

  def feed_path(obj, type)
    path = "#{cms_path(obj.blog)}.#{type}"

    if RailsConnector::Workspace.current.id.eql?('rtc')
      path.concat('?_rc-ws=rtc')
    end
  end

  def user_image_service
    @user_image_service ||= ::UserImageService.new
  end

  def author_image(entry)
    user_id = entry.author_id
    path = user_image_service.image_path(user_id)

    image_tag(path)
  end

  def author_email(entry)
    email = entry.author.try(:email)
    name = author_name(entry)

    mail_to(email, name)
  end

  def author_name(entry)
    if entry.author.present?
      [
        entry.author.first_name,
        entry.author.last_name
      ].compact.join(' ')
    else
      ''
    end
  end
end