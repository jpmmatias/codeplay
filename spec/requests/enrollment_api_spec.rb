require 'rails_helper'

describe 'Enrollment API' do
  context 'GET /api/v1/enrollments' do
    it 'should get enrollments courses' do
      intructor = create(:instructor)
      course = create(:course, instructor: intructor)
      course2 = create(:course, instructor: intructor)
      student = create(:student)

      enrollment = Enrollment.create(course: course, student: student, price: course.price)
      enrollment2 = Enrollment.create(course: course, student: student, price: course2.price)
      #   enrollment = create(:enrollment, course: course, student: student, price: course.price)
      #   enrollment2 = create(:enrollment, course: course2, student: student, price: course2.price)

      get '/api/v1/enrollments'

      expect(response).to have_http_status(200)
      expect(response.content_type).to include('application/json')
      parsed_body = JSON.parse(response.body)
      expect(parsed_body.count).to eq(Enrollment.count)

      expect(parsed_body[0]['course']).to eq('Ruby')
      expect(parsed_body[1]['course']).to eq('Ruby on Rails')

      expect(parsed_body[0]['student']).to eq('email@gmail.com')
      expect(parsed_body[1]['student']).to eq('email@gmail.com')

      expect(parsed_body[0]['price']).to  eq(course.price)
      expect(parsed_body[1]['price']).to  eq(course2.price)
    end
  end
end
