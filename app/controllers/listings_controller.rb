class ListingsController < ApplicationController

  respond_to :html, :js

  before_action :authenticate_user!, :except => [:search,:autocomplete_tags]

  def create

    require 'uri'

    @listing = Listing.create(listing_params)
    current_user.listings << @listing
    @listing.address = @listing.address[0..-20]
    @listing.active = true if current_user.email == 'info@sustainablefingerlakes.org'
    if @listing.save
      redirect_to URI.encode("/map/#{@listing.lists.first.category.name}")
    else
      render :new
    end
  end

  def new
    @categories = Category.all
    @listing = Listing.new
    @tags = ActsAsTaggableOn::Tag.all.order(name: :asc)
  end

  def approve
    @listing = Listing.find(params[:id])
    @listing.active = true
    @listing.save
  end

  def edit
    @listing = Listing.find(params[:id])
    @categories = Category.all
    @tags = ActsAsTaggableOn::Tag.all.order(name: :asc)
  end

  def destroy
    @listing = Listing.find(params[:id])
    @listing.destroy
  end

  def update
    @listing = Listing.find(params[:id])
    if @listing.update_attributes(listing_params)
      render 'edited'
    end
  end

  def autocomplete_tags
    @tags = ActsAsTaggableOn::Tag.where("name LIKE (?)","%#{params[:q]}%")
    respond_to do |format|
      format.json { render :json => @tags.collect{|tag| {:id => tag.name, :name => tag.name}} }
    end
  end

  def autocomplete_search
    @suggestions = {}
    tags = ActsAsTaggableOn::Tag.where("name LIKE (?)","%#{params[:q]}%")
    puts tags.inspect
    places = Place.where("zip LIKE (?) OR city LIKE (?)","%#{params[:q]}%")
    puts places.inspect
    listings = Listing.where("title LIKE (?)","%#{params[:q]}%")
    puts listings.inspect
    respond_to do |format|
      format.json { render :json => @tags.collect{|tag| {:id => tag.name, :name => tag.name}} }
    end
  end

  def search
    @listings = Listing.where("lower(title) LIKE ? OR lower(description) LIKE ?", "%#{params[:q].downcase}%","%#{params[:q].downcase}%")
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
    @title = "Searches for #{params[:q]}"
  end
  private

  def listing_params
    params.require(:listing).permit(:user_id, :title, :description, :address, :latitude,:longitude, :city, :zipcode, :website, :phone, :email, :tag_list, list_ids:[])
  end
end
