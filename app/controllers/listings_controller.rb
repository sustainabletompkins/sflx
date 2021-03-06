class ListingsController < ApplicationController

  respond_to :html, :js

  before_action :authenticate_user!, :except => [:search,:autocomplete_tags, :autocomplete_search,:filter]

  def create

    require 'uri'

    @listing = Listing.create(listing_params)
    current_user.listings << @listing
    address_chunks = @listing.address.split(',')
    @listing.address = address_chunks[0] + ', ' + address_chunks[1]
    @listing.active = true if current_user.email == 'info@sustainablefingerlakes.org'
    slug = @listing.title.downcase.gsub(/['&+.\/]/,'').gsub('  ',' ').gsub(' ','-')
    @listing.slug = slug
    if @listing.save
      p = Place.where(:zipcode=>@listing.zip_code)
      if p.first.present?
        p.first.listings << @listing
      else
        county = @listing.county
        city = @listing.city
        zip = @listing.zip_code
        new_county = County.where(:county=>county).first
        new_place = Place.where(:city=>city).first
        if new_county.present?
        else
          new_county = County.create(:county=>county)

        end
        if new_place.present?

        else
          new_place = Place.create(:city=>city, :zipcode=>zip, :county_id => new_county.id)


        end
        new_place.listings << @listing
      end
      redirect_to URI.encode("/map/listing/#{@listing.slug}")
    else
      render :new
    end
  end

  def show
    @listing = Listing.find_by_slug(params[:id])
    set_meta_tags title: "#{@listing.title} | Sustainable Finger Lakes", description: "#{@listing.description.truncate(50, separator: ' ')}",keywords: "#{@listing.tag_list}"


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
      address_chunks = @listing.address.split(',')
      @listing.address = address_chunks[0] + ', ' + address_chunks[1]
      slug = @listing.title.downcase.gsub(/['&+.\/]/,'').gsub('  ',' ').gsub(' ','-')
      @listing.slug = slug
      @listing.save
      render 'edited'
    end
  end

  def filter
    @breadcrumb = "<a href='/map/all'>All</a>"

    if params[:county] == 'all' || !params.has_key?(:county)
      @listings = Listing.approved.order(title: :asc)
    else
      @county = County.find_by_county(params[:county])
      @places = @county.places
      @listings = @county.listings.approved.order(title: :asc)
      @title = "#{@county.county}"
      @breadcrumb << " > <a href='/map/county/#{@county.county}'>#{@county.county}</a>"
      @url = "/map/county/#{@county.county}"
    end


    if params[:category] == 'all' || !params.has_key?(:category)
      @cat_listings = Listing.approved.order(title: :asc)
      @breadcrumb << " > <a href='/map'>All</a>"
      @url = "/map"
      @listings = @listings & @cat_listings
      @lists = List.all
    else
      @category = Category.find_by_slug(params[:category])
      @lists = @category.lists.approved
      @title = "#{@category.name}"
      @breadcrumb << " > <a href='/map/category/#{@category.slug}'>#{@category.name}</a>"
      @cat_listings = @category.listings.approved.order(title: :asc)
      @url = "/map/category/#{@category.slug}"
      @listings = @listings & @cat_listings

    end

    if params[:list] == '' || !params.has_key?(:list)
      @list_listings = Listing.approved.order(title: :asc)
      @listings = @listings & @list_listings
      @list = List.new
      @list.id = 0
    else
      @list = List.find_by_slug(params[:list])
      @title = "#{@list.name}"
      cat = @category.present? ? @category.slug : 'all'
      @breadcrumb << " > <a href='/map/category/#{cat}/#{@list.slug}'>#{@list.name}</a>"
      @list_listings = @list.listings.approved.order(title: :asc)
      @url = "/map/category/#{cat }/#{@list.slug}"
      @listings = @listings & @list_listings

    end
    @hash = []
    @info = []
    @listings.each do |l|
      arr = [l.title, l.latitude, l.longitude]
      html = "<div class='info_content' data-listing-id='#{l.id}'><h3>#{l.title}</h3><p>#{l.description}</p>"
      html += "<div class='address'><span>#{l.address}</span>"
      html += "<div class='website'><a href='#{l.website}'>#{l.website}</a></div></div>" if l.website.present?
      html += "<div class='phone'><a href='tel:+1#{l.phone.gsub(/\D/, "")}'>#{l.phone}</a></div></div>" if l.phone.present?
      html += "<div class='email'><a href='mailto:#{l.email}' target='_blank'>#{l.email}</a></div></div>" if l.email.present?
      @info << [html.html_safe]
      @hash << arr
    end

    @breadcrumb = @breadcrumb.html_safe
    puts @breadcrumb

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
      suggestions << {:name=>"##{p.name}", :type=>'tag', :slug=>"/map/tag/#{p.name}"}
    end
    places = Place.where("zipcode LIKE (?) OR city LIKE (?)","#{input}%","#{input}%")
    places.each do |p|
      suggestions << {:name=>p.city.titleize, :type=>'place', :slug=>"/map/place/#{p.city}"}
    end
    lists = List.where("name ILIKE (?)","%#{input}%")
    lists.each do |p|
      suggestions << {:name=>p.name, :type=>'list', :slug=>"/map/category/#{p.category.slug}/#{p.slug}"}
    end

    cats = Category.where("name ILIKE (?)","%#{input}%")
    cats.each do |p|
      suggestions << {:name=>p.name, :type=>'category', :slug=>"/map/category/#{p.slug}"}
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
      html = "<div class='info_content' data-listing-id='#{l.id}'><h3>#{l.title}</h3><p>#{l.description}</p>"
      html += "<div class='address'><span>#{l.address}</span>"
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
