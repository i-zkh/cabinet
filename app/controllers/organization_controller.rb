class OrganizationController < ApplicationController
	def absence
		getter = Organization.new("Organizations.xls")
		getter.add_absence_vendor
    	render json: true
	end

	def all
		getter = Organization.new("Organizations.xls")
		getter.non_utility_vendor
		render json: true
	end
end