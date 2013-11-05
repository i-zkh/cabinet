#encoding: UTF-8
class VendorsController < ApplicationController
  before_filter :authorize, only: [:show, :edit, :update]

  def show
    @vendor = current_user
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @vendor }
    end
  end

  def edit
    @vendor = current_user
  end

  def update
    @vendor = current_user

    respond_to do |format|
      if @vendor.update_attributes(params[:vendor])
        format.html { redirect_to @vendor, notice: 'Данные успешно обновлены.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @vendor.errors, status: :unprocessable_entity }
      end
    end
  end
end