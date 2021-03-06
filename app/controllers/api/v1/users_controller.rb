module Api
  module V1
    class UsersController < ApplicationController
      before_action :authenticate, only: [:index, :show, :update, :destroy]
      before_action :set_user, only: [:show, :update, :destroy]

      def index
        @users = User.order('created_at DESC')

        render json: @users
      end

      def show
        render json: @user
      end

      def create
        @user = User.new(user_params)
        if @user.save
          render status: :created
        else
          render json: @user.errors, status: :unprocessable_entity
        end
      end

      def update
        if @user.update_attributes(user_params)
          render json: @user, status: :ok
        else
          render_error(@user, :unprocessable_entity)
        end
      end

      def destroy
        @user.destroy
        head 204
      end

      private

      def set_user
        begin
          @user = @athorized
        rescue ActiveRecord::RecordNotFound
          user = User.new
          user.errors.add(:id, "Wrong ID provided")
          render_error(user, 404) and return
        end
      end

      def user_params
        params.require(:user).permit(:name)
      end

    end
  end
end