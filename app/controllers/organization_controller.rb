#encoding: UTF-8
class OrganizationController < ApplicationController
	def add_vendors
		Organization.new("organizations/11-06-Organizations.xls").add_vendors
		render json: true
	end

	def auth_keys
		# (1..112).each do i
			vendor = Vendor.where(id: 45, distribution: true).first
			ReportMail.auth_keys("Эл. почта: #{vendor.email} Ключ: #{vendor.auth_key}", vendor).deliver
		# end
		render json: true
	end
end