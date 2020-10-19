require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    before do
        @category = Category.create(name: 'Cats')
    end

    it 'validates a valid product' do 
      @product = Product.create(name: 'Fatima', price: 100000, quantity:1, category_id:@category.id )
      expect(@product.errors.full_messages.length).to be 0
    end

    it 'validates that the name is present' do 
      @product = Product.create(price: 100000, quantity:1, category_id:@category.id)
      expect(@product.errors.full_messages.length).to be >= 1
    end

    it 'validates that the price is present' do 
      @product = Product.create(name: 'Fatima', quantity:1, category_id:@category.id)
      expect(@product.errors.full_messages.length).to be >= 1
    end

    it 'validates that the quantity is present' do 
      @product = Product.create(name: 'Fatima', price: 100000, category_id:@category.id )
      expect(@product.errors.full_messages.length).to be >= 1
    end

    it 'validates that the category is present' do 
      @product = Product.create(name: 'Fatima', price: 100000, quantity:1)
      expect(@product.errors.full_messages.length).to be >= 1
    end
  end
end
