#!/usr/bin/ruby -w
#encoding: utf-8
require 'nokogiri'

class Ovd
	include REXML

	def self.xml_parser
		

		xmlfile = File.new("Koord_UUM_3640136400_Самарская область-Самара-Железнодорожный_28.02.2013.xml")
		xml_doc = Nokogiri::XML(xmlfile)

		(0..xml_doc.css("EFOType OVD opor_info opor uum_info uum").size-1).each do |i|
			p "_____________________________"
			p xml_doc.css("EFOType OVD opor_info opor uum_info uum uum_surname")[i].text
			 xml_doc.css("EFOType OVD opor_info opor uum_info uum uum_name")[i].text
			 xml_doc.css("EFOType OVD opor_info opor uum_info uum uum_middlename")[i].text
			 
				(0..xml_doc.css("EFOType OVD opor_info opor uum_info uum")[i].children.css("territory_info uumterritory").size-1).each do |j|
					 xml_doc.css("EFOType OVD opor_info opor uum_info uum")[i].children.css("territory_info uumterritory uum_streetname")[j].text
					p xml_doc.css("EFOType OVD opor_info opor uum_info uum")[i].children.css("territory_info uumterritory houses")[j].text
				end

			# (0..xml_doc.css("EFOType OVD opor_info opor uum_info uum ").size-1).each do |j|
			# 	p subdiv_name = xml_doc.css("EFOType OVD opor_info opor uum_info uum uum_surname")[j].text
			# end
		end

	# (0..xml_doc.css("EFOType OVD opor_info opor").size-1).each do |i|
	# 	p subdiv_name = xml_doc.css("EFOType OVD opor_info opor subdiv_name")[i].text
	# 	p xml_doc.css("EFOType OVD opor_info opor")[i].children.css("uum_info uum uum_surname")
	# 	# (0..xml_doc.css("EFOType OVD opor_info opor uum_info uum ").size-1).each do |j|
	# 	# 	p subdiv_name = xml_doc.css("EFOType OVD opor_info opor uum_info uum uum_surname")[j].text
	# 	# end
	# end

# xmlfile = File.new("Koord_UUM_3640136400_Самарская область-Самара-Железнодорожный_28.02.2013.xml")
# 		xml_doc = Nokogiri::XML(xmlfile)

# 		(0..xml_doc.css("EFOType OVD opor_info opor").size-1).each do |k|
# 			(0..xml_doc.css("EFOType OVD opor_info opor")[k].children.css("uum_info uum").size-1).each do |i|
# 				p xml_doc.css("EFOType OVD opor_info opor subdiv_name")[k].text
# 				p xml_doc.css("EFOType OVD opor_info opor opor_townname")[k].text
# 				p xml_doc.css("EFOType OVD opor_info opor opor_streetname")[k].text
# 				p xml_doc.css("EFOType OVD opor_info opor opor_house")[k].text
# 				p xml_doc.css("EFOType OVD opor_info opor opor_telnumber")[k].text

# 				p xml_doc.css("EFOType OVD opor_info opor")[k].children.css("uum_info uum uum_surname")[i].text
# 				p xml_doc.css("EFOType OVD opor_info opor")[k].children.css("uum_info uum uum_name")[i].text
# 				 xml_doc.css("EFOType OVD opor_info opor")[k].children.css("uum_info uum uum_middlename")[i].text
				

# 					(0..xml_doc.css("EFOType OVD opor_info opor uum_info uum")[i].children.css("territory_info uumterritory").size-1).each do |j|
# 						p xml_doc.css("EFOType OVD opor_info opor uum_info uum")[i].children.css("territory_info uumterritory uum_streetname")[j].text
# 						p xml_doc.css("EFOType OVD opor_info opor uum_info uum")[i].children.css("territory_info uumterritory houses")[j].text
# 					end

# 				# (0..xml_doc.css("EFOType OVD opor_info opor uum_info uum ").size-1).each do |j|
# 				# 	p subdiv_name = xml_doc.css("EFOType OVD opor_info opor uum_info uum uum_surname")[j].text
# 				# end
# 			end
# 		end
# 	# (0..xml_doc.css("EFOType OVD opor_info opor").size-1).each do |i|
# 	# 	p subdiv_name = xml_doc.css("EFOType OVD opor_info opor subdiv_name")[i].text
# 	# 	p xml_doc.css("EFOType OVD opor_info opor")[i].children.css("uum_info uum uum_surname")
# 	# 	# (0..xml_doc.css("EFOType OVD opor_info opor uum_info uum ").size-1).each do |j|
# 	# 	# 	p subdiv_name = xml_doc.css("EFOType OVD opor_info opor uum_info uum uum_surname")[j].text
# 	# 	# end
# 	# end

	end
end