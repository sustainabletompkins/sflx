class CountiesController < ApplicationController

  respond_to :html

  def show
    @county = County.find_by_county(params[:id])
    @places = @county.places
    @listings = @county.listings.approved.order(title: :asc)
    @hash = []
    @info = []
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
    @title = "#{@county.county}"
    @breadcrumb = "<a href='/map/all'>All</a> > <a href='/map/county/#{@county.county}'>#{@county.county}</a>".html_safe
    @url = "/map/county/#{@county.county}"
  end
end
