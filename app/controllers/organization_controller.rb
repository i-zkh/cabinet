#encoding: UTF-8
class OrganizationController < ApplicationController
	
	def add_vendors
		Organization.new("organizations/#{DateTime.now.month}-#{DateTime.now.day}-Organizations.xls").add_vendors
		render json: true
	end

	def auth_keys
		Vendor.where("id > 144 and distribution = true").each { |ven| ReportMail.auth_keys(ven).deliver }
		render json: true
	end
end