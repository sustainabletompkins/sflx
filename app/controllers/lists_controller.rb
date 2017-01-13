class ListsController < ApplicationController

  respond_to :html

  def show
    @list = List.find(params[:id])
    @listings = @list.listings
    @tag_ids = ActsAsTaggableOn::Tagging.joins("INNER JOIN tags ON tags.id = tag_id").where('taggable_id in (?)',@listings.map(&:id)).map(&:tag_id)
    puts @tag_ids
    @tag_ids=@tag_ids.uniq
    @tags=ActsAsTaggableOn::Tag.where('id IN (?)',@tag_ids)
    puts @tags
    @hash = []
    @info = []
    @listings.each do |l|
      arr = [l.title, l.latitude, l.longitude]
      @info << ["<div class='info_content'><h3>#{l.title}</h3><p>#{l.description}</p><div class='website'><a href='#{l.website}'>#{l.website}</a></div></div>".html_safe]
      @hash << arr
    end
  end

  def tagged
    @list = List.find(params[:id])
    @listings = @list.listings.tagged_with(params[:tag])
    @hash = []
    @info = []
    @listings.each do |l|
      arr = [l.title, l.latitude, l.longitude]
      @info << ["<div class='info_content'><h3>#{l.title}</h3><p>#{l.description}</p><div class='website'><a href='#{l.website}'>#{l.website}</a></div></div>".html_safe]
      @hash << arr
    end
  end
end
