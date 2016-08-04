require 'test_helper'
require 'pry'

class ORMTest < Minitest::Test

	def setup
		super
		DB.execute("DELETE FROM tasks")
		DB.execute("DELETE FROM name")
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

		how_many_tasks = complete_tasks.count
		check_for_task_info = complete_tasks[0]

		assert_equal(how_many_tasks, 1)
		assert_kind_of(Object, complete_tasks)
		assert_equal(check_for_task_info.status, 1)
	end

	def test_family_member_sorted_by_status
		@name = 2
		@status = 2
		DB.execute("INSERT into tasks (name, task, status) VALUES (1, \"Make Red Paint\", 1), (2, \"Make Blue Paint\", 2)")
		fam_mem_sorted_incomplete = Task.family_member_sorted_by_status(@name, @status)

		how_many_tasks = fam_mem_sorted_incomplete.count
		check_for_task_info = fam_mem_sorted_incomplete[0]

		assert_equal(how_many_tasks, 1)
		assert_kind_of(Object, fam_mem_sorted_incomplete)
		assert_equal(check_for_task_info.status, 2)
		assert_equal(check_for_task_info.name, 2)
	end

	def test_print_name
		@name = 4
		DB.execute("INSERT INTO name (name) VALUES (\"Bob\"), (\"Mary\"), (\"Joe\"), (\"Lisa\")")
		family_name = Name.print_name(@name)

		assert_equal(family_name.name, "Lisa")
		assert_kind_of(Object, family_name)
	end


end