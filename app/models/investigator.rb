class Investigator < ApplicationRecord
  has_many :rolls

  def max_hp
    (siz + con) / 10
  end

  # The characteristics should be their own class
  def characteristics
    %i[str con dex int siz pow app edu]
  end

  def hard_value(characteristic)
    raise "Invalid Characteristic" unless characteristics.include?(characteristic)

    self.send(characteristic) / 2
  end

  def extreme_value(characteristic)
    raise "Invalid Characteristic" unless characteristics.include?(characteristic)

    self.send(characteristic) / 5
  end
end
