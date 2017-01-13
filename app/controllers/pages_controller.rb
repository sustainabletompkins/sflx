class PagesController < ApplicationController

  def home
    @categories = Category.all
    @listings = Listing.last(10)

  end

  def map
    @categories = Category.all
    @category = Category.find_by_name(params[:category])
    @lists = @category.lists
    @listings = @category.listings
    @hash = []
    @info = []
    @listings.each do |l|
      arr = [l.title, l.latitude, l.longitude]
      @info << ["<div class='info_content'><h3>#{l.title}</h3><p>#{l.description}</p><div class='website'><a href='#{l.website}'>#{l.website}</a></div></div>".html_safe]
      @hash << arr
    end
    puts @info
  end

  def admin
    @categories = Category.all
    @listing = Listing.new
    @tags = ActsAsTaggableOn::Tag.all
  end


end
