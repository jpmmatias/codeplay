require 'rails_helper'

describe 'Admin registers lessons' do
  it 'successfully' do
    instructor = Instructor.create!(name: 'Fulano Sicrano',
                                    email: 'fulano@codeplay.com.br')
    course = Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                            code: 'RUBYBASIC', price: 10,
                            enrollment_deadline: '22/12/2033', instructor: instructor)

    user_login
    visit admin_course_path(course)
    click_on 'Registrar uma aula'
    fill_in 'Nome', with: 'Duck Typing'
    fill_in 'Duração', with: '10'
    fill_in 'Conteúdo', with: 'Uma aula muito legal'
    click_on 'Cadastrar'

    expect(page).to have_text('Duck Typing')
    expect(page).to have_text('10 minutos')
    expect(page).to have_text('Aula cadastrada com sucesso')
    expect(current_path).to eq(admin_course_path(course))
  end

  it 'and fill and fields' do
    instructor = Instructor.create!(name: 'Fulano Sicrano',
                                    email: 'fulano@codeplay.com.br')
    course = Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                            code: 'RUBYBASIC', price: 10,
                            enrollment_deadline: '22/12/2033', instructor: instructor)

    user_login
    visit admin_course_path(course)
    click_on 'Registrar uma aula'
    click_on 'Cadastrar'

    expect(page).to have_text('Nome não pode ficar em branco')
    expect(page).to have_text('Duração não pode ficar em branco')
    expect(page).to have_text('Conteúdo não pode ficar em branco')
  end

  it 'must be logged in to create lesson' do
    instructor = Instructor.create!(name: 'Fulano Sicrano',
                                    email: 'fulano@codeplay.com.br')
    course = Course.create!(name: 'Ruby', description: 'Um curso de Ruby',
                            code: 'RUBYBASIC', price: 10,
                            enrollment_deadline: '22/12/2033',
                            instructor: instructor)

    visit new_admin_course_lesson_path(course)

    expect(current_path).to eq(new_user_session_path)
  end
end
