class PagesController < ApplicationController
  layout "application"

  def show
    url = params[:url] || "/tiles"

    view_path = "app/views/pages#{url}.html.slim"
    if File.exist?(view_path)
      render file: view_path
    else
      text = Page.find_by_url(url).try(:content)
      text ||= "Page not found"
      render text: text.html_safe, layout: true
    end
  end

end
