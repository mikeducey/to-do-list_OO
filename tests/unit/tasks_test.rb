require 'test_helper'

class TaskTest < Minitest::Test
    def setup
        super

    end

	def test_separate_tasks_in_file 
        results = Task.searchForName("#{MyApp.settings.root}/tests/unit/tasks_test.txt")
		assert_equal([["i", "Bob", "Scoop the cat litter", "98174236\n"], ["c", "Bob", "Mop the mud room floor", "38374236\n"], ["i", "Mary", "Clean the fish bowl", "28374416\n"], ["c", "Mary", "Change the AC filter", "28354455\n"], ["i", "Joe", "Sweep the porch", "68364455\n"], ["c", "Joe", "Make beds", "68364456\n"], ["i", "Lisa", "Vacuum the living room carpet", "68364459\n"], ["c", "Lisa", "Do the dishes", "98174836"]], results)
	end

    def test_separate_by_name
        results = Task.searchForFamilyMember("#{MyApp.settings.root}/tests/unit/tasks_test.txt", "Bob")
        assert_equal([["i", "Bob", "Scoop the cat litter", "98174236\n"], ["c", "Bob", "Mop the mud room floor", "38374236\n"]], results)
    end

    def test_family_member_completed_tasks
        results = Task.familyMemberCompletedTasks("#{MyApp.settings.root}/tests/unit/tasks_test.txt", "Bob")
        assert_equal([["c", "Bob", "Mop the mud room floor", "38374236\n"]], results)
    end

    def test_family_member_incomplete_tasks 
        results = Task.familyMemberIncompleteTasks("#{MyApp.settings.root}/tests/unit/tasks_test.txt", "Bob")
        assert_equal([["i", "Bob", "Scoop the cat litter", "98174236\n"]], results)
    end

    def test_sort_by_completed_tasks
        results = Task.completedTasks("#{MyApp.settings.root}/tests/unit/tasks_test.txt")
        assert_equal([["c", "Bob", "Mop the mud room floor", "38374236\n"], ["c", "Mary", "Change the AC filter", "28354455\n"], ["c", "Joe", "Make beds", "68364456\n"], ["c", "Lisa", "Do the dishes", "98174836"]], results)
    end

    def test_sort_by_incomplete_tasks   
        results = Task.incompleteTasks("#{MyApp.settings.root}/tests/unit/tasks_test.txt")
        assert_equal([["i", "Bob", "Scoop the cat litter", "98174236\n"], ["i", "Mary", "Clean the fish bowl", "28374416\n"], ["i", "Joe", "Sweep the porch", "68364455\n"], ["i", "Lisa", "Vacuum the living room carpet", "68364459\n"]], results)
    end

    def test_find_a_task
        results = Task.findTask(10, [[1,2,3,4],[4,5,6,7],[7,8,9,10]])
        assert_equal(2, results)
    end

    def test_delete_a_task
        results = Task.deleteTask(98174836, "#{MyApp.settings.root}/tests/unit/tasks_test_delete.txt")
        assert_equal(nil, results)
    end
    # After this test runs, make sure the tasks_text_delete.txt contains the same array info as tasks_test.txt

    def test_edit_a_task_add_new_function_part
        results = Task.editExistingTask("#{MyApp.settings.root}/tests/unit/tasks_test_model_file.txt", "i", "Bob", "Run the Roomba", "28373316")
        assert_equal(nil, results)
    end
    # After this test runs, make sure to check that the file is returned to its original state.

    def test_create_a_new_task
        results = Task.createNewTask("#{MyApp.settings.root}/tests/unit/tasks_test_add_new.txt", "Bob", "Sweep up Grandpa's ashes", "12373514")
        assert_equal(nil, results)
    end
    # After this test runs, make sure that task_test_add_new.txt and tasks_test.txt is returned to its original state.

    def test_sort_email_by_family_member
        results = Task.sortByName("Bob", "Bob", "Mary", "Joe", "Lisa", "fakeemail1@gmail.com", "fakeemail2@gmail.com", "fakeemail3@gmail.com", "fakeemail4@gmail.com")
        assert_equal("fakeemail1@gmail.com", results)
    end

    def test_send_email_to_family_member
        results = Task.sendTaskReminder("michaeljducey@gmail.com", "Bob", "Make Paint")
        assert_equal("Queued. Thank you.", results)
    end

    def test_convertToHash
        results = Task.convertToHash("#{MyApp.settings.root}/tests/unit/tasks_test_api.txt")
        assert_equal({"tasks" => [{"status" => "i", "familyMember" => "Bob", "taskDescription" => "Scoop the cat litter", "taskID" => "98174236"}, {"status" => "c", "familyMember" => "Bob", "taskDescription" => "Mop the mud room floor", "taskID" => "38374236"}]}, results)
    end
end