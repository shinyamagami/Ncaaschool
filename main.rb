require "./lib/ncaaschool"
require "./lib/college"
require "./lib/team"
require "./lib/fb"

# NcaaSchools object is a hash with school's name as key and 
# its object as value
foo = Ncaaschool.new
foo.how_many?
foo.export_json