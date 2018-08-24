require 'csv'
class ProductsController < ApplicationController
  def list
    get_data
  end

  def detail
    get_data

    @product = @products.find {|p| p.pid == params[:id]}
  end

  def get_data
    @products = []

    CSV.foreach(Rails.root + "csv/faust_inventory.csv", headers: true) do |row|
      product = Product.new  
      product.pid = row.to_h["pid"]
      product.item = row.to_h["item"]
      product.description = row.to_h["description"]
      @products << product
    end
  end
end
