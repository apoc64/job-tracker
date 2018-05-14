require 'rails_helper'

describe 'User creates a new category' do
  scenario 'a user can navigate to create category page' do
    visit categories_path

    click_link 'add a new category'

    expect(current_path).to eq(new_category_path)
  end

  scenario 'when clicking create button after filling in category title form' do
    title = 'Developer'

    visit new_category_path

    fill_in 'category[title]', with: title
    click_button 'Create'

    expect(current_path).to eq(category_path(Category.last.id))
    expect(page).to have_content(title)
  end

  describe 'user cannot create a category without a title' do
    scenario 'when user clicks link to create with blank category title' do
      error = 'You must enter a title for your category!'

      visit new_category_path

      click_button 'Create'

      expect(current_path).to eq(new_category_path)
      expect(page).to have_content(error)
    end
  end
end
