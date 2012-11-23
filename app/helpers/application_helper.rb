module ApplicationHelper
  def full_title(page_title)
    base_title = "Partymeter App"
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end

  def show_header_link?(show_link)
    show_link.empty? ? false : true
  end
end
