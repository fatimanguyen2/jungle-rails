require 'rails_helper'

RSpec.feature "ProductDetails", type: :feature, js: true do
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

  scenario "They see all products, click on first product and is redirect to product page" do
    # ACT
    visit root_path
    save_screenshot 'test2a.png'
    
    # DEBUG / VERIFY
    first('.pull-right').click
    sleep(1)
    save_screenshot 'test2b.png'
    expect(page).to have_css '.product-detail', count: 1
  end

end