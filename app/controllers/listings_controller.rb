class ListingsController < ApplicationController

  respond_to :html, :js

  before_action :authenticate_user!, :except => [:search,:autocomplete_tags, :autocomplete_search]

  def create

    require 'uri'

    @listing = Listing.create(listing_params)
    current_user.listings << @listing
    @listing.address = @listing.address[0..-20]
    @listing.active = true if current_user.email == 'info@sustainablefingerlakes.org'
    slug = @listing.title.downcase.gsub(/['&+]/,'').gsub('  ',' ').gsub(' ','-')
    @listing.slug = slug
    if @listing.save
      redirect_to URI.encode("/map/#{@listing.lists.first.category.name}")
    else
      render :new
    end
  end

  def show
    @listing = Listing.find_by_slug(params[:id])

    @title = "#{@listing.title}"
    @breadcrumb = "<a href='/map/all'>All</a> > <a href='/listings/#{@listing.slug}'>#{@listing.title}</a>".html_safe
    @url = "/listings/#{@listing.slug}"

    #render :json => {:markers => @hash.to_json, :info => @info.to_json}
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
    input = params[:q].downcase
    suggestions = []
    tags = ActsAsTaggableOn::Tag.where("name LIKE (?)","%#{input}%")
    tags.each do |p|
      suggestions << {:name=>"##{p.name}", :type=>'tag', :slug=>"map/tag/#{p.name}"}
    end
    places = Place.where("zipcode LIKE (?) OR city LIKE (?)","#{input}%","#{input}%")
    places.each do |p|
      suggestions << {:name=>p.city.titleize, :type=>'place', :slug=>"map/place/#{p.city}"}
    end
    lists = List.where("name ILIKE (?)","%#{input}%")
    lists.each do |p|
      suggestions << {:name=>p.name, :type=>'list', :slug=>"/map/category/#{p.category.name}/#{p.name}"}
    end

    cats = Category.where("name ILIKE (?)","%#{input}%")
    cats.each do |p|
      suggestions << {:name=>p.name, :type=>'category', :slug=>"/map/category/#{p.name}"}
    end
    suggestions = suggestions.uniq { |e| e[:name] }
    respond_to do |format|
      format.json { render :json => suggestions }
    end
  end

  def search
    @listings = Listing.approved.where("lower(title) LIKE ? OR lower(description) LIKE ?", "%#{params[:q].downcase}%","%#{params[:q].downcase}%").order(title: :asc)
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
    params.require(:listing).permit(:user_id, :title, :description, :address, :latitude,:longitude, :city, :zip_code, :county, :website, :phone, :email, :tag_list, list_ids:[])
  end
end
