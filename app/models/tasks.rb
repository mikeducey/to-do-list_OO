require "pry"
require "sqlite3"

class Task

	def initialize(id, name, task, status)
		@id = id
		@name = name
		@task = task
		@status = status
	end

	def self.addNewTask(task, name)
		DB.execute("INSERT INTO tasks (task, name, status) VALUES (\"#{task}\", \"#{name}\", 2)")
	end

	def self.selectTask(id)
		@locateTask = DB.prepare("SELECT * FROM tasks WHERE id == \"#{id}\"")
		returnTask = @locateTask.execute
		return returnTask
	end

	def self.deleteTask(id)
		DB.execute("DELETE from tasks WHERE id == \"#{id}\"")
	end

	def editTask
		DB.execute("INSERT INTO tasks (task, name, status) VALUES (\"#{@task}\", \"#{@name}\", \"#{@status}\")")
	end

	def self.sort_by_completed_tasks
		@complete = DB.prepare("SELECT * FROM tasks WHERE status == 1")
		complete_tasks = @complete.execute
		return complete_tasks
	end

	def self.sort_by_incomplete_tasks
		@incomplete = DB.prepare("SELECT * FROM tasks WHERE status == 2")
		incomplete_tasks = @incomplete.execute
		return incomplete_tasks
	end

	def self.sort_by_family_member_incomplete(name)
		@incomplete = DB.prepare("SELECT * FROM tasks WHERE name == \"#{name}\" and status == 2")
		fm_incomplete_tasks = @incomplete.execute
		return fm_incomplete_tasks
	end

	def self.sort_by_family_member_complete(name)
		@complete = DB.prepare("SELECT * FROM tasks WHERE name == \"#{name}\" and status == 1")
		fm_complete_tasks = @complete.execute
		return fm_complete_tasks
	end

	def self.print_name(name)
			@selectFM = DB.prepare("SELECT name FROM name WHERE id == \"#{name}\"")
			familyMember = @selectFM.execute
		return familyMember
	end

# This is the end for the class	Task.
end

