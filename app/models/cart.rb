# PORO = Plain Old Ruby Object
class Cart
  attr_reader :items

  def initialize(items = [])
    @items = items
  end

  def self.from_hash(hash = nil)
    # {
    #   "items" => [
    #     {"sku_id" => 1, "quantity" => 3},
    #     {"sku_id" => 2, "quantity" => 2}
    #   ]
    # }

    if hash && hash["items"]
      items = hash["items"].map { |item|
        CartItem.new(item["sku_id"], item["quantity"])
      }
      Cart.new(items)
    else
      Cart.new
    end
  end

  def serialize
    # items = [
    #   {"sku_id" => 1, "quantity" => 3},
    #   {"sku_id" => 2, "quantity" => 2}
    # ]

    items = @items.map { |item| {"sku_id" => item.sku_id,
                                 "quantity" => item.quantity} }

    { "items" => items }
  end

  def add_sku(sku_id)
    found = @items.find { |item| item.sku_id == sku_id }

    if found
      found.increment!
    else
      @items << CartItem.new(sku_id)
    end
    # 找...
  end

  def empty?
    @items.empty?     # 陣列內建 empty? 方法
  end

  def total_price
    # total = 0

    # @items.each do |item|
    #   total += item.total_price
    # end

    # total

    # 上面的寫法不夠 Ruby
    @items.reduce(0) { |sum, item| sum + item.total_price }
  end
end