require "pry"
require "sqlite3"

class Task

	extend ClassMethods

	attr_reader :id, :task, :name, :status 
	attr_writer :id, :task, :name, :status 

	def initialize(id=nil, task, name, status)
		@id = id
		@task = task
		@name = name
		@status = status
	end

	# Adds a new task to the task database
	#
	# Updates the @id with the id number of the last task added.
	
	def self.save(task, name)
		default_status = 2
		newTask = DB.execute("INSERT INTO tasks (task, name, status) VALUES (\"#{task}\", #{name}, #{default_status})")
		@id = DB.last_insert_row_id

		Task.new(@id, task, name, default_status)
	end

	# Edits a task from the database based on the id.
	#
	# This function takes in data that is populated in the edit box that is supplied
	# by the selectTask function.
	# 
	# I think this function needs to stay in this class and not the module, as it provides info to only the task 
	# table, and no other tables (like the name or status table) have the same number of columns or column info.

	def update_attributes(id, name, task, status)
		DB.execute("UPDATE tasks SET task=\"#{task}\", name=\"#{name}\", status=\"#{status}\" WHERE id=\"#{id}\"")
		@task = task
		@name = name
		@status = status
	end

	# Sorts all tasks in the database by status.
	def self.sort_by_status(status)
		array_by_status = []
		@status = status
		sorted_tasks = DB.execute("SELECT * FROM tasks WHERE status ==#{status}")
		sorted_tasks.each do |x|
			array_by_status << Task.new(x["id"], x["task"], x["name"], x["status"])
		end

		return array_by_status

	end

	#Sorts all tasks in the database by family member and status.
	def self.family_member_sorted_by_status(name, status)
		famMem_by_status = []
		famMem_tasks = DB.execute("SELECT * FROM tasks WHERE name == #{name} and status == #{status}")
		famMem_tasks.each do |x|
			famMem_by_status << Task.new(x["id"], x["task"], x["name"], x["status"])
		end

		return famMem_by_status

	end

end

