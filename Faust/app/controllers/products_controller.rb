require 'csv'
class ProductsController < ApplicationController

  def list
    quantity
    get_data
    
    
  end

  def detail
    get_data
    
    @product = @products.find {|p| p.pid == params[:id]}
  end

  def clearance
    get_data
   
    @products.each do |product|
      if product.condition == "good" then
        product.price = product.price.to_i * 0.9
      elsif product.condition == "average" then
        product.price = product.price.to_i * 0.8
      else
        product.price
      end
    end
  end

  def quantity
    get_data
    @zero_qty = false
    @products.each do |product|
      if product.quantity == 0 then
        @zero_qty = true
      else
        @zero_qty = false
      end
    end
  end

  def get_data
    @products = []
    
    CSV.foreach(Rails.root + "csv/faust_inventory.csv", headers: true) do |row|
      product = Product.new  
      product.pid = row.to_h["pid"]
      product.item = row.to_h["item"]
      product.description = row.to_h["description"]
      product.price = row.to_h["price"]
      product.condition = row.to_h["condition"]
      product.dimension_w = row.to_h["dimension_w"]
      product.dimension_l = row.to_h["dimension_l"]
      product.dimension_h = row.to_h["dimension_h"]
      product.img_file = row.to_h["img_file"]
      product.quantity = row.to_h["quantity"]
      product.category = row.to_h["category"]
      @products << product
    end
  end
end
