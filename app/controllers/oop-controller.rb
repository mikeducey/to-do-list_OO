MyApp.get "/" do

	@incompleteTasks = Task.sort_by_incomplete_tasks
	@completedTasks = Task.sort_by_completed_tasks
	erb :"home"

end


MyApp.get "/filtered" do

	@theseAreNotDone = Task.sort_by_family_member_incomplete(params[:user])
	@theseAreDone = Task.sort_by_family_member_complete(params[:user])
	@member = Task.print_name(params[:user])
	erb :"filtered"
end

MyApp.get "/new" do
	erb :"new"
end

MyApp.post "/new/process" do

	addTask = Task.addNewTask(params[:task], params[:person])
	redirect '/'
end

MyApp.post "/edit" do
	@selectTaskforEdit = Task.selectTask(params[:num])
	erb :"edit"
end


MyApp.post "/edit/process" do  
	@ManipulateTask = Task.new(params[:num], params[:person], params[:task], params[:status])
  	@removeOldTask = @ManipulateTask.deleteTask
  	@addNewVersionofTask = @ManipulateTask.editTask
  	redirect '/'
end



MyApp.post '/delete' do
	@deleteTaskByID = Task.deleteTask(params[:num])
	redirect '/'
end
