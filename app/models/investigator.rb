class Investigator < ApplicationRecord
  def max_hp
    (siz + con) / 10
  end
end
