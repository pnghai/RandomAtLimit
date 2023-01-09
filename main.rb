require 'date'
require 'json'
require 'csv'
UPPER = 3*(10**8)
FROM_DATE = Date.new(2022,3,1)
TO_DATE = Date.new(2023,01,31)
WEEKS = (FROM_DATE..TO_DATE).count { |d| d.sunday? || d.saturday? }
THOUSAND_DONG = 1000
MILLION_DONG = 1000*THOUSAND_DONG
list = []
grand_total = 0
WEEKS.times.each do
  menu = []
  menu_total = 0
  ceiling = rand(50..140)/10*MILLION_DONG
  while menu_total < ceiling
    price = rand(5..40)*10*THOUSAND_DONG
    quantity = rand(5..10)
    if price*quantity < 3*MILLION_DONG
      sub_total = price*quantity
      menu_total += sub_total
      menu << {
        price: price,
        quantity: quantity,
        sub_total: sub_total
      }
    end
  end
  list << { menu: menu, total: menu_total}
  puts menu_total
  grand_total += menu_total
  break if grand_total >= UPPER
end
puts grand_total
CSV.open("data.csv", "wb") do |csv|
  list.each_with_index do |menu,idx|
    menu[:menu].each_with_index do |item, idx2|
      csv << ([idx, menu[:total], idx2] + item.values)
    end
  end
end