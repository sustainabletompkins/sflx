class PagesController < ApplicationController

  def home
    @categories = Category.all
  end

  def admin

  end


end
