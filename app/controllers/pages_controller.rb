class PagesController < ApplicationController
  def show
    text = (Page.find_by_url(params[:url] || "/").try(:content).try(:html_safe)) || "Page not found"
    render text: text, layout: true
  end
end