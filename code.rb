#YOUR CODE GOES HERE
require 'pg'
require 'csv'
require 'pry'

def db_connection
  begin
    connection = PG.connect(dbname: "ingredients")
    yield(connection)
  ensure
    connection.close
  end
end

#
# sql_1 = "CREATE TABLE ingredient_list5 (
#   id SERIAL PRIMARY KEY,
#   ingredient VARCHAR(255)
# );"
#
#
# @ingredient_array = []
# CSV.foreach('ingredients.csv', headers: true) do |row|
#   @ingredient_array << row.to_h
# end
#   # binding.pry
#
#
# # read_csv
#
#
# db_connection do |conn|
#   conn.exec(sql_1)
#   @ingredient_array.each do |one|
#     # binding.pry
#     conn.exec("INSERT INTO ingredient_list5 (ingredient) VALUES ('#{one["ingredient"]}');")
#   end
#   # output = conn.exec("SELECT * FROM ingredient_list4;")
#   # puts output.getvalue(0,0)
# end

@ingredient_table = db_connection { |conn| conn.exec("SELECT id, ingredient FROM ingredient_list4") }
@ingredient_table.to_a.each do |ingredient|
  puts "#{ingredient["id"]}. #{ingredient["ingredient"]}"
end
