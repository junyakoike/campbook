class SpotsController < ApplicationController

    before_action :authenticate_user!, only: [:new, :create]

     def index
        @spots = Spot.all
        if params[:search] == nil
          @spots= Spot.all
        elsif params[:search] == ''
          @spots= Spot.all
        else
          @spots = Spot.where("place LIKE ? ",'%' + params[:search] + '%')
          @place = params[:search]
        end

     end
      def new
        @spot = Spot.new
      end

      def show
        @spot = Spot.find(params[:id])
        @comments = @spot.comments
        @comment = Comment.new
      end

      def edit
        @spot = Spot.find(params[:id])
      end

      def update
        spot = Spot.find(params[:id])
        if spot.update(spot_params)
          redirect_to :action => "show", :id => spot.id
        else
          redirect_to :action => "new"
        end
      end

    
      def create
        spot = Spot.new(spot_params)
        spot.user_id = current_user.id 
        if spot.save!
          redirect_to :action => "index"
        else
          redirect_to :action => "new"
        end
      end

      def destroy
        spot = Spot.find(params[:id])
        spot.destroy
        redirect_to action: :index
      end
    
      private
      def spot_params
        params.require(:spot).permit(:name, :chara, :access, :image,:place, :lat, :lng)
     #ここまで
      end 
    end
