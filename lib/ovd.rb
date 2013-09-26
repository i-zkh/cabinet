#!/usr/bin/ruby -w
#encoding: utf-8
require 'nokogiri'
require "base64"

class Ovd

	def self.xml_parser
		xmlfile = File.new("Koord_UUM_3640136400_Самарская область-Самара-Железнодорожный_28.02.2013.xml")
		xml_doc = Nokogiri::XML(xmlfile)
		n = Precinct.last ? Precinct.last.id : 0
		data = []

		(0..xml_doc.css("EFOType OVD opor_info opor").size-1).each do |k|
			(0..xml_doc.css("EFOType OVD opor_info opor")[k].children.css("uum_info uum").size-1).each do |i|

				unless xml_doc.css("EFOType OVD opor_info opor")[k].children.css("uum_info uum uum_surname")[i].text == "Вакантно" || xml_doc.css("EFOType OVD opor_info opor")[k].children.css("uum_info uum uum_surname")[i].text == "Вакансия" || xml_doc.css("EFOType OVD opor_info opor")[k].children.css("uum_info uum uum_surname")[i].text == "вакантный"
					#Create precincts
					Precinct.create!(
						ovd: xml_doc.css("EFOType OVD opor_info opor subdiv_name")[k].text,
						ovd_town: xml_doc.css("EFOType OVD opor_info opor opor_townname")[k].text,
						ovd_street: xml_doc.css("EFOType OVD opor_info opor opor_streetname")[k].text,
						ovd_house: xml_doc.css("EFOType OVD opor_info opor opor_house")[k].text,
						ovd_telnumber: xml_doc.css("EFOType OVD opor_info opor opor_telnumber")[k].text,
						surname: xml_doc.css("EFOType OVD opor_info opor")[k].children.css("uum_info uum uum_surname")[i].text,
						name: xml_doc.css("EFOType OVD opor_info opor")[k].children.css("uum_info uum uum_name")[i].text,
						middlename: xml_doc.css("EFOType OVD opor_info opor")[k].children.css("uum_info uum uum_middlename")[i].text,
						photo: ""
					)

					(0..xml_doc.css("EFOType OVD opor_info opor")[k].children.css("uum_info uum")[i].children.css("territory_info uumterritory").size-1).each do |j|
						houses = xml_doc.css("EFOType OVD opor_info opor")[k].children.css("uum_info uum")[i].children.css("territory_info uumterritory houses")[j].text
						houses.gsub!('=', '-')
						houses.gsub!('.', ',')
						houses.gsub!(';', ',')
						houses.gsub!(" ", "")
						houses.gsub!("а", "")

						# Parsing address
						data = case houses
							   when "все дома" || "полностью" || "все" then ""
							   when /(\d+)-(\d+),(\d+)-(\d+),(\d+)-(\d+),(\d+)-(\d+)/
									array = []
									array << houses.gsub('-', ',').gsub('/', ',').split(',')
									houses =~ /(\d+)-(\d+),(\d+)-(\d+),(\d+)-(\d+),(\d+)-(\d+)/
									array << ($1..$2).to_a.each { |x| x.to_i }
									array << ($3..$4).to_a.each { |x| x.to_i }
									array << ($5..$6).to_a.each { |x| x.to_i }
									array.flatten!.uniq
							   when /(\d+)-(\d+),(\d+)-(\d+)/
									array = []
									array << houses.gsub('-', ',').gsub('/', ',').split(',')
									houses =~ /(\d+)-(\d+),(\d+)-(\d+)/
									array << ($1..$2).to_a.each { |x| x.to_i }
									array << ($3..$4).to_a.each { |x| x.to_i }
									array.flatten!.uniq
							   when /(\d+)-(\d+)/
									array = []
									array << houses.gsub('-', ',').gsub('/', ',').split(',')
									houses =~ /(\d+)-(\d+)/
									array << ($1..$2).to_a.each { |x| x.to_i }
									array.flatten!.uniq									
							   when /[\w][,]/
									array = []
									array = houses.split(',')
							   when /с(\d+)до(\d+),с(\d+)до(\d+)/
									array = []
									houses =~ /с(\d+)до(\d+),с(\d+)до(\d+)/
									array << ($1..$2).to_a.each { |x| x.to_i }
									array << ($3..$4).to_a.each { |x| x.to_i }
									array.flatten!.uniq
								when /с(\d+)до(\d+)/
									array = []
									houses =~ /с(\d+)до(\d+)/
									array << ($1..$2).to_a.each { |x| x.to_i }
							 		array.flatten!.uniq
								when /с(\d+)до(\d+)/
									array = []
									houses =~ /с(\d+)до(\d+)/
									array << ($1..$2).to_a.each { |x| x.to_i }
							 		array.flatten!.uniq
								when /(\d+)/
									array = []
									array << houses
								else ""
								end
						#Create territories of precinct 
						(0..data.size-1).each do |d|
							Territory.create!(
								precinct_id: n+1,
								street: xml_doc.css("EFOType OVD opor_info opor")[k].children.css("uum_info uum")[i].children.css("territory_info uumterritory uum_streetname")[j].text,
						 		house: data[d]
							)	
						end	
					end
					n += 1
			    end
			end
		end
	end
end