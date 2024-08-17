module Api
  class PublishersController < ApplicationController
    before_action :set_publisher, only: [ :show, :update, :destroy ]

    def index
      publishers = Publisher.all
      render json: publishers, include: :books
    end

    def show
      render json: @publisher, include: :books
    end

    def create
      publisher = Publisher.new(publisher_params)

      if publisher.save
        render json: publisher, status: :created
      else
        Rails.logger.info("Publisher creation failed: #{publisher.errors.full_messages}")
        render json: publisher.errors, status: :unprocessable_entity
      end
    end

    def update
      if @publisher.update(publisher_params)
        render json: @publisher
      else
        render json: @publisher.errors, status: :unprocessable_entity
      end
    end

    def destroy
      @publisher.destroy
    end

    private

    def set_publisher
      @publisher = Publisher.find(params[:id])
    end

    def publisher_params
      params.require(:publisher).permit(:name)
    end
  end
end
