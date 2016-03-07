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

#possibly use (below)
# enco = PG::TextEncoder::CopyRow.new
# conn.copy_data "COPY my_table FROM STDIN", enco do
#   conn.put_copy_data ['index', 'data', 'to', 'copy']
#   conn.put_copy_data ['more', 'data', 'to', 'copy']
# end
#
# conn.copy_data "COPY my_table TO STDOUT CSV" do
#   while row=conn.get_copy_data
#     p row
#   end
# end
#
# possibly use (above)

sql_1 = "CREATE TABLE ingredient_list13 (
  id SERIAL PRIMARY KEY,
  ingredient VARCHAR(255)
);"


@ingredient_array = []
CSV.foreach('ingredients.csv', headers: true) do |row|
  @ingredient_array << row.to_h
end

db_connection do |conn|
  conn.exec(sql_1)
  @ingredient_array.each do |one|
    conn.exec("INSERT INTO ingredient_list13 (ingredient) VALUES ('#{one["ingredient"]}');")
  end
  output = conn.exec("SELECT * FROM ingredient_list13;")
  output.each_row {|column1, column2| puts "#{column1}. #{column2}" }
end
