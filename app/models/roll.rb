class Roll < ApplicationRecord
  belongs_to :investigator

  def result
    @result ||= determine_result()
  end

  def determine_result
    level = investigator.send(self.target)

    if self.rolled_value == 1
      :critical_success
    elsif self.rolled_value <= level / 5
      :extreme_success
    elsif self.rolled_value <= level / 2
      :hard_success
    elsif self.rolled_value <= level
      :success
    elsif self.rolled_value == 100
      :fumble
    elsif self.rolled_value >= 96 && level < 50
      :fumble
    else
      :failure
    end
  end

  def success?
    result.to_s.include?("success")
  end

  def human_readable_result
    result.to_s.gsub("_", " ")
  end

  def self.roll!(eyes=100)
    rand(1..eyes)
  end
end
