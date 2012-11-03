module CitiesHelper
	def gravatar_for(city, options = { size: 50 })
		size = options[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/1?s=#{size}"
    image_tag(gravatar_url, alt: city.name, class: "gravatar")
  end
end
