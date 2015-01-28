module ApplicationHelper
  def display_datetime(dt)
    dt.strftime("%d %b %Y")
  end

  def friendly_url(url)
    url.start_with?('http://') ? url : "http://#{url}"
  end
end
