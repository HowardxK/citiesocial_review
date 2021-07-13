require 'rails_helper'

RSpec.describe Cart, type: :model do
  context "基本功能" do
    it "可以把商品丟到購物車裡，然後購物車裡就有東西了" do
      # AAA = Arrange, Act, Assert
      cart = Cart.new
      cart.add_item(2) # 加入 2 號商品
      expect(cart.empty?).to be false
    end

    it "加了相同種類的商品到購物車裡，購買項目(CartItem) 不會增加，但商品的數量會改變" do
      cart = Cart.new

      3.times { cart.add_item(1) }
      2.times { cart.add_item(2) }

      expect(cart.items.count).to be 2
      expect(cart.items.first.quantity).to be 3
    end

    it "商品可以放到購物車裡面，也可以再拿出來" do
      cart = Cart.new
      # v1 = Vendor.create(title: 'v1')
      # p1 = Product.create(name: 'p1', list_price: 100, sell_price: 10, vendor: v1)
      p1 = create(:product)

      cart.add_item(p1.id)
      
      expect(cart.items.first.product).to be_a Product
    end

    it "可以計算整台購物車的總消費金額" do
      cart = Cart.new
      p1 = create(:product, sell_price: 5)
      p2 = create(:product, sell_price: 10)

      3.times { cart.add_item(p1.id) }
      2.times { cart.add_item(p2.id) }

      expect(cart.total_price).to eq 35
    end
  end

  context "進階功能" do
    it "可以將購物車的內容轉換成 Hash 並存到 session 裡" do
      cart = Cart.new
      p1 = create(:product)
      p2 = create(:product)

      3.times { cart.add_item(p1.id) }
      2.times { cart.add_item(p2.id) }

      cart_hash = {
        "items" => [
          {"product_id" => 1, "quantity" => 3},
          {"product_id" => 2, "quantity" => 2}
        ]
      }

      expect(cart.serialize).to eq cart_hash
    end
  end
end