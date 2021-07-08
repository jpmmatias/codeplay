module Api
  module V1
    class EnrollmentsController < ApiController
      def index
        @enrollments = Enrollment.all
        render json: @enrollments, status: :success
      end
    end
  end
end
