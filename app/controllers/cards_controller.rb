class CardsController < ApplicationController
  def show
    @card = Card.new(which: params[:id]).cardify
  end
end
