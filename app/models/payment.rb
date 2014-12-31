class Payment < ActiveRecord::Base
  belongs_to :user

  def amount_in_dollars
    self.amount/100.0
  end
end