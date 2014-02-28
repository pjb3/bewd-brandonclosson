class Class

  def add(info = {})
    #create products array if not already created
    @products ||= []
    #create a new instance of Product w/ Product.add params, push to @products
    @products << Product.new(info[:name], info[:price])
  end
  
  def find_product(name)
    #make sure products array is AT LEAST empty
    @products ||= []
    #search @products for instance of Product matching name param
    @products.find{|product| product.name == name} || Product.not_found(name, "product")
  end

  def not_found(name, type)
    puts "#{name} is not a valid #{type}."
  end

end

class Product
  
  attr_accessor :name, :price

  def initialize(name, price)
    @name = name
    @price = price
  end

end

class LineItem

  def initialize(quantity, name)
    #search Class::products for a Product where Product.name == name
    @product = Product.find_product(name) 
    @quantity = quantity
  end

  def calculate_subtotal
    @product.price * @quantity
  end

end

class Order

  attr_accessor :tax_rate

  def initialize(rates = {tax_rate: 0})
    #initialize tax_rate, add 1 for easier equations later
    @tax_rate = rates[:tax_rate] + 1
  end

  def add(quantity, name)
    @line_items ||= []
    #create new instance of LineItem using Order.add params, push to @line_items
    #if the product does not exist, the item will not be added to the array
    @line_items << LineItem.new(quantity, name) unless !Product.find_product(name)
  end

  def total_price
    #initial total is equal to the sum of the prices of each line item in @line_items
    @total = @line_items.reduce(0) {|sum, item| sum + item.calculate_subtotal}
    
    (@total * @tax_rate).round(2)  
  end

end
