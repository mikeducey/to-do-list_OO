require 'test_helper'

class ORMTest < Minitest::Test

	def test_save
		DB.execute("INSERT into tasks (name, task, status) VALUES (1, \"Make Paint\", 2)")
		last_id = DB.last_insert_row_id
		new_task = Task.whereID(last_id)

		new_task.update_attributes(last_id, 1, "Make Red Paint", 2)
		
		refute_nil(new_task)
		assert_equal("Make Red Paint", new_task.task)
		assert_equal(last_id, new_task.id)
	end

end