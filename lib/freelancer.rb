#encoding: UTF-8
class Freelancer

 	def initialize(file)
    	@data = parsing_file(file)
    	@categories = categories
  	end

	def check_categories
	    data, array, categories = [], [], []
	    (0..@data.size-1).each do |i|
	        data << @data[i]["category"].mb_chars.capitalize.to_s
	    end
	    (0..@categories.size-1).each do |j|
	        categories << @categories[j]["title"]
	    end 

	    array = data - categories
	    array.uniq!
	    if array != []
	      (0..array.size-1).each do |a|
	        PostRequest.freelance_category(array[a])
	       end
	    else
	      puts "----------No one new categories----------"
	    end
	end

	def add_freelancers
	    check_categories
	  	(0..@data.size-1).each do |i|
	 	    (0..@categories.size-1).each do |j|
		        if @categories[j]["title"].mb_chars.downcase.to_s == @data[i]["category"].mb_chars.downcase.to_s
		        	array = [] 
		        	array = @data[i]["ad"].split(" ")
				    # PostRequest.freelancer(@categories[j]["id"], @data[i]["ad"], @data[i]["phone"], "#{array[0]} #{array[1]} #{array[2]}...", @data[i]["contact"])
			    end
	     	end
	 	end
	end

	private

  	def parsing_file(file)
	    s = Roo::Excel.new(file)
		key, data, address = ["category", "ad", "phone", "contact"], [], []
		hash = {}
		(2..s.last_row).each do |i|
			hash = {key[0] => s.cell(i, 1), key[1] => s.cell(i, 2), key[2] => s.cell(i, 3), key[3] => s.cell(i, 4)}
		  data << hash
		end
		data
  	end

	def categories
	    categories, key = [], ["title", "id"]
	    hash = {}
		GetRequest.freelancecategories.each do |category|
			hash =  { key[0] => category['freelance_category']['title'], key[1] => category['freelance_category']['id'] }
	      categories << hash
		end
		categories
	end
end