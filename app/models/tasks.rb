require "pry"
require "sqlite3"

class Task

	# extend TaskORM

	attr_reader :id, :name, :task, :status 
	attr_writer :id, :name, :task, :status

	def initialize(id=nil, name, task, status)
		@id = id
		@name = name
		@task = task
		@status = status
	end

	# Adds a new task to the task database
	#
	# Updates the @id with the id number of the last task added.
	
	def self.save(task, name)
		newTask = DB.execute("INSERT INTO tasks (task, name, status) VALUES (\"#{task}\", #{name}, 2)")
		@id = DB.last_insert_row_id

		Task.new(@id, newTask["task"], newTask["name"], newTask["status"])
	end

	# Selects a task from the database based on the id.
	#
	# This will be used to populate the data field when a task is to be edited.

	def self.whereID(id)
		selectTask = DB.execute("SELECT * FROM tasks WHERE id == #{id}")
		selectedTask = selectTask[0]

		Task.new(selectedTask["id"], selectedTask["name"], selectedTask["task"], selectedTask["status"])
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

	def update_attributes(id, name, task, status)
		DB.execute("UPDATE tasks SET name=\"#{name}\", task=\"#{task}\", status=\"#{status}\" WHERE id=\"#{id}\"")
		@name = name
		@task = task
		@status = status
	end

	# Sorts all tasks in the database by status, in this case complete tasks.

	def self.completed_tasks
		completedTasks = DB.execute("SELECT * FROM tasks WHERE status == 1")
	
		Task.new(completedTasks["id"], completedTasks["name"], completedTasks["task"], completedTasks["status"])
	end

	# Sorts all tasks in the database by status, in this case incomplete tasks.
	def self.incomplete_tasks
		incompleteTasks = DB.execute("SELECT * FROM tasks WHERE status == 2")

		Task.new(incompleteTasks["id"], incompleteTasks["name"], incompleteTasks["task"], incompleteTasks["status"])

	end

	# Sorts all tasks in the database by name, which is represented by an id number in the tasks rb.
	#
	# It also sorts by the status of the task, in this case, incomplete tasks.

	def self.family_member_incomplete_tasks(name)
		DB.execute("SELECT * FROM tasks WHERE name == \"#{name}\" and status == 2")
	end

	# Sorts all tasks in the database by name, which is represented by an id number in the tasks rb.
	#
	# It also sorts by the status of the task, in this case, complete tasks.

	def self.family_member_complete_tasks(name)
		DB.execute("SELECT * FROM tasks WHERE name == \"#{name}\" and status == 1")
	end

	# Returns the name of the family member that is represented by the id number on the names table.
	def self.print_name(name)
		DB.execute("SELECT name FROM name WHERE id == \"#{name}\"")
	end

# This is the end for the class	Task.
end

