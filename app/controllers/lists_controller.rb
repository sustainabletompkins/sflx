class ListsController < ApplicationController

  respond_to :html

  def show
    @list = List.find(params[:id])
    @listings = @list.listings
    @tag_ids = ActsAsTaggableOn::Tagging.joins("INNER JOIN tags ON tags.id = tag_id").where('taggable_id in (?)',@listings.map(&:id)).map(&:tag_id)
    @tag_ids=@tag_ids.uniq
    @tags=ActsAsTaggableOn::Tag.where('id IN (?)',@tag_ids)
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
    @title = "#{@list.category.name} > #{@list.name}"
  end

  def tagged
    @list = List.find(params[:id])
    @listings = @list.listings.tagged_with(params[:tag])
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
    @title = "#{@list.category.name} > #{@list.name} > ##{params[:tag]}"
  end
end
