class BandsController < ApplicationController
    #* SECTION user interface
    def index
        @bands = Band.all
        render :index
    end
    def show
        @band = Band.find_by(id: params[:id])
        render :show
    end    
    def new
        render :new
    end
    def edit
        @band = Band.find_by(id: params[:id])        
        render :edit
    end
    #* SECTION API
    def create
        @band = Band.new(band_params)
        if @band.save
            redirect_to band_url(@band.id)
        else
            render :new
        end
    end
    def update
        @band = Band.find_by(id: params[:id])
        if @band.update(band_params)
            redirect_to band_url(@band.id)
        else
            render :edit
        end
    end
    def destroy
        @band = Band.find_by(id: params[:id])
        @band.destroy!
        render :index
    end
    #* SECTION helpers
    private
    def band_params
        params.require(:band).permit(:name)
    end
end
