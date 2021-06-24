class CommunesController < ApplicationController
  def index
    @communes = Commune.all
    respond_to do |format|
      format.xlsx {
        render xlsx: "index", filename: "Communes.xlsx"
      }
    end
  end
end