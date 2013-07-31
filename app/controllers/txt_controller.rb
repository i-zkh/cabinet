class TxtController < ApplicationController
  def create
    getter = Getter.new(TxtParser.new("CIFR1307.TXT", 1))
    getter.input_data

    render json: true
  end
end
