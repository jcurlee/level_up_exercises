class DinosaurController < ApplicationController
  def index
    @columns = [
      "name",
      "period",
      "walking",
      "diet",
      "weight",
      "walking",
      "continent",
      "description",
    ]

    @dinosaurs = Dinosaur.all.select(@columns)
  end
end
