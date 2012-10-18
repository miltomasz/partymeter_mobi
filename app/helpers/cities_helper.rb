module CitiesHelper
	def gravatar_for(city)
    gravatar_url = "https://secure.gravatar.com/avatar/1"
    image_tag(gravatar_url, alt: city.name, class: "gravatar")
  end
end
