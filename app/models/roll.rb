class Roll < ApplicationRecord
  belongs_to :investigator

  def roll!(eyes=100)
   self.rolled_value = rand(1..100)
  end
end
