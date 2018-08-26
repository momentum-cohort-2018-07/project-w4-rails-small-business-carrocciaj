require 'csv'
class ProductsController < ApplicationController
before_action :get_data
  def list  
    @products = @products.sort_by(&:category)
  end

  def detail
    @product = @products.find {|p| p.pid == params[:id]}
  end

  def table
    @product = @products.find {|p| "tables" == params[:cid]}
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
      if product.quantity.to_i > 0 then
      @products << product
      end
    end
  end
end
