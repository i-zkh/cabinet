#!/usr/bin/ruby -w
#encoding: utf-8
require 'nokogiri'
require "base64"

class Ovd

	def self.xml_parser
		Dir.foreach('ovd_data2') do |file|
			next if file == '.' or file == '..'
			xmlfile = File.new("ovd_data/#{file}")
			xml_doc = Nokogiri::XML(xmlfile)
			data = []

			(0..xml_doc.css("EFOType OVD opor_info opor").size-1).each do |k|
				(0..xml_doc.css("EFOType OVD opor_info opor")[k].children.css("uum_info uum").size-1).each do |i|

					unless xml_doc.css("EFOType OVD opor_info opor")[k].children.css("uum_info uum uum_surname")[i].text == "Вакантно" || xml_doc.css("EFOType OVD opor_info opor")[k].children.css("uum_info uum uum_surname")[i].text == "Вакансия" || xml_doc.css("EFOType OVD opor_info opor")[k].children.css("uum_info uum uum_surname")[i].text == "вакантный"
						# Create precincts
						unless Precinct.where(surname: xml_doc.css("EFOType OVD opor_info opor")[k].children.css("uum_info uum uum_surname")[i].text).first				
							Precinct.create!(
								ovd: 				xml_doc.css("EFOType OVD opor_info opor subdiv_name")[k].text,
								ovd_town: 			xml_doc.css("EFOType OVD opor_info opor opor_townname")[k].text,
								ovd_street: 		xml_doc.css("EFOType OVD opor_info opor opor_streetname")[k].text,
								ovd_house: 			xml_doc.css("EFOType OVD opor_info opor opor_house")[k].text,
								ovd_telnumber: 		xml_doc.css("EFOType OVD opor_info opor opor_telnumber")[k].text,
								surname: 			xml_doc.css("EFOType OVD opor_info opor")[k].children.css("uum_info uum uum_surname")[i].text,
								name: 				xml_doc.css("EFOType OVD opor_info opor")[k].children.css("uum_info uum uum_name")[i].text,
								middlename: 		xml_doc.css("EFOType OVD opor_info opor")[k].children.css("uum_info uum uum_middlename")[i].text
							)
						end

						(0..xml_doc.css("EFOType OVD opor_info opor")[k].children.css("uum_info uum")[i].children.css("territory_info uumterritory").size-1).each do |j|

							#Create streets
							unless Street.where(street: xml_doc.css("EFOType OVD opor_info opor")[k].children.css("uum_info uum")[i].children.css("territory_info uumterritory uum_streetname")[j].text).first
								Street.create!(
									street: xml_doc.css("EFOType OVD opor_info opor")[k].children.css("uum_info uum")[i].children.css("territory_info uumterritory uum_streetname")[j].text
								)
							end

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
								PrecinctHouse.create!(
									precinct_id: 		Precinct.where(surname: xml_doc.css("EFOType OVD opor_info opor")[k].children.css("uum_info uum uum_surname")[i].text).first.id,
									street_id: 			Street.where(street: xml_doc.css("EFOType OVD opor_info opor")[k].children.css("uum_info uum")[i].children.css("territory_info uumterritory uum_streetname")[j].text).first.id,
							    	house: 				data[d]
								)
							end	
						end
				    end
				end
			end
		end
	end

	def self.xls_parser
		s = Roo::Excel.new("report/ovd_18.12.13.xls")
		(1..s.last_row).each do |i|
			address_ovd = s.cell(i, 2).split(", ")
			full_name 	= s.cell(i, 4).split(" ")
			name 		= full_name[1].nil? ? "" : full_name[1]
			sector	 	= s.cell(i, 5).split(";")
			
			Precinct.create!(
					ovd: 				s.cell(i, 1),
					ovd_town: 			address_ovd[0],
					ovd_street: 		address_ovd[1],
					ovd_house: 			address_ovd[2],
					ovd_telnumber: 		s.cell(i, 3) ? s.cell(i, 3).to_i : s.cell(i, 3),
					surname: 			full_name[0],
					name: 				name,
					middlename: 		full_name[2].nil? ? "" : full_name[2]
			)
			sector.each do |ad|
				address = []
				address = ad.split(",")
				Street.create!(street: address[0].lstrip) unless Street.where(street: address[0].lstrip).first
				(1..address.size).each do |i|
					next if address[i] == nil || address[i] == " "
					houses = []
					houses << case address[i].gsub(' ', '')
							  when /(\d+)-(\d+)/
								array = []
								address[i].gsub(' ', '') =~ /(\d+)-(\d+)/
								array << ($1..$2).to_a.each { |x| x.to_i }
								array.flatten!.uniq
							  else
								address[i]
							  end
					houses.flatten.each do |house|
						PrecinctHouse.create!(
							precinct_id: 		Precinct.where(surname: full_name[0], name: name).first.id,
							street_id: 			Street.where(street: address[0].lstrip).first.id,
					    	house: 				house.lstrip.mb_chars.downcase.to_s
						)
					end
				end
			end
		end
	end

	def self.xml_to_xsl
		data, array, address = [], [], []
		Dir.foreach('ovd_data2') do |file|
		next if file == '.' or file == '..'
		xmlfile = File.new("ovd_data2/#{file}")
		xml_doc = Nokogiri::XML(xmlfile)


		(0..xml_doc.css("EFOType OVD opor_info opor").size-1).each do |k|
		(0..xml_doc.css("EFOType OVD opor_info opor")[k].children.css("uum_info uum").size-1).each do |i|
			array = [
					xml_doc.css("EFOType OVD opor_info opor subdiv_name")[k].text,
					xml_doc.css("EFOType OVD opor_info opor opor_townname")[k].text,
					xml_doc.css("EFOType OVD opor_info opor opor_streetname")[k].text,
					xml_doc.css("EFOType OVD opor_info opor opor_house")[k].text,
					xml_doc.css("EFOType OVD opor_info opor opor_telnumber")[k].text,
					xml_doc.css("EFOType OVD opor_info opor")[k].children.css("uum_info uum uum_surname")[i].text,
					xml_doc.css("EFOType OVD opor_info opor")[k].children.css("uum_info uum uum_name")[i].text,
					xml_doc.css("EFOType OVD opor_info opor")[k].children.css("uum_info uum uum_middlename")[i].text
			]
			address = []
			(0..xml_doc.css("EFOType OVD opor_info opor")[k].children.css("uum_info uum")[i].children.css("territory_info uumterritory").size-1).each do |j|
				address << [ xml_doc.css("EFOType OVD opor_info opor")[k].children.css("uum_info uum")[i].children.css("territory_info uumterritory uum_streetname")[j].text, xml_doc.css("EFOType OVD opor_info opor")[k].children.css("uum_info uum")[i].children.css("territory_info uumterritory houses")[j].text ]
			end
			array << address
			data << array
		end
		end
		end
		data
	end

	def self.count
			samara = 0
			count = 0
		Dir.foreach('ovd_data2') do |file|
			next if file == '.' or file == '..'
			xmlfile = File.new("ovd_data2/#{file}")
			xml_doc = Nokogiri::XML(xmlfile)
		
			(0..xml_doc.css("EFOType OVD opor_info opor").size-1).each do |k|
				count += 1
				samara += 1 if xml_doc.css("EFOType OVD opor_info opor opor_townname")[k].text == "Самара"
			end
			
		end
		p count 
		p samara
	end

	def self.diff
		file_manager = Roo::Excel.new("база участковых 3.xls")
		file_ovd_1 = Roo::Excel.new("ovd_11.xls")
		file_ovd_2 = Roo::Excel.new("ovd_22.xls")

		Axlsx::Package.new do |p|
			p.workbook.add_worksheet(:name => "Report") do |sheet|
				sheet.add_row ["Управляющий пункт", "Адрес", "Телефон", "Участковый", "Участок"]
				(1..file_ovd_2.last_row).each do |j|
					address = ""
					(1..file_ovd_1.last_row).each do |i|
						address = file_ovd_1.cell(i, 6) if file_ovd_2.cell(j, 5) == file_ovd_1.cell(i, 5)
					end
					if address == "" || address == nil
						sheet.add_row [file_ovd_2.cell(j, 1), file_ovd_2.cell(j, 2), file_ovd_2.cell(j, 3), file_ovd_2.cell(j, 4), file_ovd_2.cell(j, 5)]
					else
						sheet.add_row [file_ovd_2.cell(j, 1), file_ovd_2.cell(j, 2), file_ovd_2.cell(j, 3), file_ovd_2.cell(j, 4), address], :color =>"008000"
					end
				end
			end
			p.serialize("OVD_test.xls")
		end

	end

	def self.merge
		file_manager = Roo::Excel.new("report/база участковых 3.xls")
		file_ovd_1 = Roo::Excel.new("report/База.xls")

		Axlsx::Package.new do |p|
			p.workbook.add_worksheet(:name => "Report") do |sheet|
				sheet.add_row ["Управляющий пункт", "Адрес", "Телефон", "Участковый", "Участок"]
				(1..file_ovd_1.last_row).each do |j|
					address = ""
					ovd_address = ""
					phone = ""
					(1..file_manager.last_row).each do |i|
						if file_manager.cell(i, 5)[0..10] == file_ovd_1.cell(j, 5)[0..10] && file_manager.cell(i, 4) == file_ovd_1.cell(j, 4)
							address = file_manager.cell(i, 5) 
							ovd_address = file_manager.cell(i, 2)
							phone 		= file_manager.cell(i, 3)
						end
					end
					if address == "" || address == nil
						sheet.add_row [file_ovd_1.cell(j, 1), file_ovd_1.cell(j, 2), file_ovd_1.cell(j, 3), file_ovd_1.cell(j, 4), file_ovd_1.cell(j, 5).chomp(';')]
					else
						sheet.add_row [file_ovd_1.cell(j, 1), ovd_address, phone, file_ovd_1.cell(j, 4), address], :color =>"008000"
					end
				end
			end
			p.serialize("report/OVD_test.xls")
		end

	end
end