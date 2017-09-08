module Api
  module V1
    class PostsController < ApplicationController
      before_action :authenticate

      def index
        @posts = @athorized.posts

        render json: @posts
      end

      def show
        @post = @athorized.posts.find_by_id(params[:id])

        if @post
          render json: @post
        else
          render json: {post: "not found"}, status: :not_found
        end
      end

      def create
        @post = @athorized.posts.new(post_params)
        if @post.save
          render json: @post, status: :created
        else
          render json: @post.errors, status: :unprocessable_entity
        end
      end

      def update
        @post = @athorized.posts.find_by_id(params[:id])

        if @post
          if @post.update_attributes(post_params)
            render json: @post, status: :ok
          else
            render_error(@post, :unprocessable_entity)
          end
        else
          render json: {post: "not found"}, status: :not_found
        end


      end

      def destroy
        @post = @athorized.posts.find_by_id(params[:id])
        if @post
          @post.destroy
        else
          render json: {post: "not found"}, status: :not_found
        end
      end

      private

      def post_params
        params.require(:post).permit(:title, :body, :user_id)
      end

    end
  end
end