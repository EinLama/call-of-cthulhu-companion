class InvestigatorsController < ApplicationController
  def index
    @investigators = Investigator.all
  end

  def show
    @investigator = Investigator.find(params[:id])
  end

  def skill_roll
    @investigator = Investigator.find(params[:id])

    characteristic = params[:characteristic]

    return head(:bad_request) unless @investigator.characteristics.include?(characteristic.to_sym)

    SkillRoll.new.skill_roll(@investigator.send(characteristic))
  end
end