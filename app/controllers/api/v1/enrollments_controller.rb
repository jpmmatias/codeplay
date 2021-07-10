module Api
  module V1
    class EnrollmentsController < ApiController
      def index
        @enrollments = Enrollment.all
        render json: @enrollments
        .as_json(
                 include: %i[student course])
      end
    end
  end
end
