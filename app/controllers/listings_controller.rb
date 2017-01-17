class ListingsController < ApplicationController

  respond_to :html

  def create

    @listing = Listing.create(listing_params)
    @listing.address = @listing.address[0..-20]
    if @listing.save
      redirect_to '/admin'
    else
      render :new
    end


  end

  def destroy
    @listing = Listing.unscoped.where(:slug=>params[:id]).first
    if @listing.destroy
      redirect_to listings_path
    end
  end

  def update
    @listing = Listing.unscoped.where(:slug=>params[:id]).first
    if @listing.update_attributes(listing_params)
      respond_with(@listing)
    end
  end


  private

  def listing_params
    params.require(:listing).permit(:user_id, :title, :description, :address, :latitude,:longitude, :city, :zipcode, :website, :phone, :email, :tag_list, list_ids:[])
  end
end
