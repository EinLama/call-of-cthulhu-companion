class RollsController < ApplicationController
  def index
    @investigator = Investigator.find(params[:investigator_id])
    @rolls = Roll.all
  end

  def show
    @roll = Roll.find(params[:id])
  end

  def create
    @investigator = Investigator.find(params[:investigator_id])

    rolled_value = rand(1..100)
    @roll = @investigator.rolls.create(roll_params(rolled_value))

    # FIXME: model needs validation, invalid target/roll is allowed at the moment
    if @roll.save
      redirect_to [@investigator, @roll]
    else
      # TODO: display some kind of error message
      redirect_to @investigator, status: :unprocessable_entity
    end
  end

  private

  def roll_params(val)
    params.require(:roll)
        .with_defaults({rolled_value: val})
        .permit(:target, :rolled_value)
  end
end
