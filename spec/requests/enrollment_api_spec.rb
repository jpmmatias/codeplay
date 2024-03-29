require 'rails_helper'

describe 'Enrollment API' do
  context 'GET /api/v1/enrollments' do
    it 'should get enrollments courses' do
      intructor = create(:instructor)
      course = create(:course, instructor: intructor)
      course2 = create(:course, instructor: intructor)
      student = create(:student)

      enrollment = Enrollment.create!(course: course, student: student, price: course.price)
      enrollment2 = Enrollment.create!(course: course, student: student, price: course2.price)
      #   enrollment = create(:enrollment, course: course, student: student, price: course.price)
      #   enrollment2 = create(:enrollment, course: course2, student: student, price: course2.price)

      get '/api/v1/enrollments'

      expect(response).to have_http_status(200)
      expect(response.content_type).to include('application/json')
      parsed_body = JSON.parse(response.body)
      expect(parsed_body.count).to eq(Enrollment.count)

      expect(parsed_body[0]['course']['name']).to eq(enrollment.course.name)
      expect(parsed_body[1]['course']['name']).to eq(enrollment2.course.name)

      expect(parsed_body[0]['student']['email']).to eq(enrollment.student.email)
      expect(parsed_body[1]['student']['email']).to eq(enrollment2.student.email)

      expect(parsed_body[0]['price']).to  eq(enrollment.price.to_f.to_s)
      expect(parsed_body[1]['price']).to  eq(enrollment2.price.to_f.to_s)
    end
  end
end
