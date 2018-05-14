require 'rails_helper'

describe 'User visits all categories page' do
  scenario 'a user can see all categories' do
    category1 = Category.create(title: 'Developer')
    category2 = Category.create(title: 'Sewer Scrubber')

    visit categories_path

    expect(page).to have_content(category1.title)
    expect(page).to have_content(category2.title)
  end

  scenario 'a user delete from that page' do
    category = Category.create(title: 'Sewer Scrubber')

    visit categories_path

    within(".category_#{category.id}") do
      click_link "Delete"
    end

    message = "#{category.title} was successfully deleted!"
    expect(page).to have_content(message)
    expect(page).to_not have_link(category.title)
  end
  # link to edit
end
