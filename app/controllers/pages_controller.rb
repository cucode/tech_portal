class PagesController < ApplicationController
  def show
    page = Page.find_by_url(params[:url] || '/')
    render text: page.content.html_safe, layout: true
  end
end