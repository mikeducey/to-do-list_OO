require "pry"
require "sqlite3"

class Task

	# extend TaskORM

	attr_reader :id, :name, :task, :status 
	attr_writer :id, :name, :task, :status


	# Adds a new task to the task database
	#
	# Updates the @id with the id number of the last task added.
	
	def self.addNewTask(task, name)
		DB.execute("INSERT INTO tasks (task, name, status) VALUES (\"#{task}\", \"#{name}\", 2)")
		@id = DB.last_insert_row_id

		Task.new(id[@id], task["task"], name["name"], status[2])
	end

	# Selects a task from the database based on the id.
	#
	# This will be used to populate the data field when a task is to be edited.

	def self.selectTask(id)
		execute("SELECT * FROM tasks WHERE id == #{id}")

		Task.new(id["id"], task["task"], name["name"], status["status"])
	end

	# Deletes a task from the database based on the id.
	#
	# Nothing should be returned!

	def self.deleteTask(id)
		DB.execute("DELETE from tasks WHERE id == #{id}")
	end

	# Edits a task from the database based on the id.
	#
	# This function takes in data that is populated in the edit box that is supplied
	# by the selectTask function.

	def self.editTask(id, name, task, status)
		DB.execute("UPDATE tasks SET task=\"#{task}\", name=\"#{name}\", status=\"#{status}\" WHERE id=\"#{id}\"")
	end

	# Sorts all tasks in the database by status, in this case complete tasks.

	def self.sort_by_completed_tasks
		DB.execute("SELECT * FROM tasks WHERE status == 1")
	end

	# Sorts all tasks in the database by status, in this case incomplete tasks.
	def self.sort_by_incomplete_tasks
		DB.execute("SELECT * FROM tasks WHERE status == 2")
	end

	# Sorts all tasks in the database by name, which is represented by an id number in the tasks rb.
	#
	# It also sorts by the status of the task, in this case, incomplete tasks.

	def self.sort_by_family_member_incomplete(name)
		DB.execute("SELECT * FROM tasks WHERE name == \"#{name}\" and status == 2")
	end

	# Sorts all tasks in the database by name, which is represented by an id number in the tasks rb.
	#
	# It also sorts by the status of the task, in this case, complete tasks.

	def self.sort_by_family_member_complete(name)
		DB.execute("SELECT * FROM tasks WHERE name == \"#{name}\" and status == 1")
	end

	# Returns the name of the family member that is represented by the id number on the names table.
	def self.print_name(name)
		DB.execute("SELECT name FROM name WHERE id == \"#{name}\"")
	end

# This is the end for the class	Task.
end

