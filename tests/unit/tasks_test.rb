require 'test_helper'
require 'pry'

class ORMTest < Minitest::Test

	def setup
		super
		DB.execute("DELETE FROM tasks")
	end

	def test_whereID
		DB.execute("INSERT into tasks (name, task, status) VALUES (1, \"Make Paint\", 2)")
		@last_id = DB.last_insert_row_id
		new_task = Task.whereID(@last_id)
		
		refute_nil(new_task)
		assert_kind_of(Object, new_task)
		assert_equal("Make Paint", new_task.task)
		assert_equal(@last_id, new_task.id)
	end

	def test_save
		new_task = Task.save("Make Paint", 1)

		refute_nil(new_task)
		assert_kind_of(Object, new_task)
		assert_equal("Make Paint", new_task.task)
		assert_equal(1, new_task.name)		
	end

	def test_deleteTask
		DB.execute("INSERT into tasks (name, task, status) VALUES (1, \"Make Paint\", 2)")
		@last_id = DB.last_insert_row_id
		del_task = Task.deleteTask(@last_id)

		not_a_task = DB.execute("SELECT * FROM tasks WHERE id == #{@last_id}")
		check_for_task_info = not_a_task[0]
		
		assert_equal(check_for_task_info, nil)
	end

	def test_update_attributes
		DB.execute("INSERT into tasks (name, task, status) VALUES (1, \"Make Paint\", 2)")
		@last_id = DB.last_insert_row_id
		new_task = Task.whereID(@last_id)

		new_task.update_attributes(@last_id, 1, "Make Red Paint", 2)
		
		refute_nil(new_task)
		assert_kind_of(Object, new_task)
		assert_equal("Make Red Paint", new_task.task)
		assert_equal(@last_id, new_task.id)
	end

	def test_sort_by_status
		@status = 1
		DB.execute("INSERT into tasks (name, task, status) VALUES (1, \"Make Red Paint\", 1), (2, \"Make Blue Paint\", 2)")
		complete_tasks = Task.sort_by_status(@status)
		

		how_many_tasks = DB.execute("SELECT * FROM tasks")
		check_for_task_info = how_many_tasks[0]
		binding.pry

		assert_equal(complete_tasks, 1)
		assert_kind_of(Object, complete_tasks)
		assert_equal(check_for_task_info["status"], 1)
	end

end