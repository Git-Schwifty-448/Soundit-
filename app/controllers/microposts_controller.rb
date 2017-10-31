class MicropostsController < ApplicationController
    before_action :logged_in_user, only: [:create, :destroy]
    
    def create
        @micropost = current_user.microposts.build(micropost_params)
        @micropost.score = 1
        if @micropost.save
          flash[:success] = "Micropost created!"
          redirect_to root_url
        else
          render 'static_pages/home'
        end
    end

    def show
      @micropost = Micropost.find(params[:id])
      @user = User.find(@micropost.user_id)

    end
    
    
      def destroy
      end

      def new
        @micropost = current_user.microposts.build if logged_in?
      end

      private
      
          def micropost_params
            params.require(:micropost).permit(:content,:title,:url,:genre)
          end
end