require "./lib/ncaaschool"

# NcaaSchools object is a hash with school's name as key and 
# its object as value
foo = Ncaaschool::Ncaaschool.new
foo.how_many?
foo.export_json