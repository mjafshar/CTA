require 'csv'

CSV.foreach('db/CTA_ridership.csv', :headers => true) do |row|
  Stop.create(row.to_hash)
end
