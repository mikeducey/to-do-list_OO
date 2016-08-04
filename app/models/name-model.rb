require "pry"
require "sqlite3"

class Name

	# extend ClassMethods - When this is not in a comment, and the extend is part of the class,
	# I get the following error when running tests: /Users/kimarmstrong/Code/to-do-list_OO/app/models/name-model.rb:6:in `<class:Name>': uninitialized constant Name::ClassMethods (NameError)
	# Not sure why I can't extend ClassMethods for class Name!
	
	attr_reader :id, :name
	attr_writer :id, :name

	def initialize(id=nil, name)
		@id = id
		@name = name
	end

	# Returns the name of the family member that is represented by the id number on the names table.
	def self.print_name(name_id)
		get_name = DB.execute("SELECT * FROM name WHERE id == \"#{name_id}\"")
		selected_name = get_name[0]

		Name.new(name_id, selected_name["name"])
	end

end
