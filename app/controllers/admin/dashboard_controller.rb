class Admin::DashboardController < ApplicationController
  def show
    @product_count = Product.count(:all)
    @category_count = Category.count(:all)
    @categories_all = Category.all
  end
end
