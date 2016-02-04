class DinosaurController < ApplicationController
  def index
    @columns = [
      'name',
      'period',
      'walking',
      'diet',
      'weight',
      'continent',
      'description'
    ]
    @dinosaurs = Dinosaur.all.order(:name)
  end

  def show
    @dinosaur = Dinosaur.find(params[:id])
  end
end
