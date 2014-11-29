class CategoryController < ApplicationController
  before_action :require_log_in
  def show
    @category = Category.find params[:id]
  end
  
end