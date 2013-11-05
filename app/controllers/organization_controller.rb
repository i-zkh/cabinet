class OrganizationController < ApplicationController
	def add_vendors
		Organization.new("organizations/11-01-Organizations.xls").add_vendors
		render json: true
	end
end