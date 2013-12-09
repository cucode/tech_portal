class PagesController < ApplicationController
  layout "application"

  def show
    url = params[:url] || "/tiles"

    view_path = "app/views/pages#{url}.html.slim"
    if File.exist?(view_path)
      render file: view_path
    elsif @page = Page.find_by_url(url)
      render
    else
      render text: "Page not found", layout: true
    end
  end

end
