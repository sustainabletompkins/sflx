class PagesController < ApplicationController

  def home
    @categories = Category.all
    @listings = Listing.last(10).reverse
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
      html = "<div class='info_content'><h3>#{l.title}</h3><p>#{l.description}</p>"
      html += "<div class='website'><a href='#{l.website}'>#{l.website}</a></div></div>" if l.website.present?
      html += "<div class='phone'><a href='tel:+1#{l.phone.gsub(/\D/, "")}'>#{l.phone}</a></div></div>" if l.phone.present?
      html += "<div class='email'><a href='mailto:#{l.email}' target='_blank'>#{l.email}</a></div></div>" if l.email.present?
      @info << [html.html_safe]
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
