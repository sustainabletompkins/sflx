class PagesController < ApplicationController

  def home
    @categories = Category.all
  end

  def admin
    @listing = Listing.new
  end


end
