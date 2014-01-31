#!/usr/bin/env
class CheckParsers

	def self.check(input)
		invoice_amount = []
		input.each { |i | invoice_amount << i['invoice_amount'] }
		invoice_amount.reject! { |a| a.nil? }
		invoice_amount.each {|i| i.class}
		p "noooooooooooooo" if input == [] || invoice_amount == []
	end
end