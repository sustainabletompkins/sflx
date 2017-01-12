class ListsController < ApplicationController

  respond_to :html

  def show
    @list = List.find(params[:id])
    @listings = @list.listings
    @hash = []
    @info = []
    @listings.each do |l|
      arr = [l.title, l.latitude, l.longitude]
      @info << ["<div class='info_content'><h3>#{l.title}</h3><p>#{l.description}</p><div class='website'><a href='#{l.website}'>#{l.website}</a></div></div>".html_safe]
      @hash << arr
    end
  end
end
