require 'rails_helper'

describe 'User visits /categories' do
  scenario 'a user can see all categories' do
    category1 = Category.create(title: 'Developer')
    category2 = Category.create(title: 'Sewer Scrubber')

    visit categories_path

    expect(page).to have_content(category1.title)
    expect(page).to have_content(category2.title)
  end

  scenario 'a user can delete a category from index' do
    category = Category.create(title: 'Sewer Scrubber')

    visit categories_path

    within(".category_#{category.id}") do
      click_link "Delete"
    end

    message = "#{category.title} was successfully deleted!"
    expect(page).to have_content(message)
    expect(page).to_not have_link(category.title)
  end

  scenario 'can click an edit link to be sent to the category/id/edit page' do
    category = Category.create(title: 'Sewer Scrubber')

    visit categories_path

    within(".category_#{category.id}") do
      click_link "Edit"
    end

    expect(current_path).to eq(edit_category_path(category))
  end

  scenario 'can click a link showing number of jobs for category and be directed to show page for category' do
    category = Category.create(title: 'Sewer Scrubber')

    visit categories_path

    within(".category_#{category.id}") do
      click_link '0 jobs'
    end

    expect(current_path).to eq(category_path(category))
  end


end
