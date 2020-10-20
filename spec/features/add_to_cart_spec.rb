require 'rails_helper'

RSpec.feature "AddToCarts", type: :feature, js: true do
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
  name:  Faker::Hipster.sentence(3),
  description: Faker::Hipster.paragraph(4),
  image: open_asset('apparel1.jpg'),
  quantity: 10,
  price: 64.99
)
    end
  end

  scenario "visit the home page and click 'Add to Cart' buttons for one of the products" do
    visit root_path
    save_screenshot 'test3a.png'

    expect(page).to have_text 'My Cart (0)', count: 1
    
    first('.btn-primary').click
    sleep(1)
    save_screenshot 'test3b.png'

    expect(page).to have_text 'My Cart (1)', count: 1
  end
end
