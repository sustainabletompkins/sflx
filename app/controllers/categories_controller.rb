class CategoriesController < ApplicationController

  respond_to :html

  def show
    @category = Category.find(params[:id])
    @listings = @category.listings
    puts @listings
    @hash = []
    @info = []
    @listings.each do |l|
      arr = [l.title, l.latitude, l.longitude]
      @info << ["<div class='info_content'><h3>#{l.title}</h3><p>#{l.description}</p><div class='website'><a href='#{l.website}'>#{l.website}</a></div></div>".html_safe]
      @hash << arr
    end
  end
end
