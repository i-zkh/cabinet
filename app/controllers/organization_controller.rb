class OrganizationController < ApplicationController
	def absence
		getter = Organization.new("Organizations.xls")
		getter.add_absence_vendor
	end

	def all
		getter = Organization.new("Organizations.xls")
		getter.non_utility_vendor
	end
end