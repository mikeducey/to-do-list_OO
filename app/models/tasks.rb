require "pry"
require "sqlite3"

class Task

	def initialize(name, task)
		@name = name
		@task = task
	end

	def get_name
		@name
	end

	def createNewTask
		DB.execute("INSERT INTO tasks VALUES (\"#{@task}\", \"#{@name}\", 1)")
		
	end

	def sort_by_completed_tasks
		@complete = DB.prepare("SELECT * FROM tasks WHERE status == 1")
		complete_tasks = @complete.execute
		return complete_tasks
	end

	def sort_by_incomplete_tasks
		@incomplete = DB.prepare("SELECT * FROM tasks WHERE status == 2")
		incomplete_tasks = @incomplete.execute
		return incomplete_tasks
	end

	def sort_by_family_member_incomplete
		@incomplete = DB.prepare("SELECT * FROM tasks WHERE name == \"#{@name}\" and status == 2")
		fm_incomplete_tasks = @incomplete.execute
		return fm_incomplete_tasks
	end

	def sort_by_family_member_complete
		@complete = DB.prepare("SELECT * FROM tasks WHERE name == \"#{@name}\" and status == 1")
		fm_complete_tasks = @complete.execute
		return fm_complete_tasks
	end

	def print_name
			@selectFM = DB.prepare("SELECT name FROM name WHERE id == \"#{@name}\"")
			familyMember = @selectFM.execute
			binding.pry
		return familyMember
	end

# This is the end for the class	Task.
end

