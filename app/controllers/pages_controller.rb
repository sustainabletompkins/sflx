class PagesController < ApplicationController

  def home
    @categories = Category.all

    @listings = Listing.all
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
