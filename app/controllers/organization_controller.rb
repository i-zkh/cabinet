#encoding: UTF-8
class OrganizationController < ApplicationController
	
	def add_vendors
		# if params[:file]
  #     		filename = "/home/ubuntu/apps/project/shared/organizations/" + "#{Date.today.strftime('%Y-%m-%d')}.xlsx"
		# 	File.open(File.join(filename), "wb") {|f| f.write(params[:file].read)}
			Organization.new("Organizations.xlsx").add_vendors
		# end
		@vendors = Vendor.order('created_at DESC').all
	end

	def auth_keys
		# Vendor.where("id > 165 and distribution = true").each { |ven| ReportMail.auth_keys(ven).deliver }
		render json: true
	end
end