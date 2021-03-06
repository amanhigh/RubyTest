module ApplicationHelper
  def full_title(title)
    base_title = "Ruby on Rails Tutorial Sample App"
    if title.blank?
      base_title
    else
      "#{base_title} | #{title}"
    end
  end

  def logo
    image_tag('logo.png', :alt => 'Sample App', :class => 'round')
  end
end
