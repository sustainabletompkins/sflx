class PagesController < ApplicationController

  http_basic_authenticate_with :name => "admin", :password => "309NAurora", :only => [:admin, :list]
  before_action :authenticate_user!, :only => [:list, :admin]

  def home
    @categories = Category.all
    @listings = Listing.last(10).reverse
    render :layout => 'landing'
  end

  def list
    @listings = Listing.order(title: :asc)
  end

  def test
    @listings = Listing.where(:zip_code=>nil)
    @counties = County.left_joins(:listings).group(:id).order('COUNT(listings.id) DESC')
  end

  def map
    @categories = Category.all

    @listings = []
    if params.has_key?(:list)
      list = List.find_by_slug(params[:list])
      @listings = list.listings.approved.order(title: :asc)
      @category = Category.find_by_slug(params[:category])
      @lists = @category.lists.approved
      @title = "[#{@category.name}] #{list.name} Listings"
      @breadcrumb = "<a href='/map/all'>All</a> > <a href='/map/category/#{@category.slug}'>#{@category.name}</a> > <a href='/map/category/#{@category.slug}/#{list.slug}'>#{list.name}</a>".html_safe

    elsif params.has_key?(:category)
      @category = Category.find_by_slug(params[:category])
      @listings = @category.listings.approved.order(title: :asc)
      @title = "#{@category.name} Listings"
      @breadcrumb = "<a href='/map/all'>All</a> > <a href='/map/category/#{@category.slug}'>#{@category.name}</a>".html_safe

      @lists = @category.lists.approved
    elsif params.has_key?(:city)
      @listings = Listing.approved.where('city ILIKE (?)',"#{params[:city]}%").order(title: :asc)
      @title = "#{params[:city]} Listings"
      @breadcrumb = "<a href='/map/all'>All</a> > <a href='/map/place/#{params[:city]}'>#{params[:city].titleize}</a>".html_safe
    elsif params.has_key?(:county)
      @county = County.find_by_county(params[:county])
      @listings = @county.listings
      @title = "#{params[:county]} Listings"
      @breadcrumb = "<a href='/map/all'>All</a> > <a href='/map/county/#{params[:county]}'>#{params[:county].titleize}</a>".html_safe

    elsif params.has_key?(:tag)
      @listings = Listing.approved.tagged_with(params[:tag]).order(title: :asc)
      @title = "##{params[:tag]} Listings"
      @breadcrumb = "<a href='/map/all'>All</a> > <a href='/map/tag/#{params[:tag]}'>##{params[:tag]}</a>".html_safe
    elsif params.has_key?(:listing)
      @listings = Listing.where(:slug=>params[:listing])
      puts @listings.first
      place = @listings.first.place
      @title = "#{params[:listing]}"
      @breadcrumb = "<a href='/map/all'>All</a> > <a href='/map/place/#{place.city}'>#{place.city}</a> > <a href='/map/listing/#{params[:listing]}'>##{@listings.first.title}</a>".html_safe
    else
      @listings = Listing.approved
      @title = "All Finger Lakes Sustainability Listings"
      @breadcrumb = "<a href='/map/all'>All</a>".html_safe
    end



    @hash = []
    @info = []
    if @listings.count > 0
      @listings.each do |l|
        arr = [l.title, l.latitude, l.longitude]
        html = "<div class='info_content'><h3>#{l.title}</h3><p>#{l.description}</p>"
        html += "<div class='address'><span>#{l.address}</span>"
        html += "<div class='website'><a href='#{l.website}'>#{l.website}</a></div></div>" if l.website.present?
        html += "<div class='phone'><a href='tel:+1#{l.phone.gsub(/\D/, "")}'>#{l.phone}</a></div></div>" if l.phone.present?
        html += "<div class='email'><a href='mailto:#{l.email}' target='_blank'>#{l.email}</a></div></div>" if l.email.present?
        @info << [html.html_safe]
        @hash << arr
      end
    end
  end

  def admin
    @categories = Category.all
    @listing = Listing.new
    @tags = ActsAsTaggableOn::Tag.all
    @count = Listing.all.count
  end


end
