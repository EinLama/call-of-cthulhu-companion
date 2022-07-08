class InvestigatorsController < ApplicationController
  def index
    @investigators = Investigator.all
  end

  def show
    @investigator = Investigator.find(params[:id])
  end
end