class BoxGallery < Obj
  include Cms::Attributes::GalleryImages
  include Cms::Attributes::GalleryAutoplay
  include Cms::Attributes::GalleryDelay
  include Cms::Attributes::SortKey
  include Box

  def autoplay
    if gallery_autoplay == 'Yes'
      _autoplay = true
    else
      _autoplay = false
    end

    _autoplay
  end

  def delay
  	_delay = gallery_delay
	_delay = 4000 if _delay.blank?

	_delay
  end

end