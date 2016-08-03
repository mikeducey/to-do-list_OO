require 'test_helper'

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

		no_task = Task.deleteTask(@last_id)

	end
end