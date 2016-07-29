MyApp.get "/" do

	@taskList = Task.new("name", "task")
	@incompleteTasks = @taskList.sort_by_incomplete_tasks
	@completedTasks = @taskList.sort_by_completed_tasks
	erb :"home"

end

MyApp.get "/filtered" do
	@filteredbyFamMember = Task.new(params[:user], "task")
	@theseAreNotDone = @filteredbyFamMember.sort_by_family_member_incomplete
	@theseAreDone = @filteredbyFamMember.sort_by_family_member_complete
	@member = @filteredbyFamMember.print_name
	erb :"filtered"
end


MyApp.get "/new" do
	erb :"new"
end

MyApp.post "/new/process" do

	@newtask = Task.new(params[:person], params[:task])
	addTask = @newTask.createNewTask
	redirect '/'
end
