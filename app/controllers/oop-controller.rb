MyApp.get "/" do

	@incompleteTasks = Task.sort_by_incomplete_tasks
	@completedTasks = Task.sort_by_completed_tasks
	erb :"home"

end


#I think i need to populate the ids for this!  Or something, somehow the edit function does
# not work for the filtered erb.... !!!
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
  	addNewVersionofTask = Task.editTask(params[:num],params[:person], params[:task], params[:status])
  	redirect '/'
end



MyApp.post '/delete' do
	@deleteTaskByID = Task.deleteTask(params[:num])
	redirect '/'
end
