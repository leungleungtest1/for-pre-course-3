class Admin::UserpaymentrecordsController < AdminController
  def show
    @payments = Payment.all
  end
end