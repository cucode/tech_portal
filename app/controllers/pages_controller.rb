class PagesController < ApplicationController

  def show
    url = params[:url] || "/"
    text = Page.find_by_url(url).try(:content)
    text ||= "Page not found"
    render text: text.html_safe, layout: true
  end

end
