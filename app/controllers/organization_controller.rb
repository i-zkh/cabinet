class OrganizationController < ApplicationController
	def add_vendors
		Organization.new("organizations/11-06-Organizations.xls").add_vendors
		render json: true
	end
end