MyApp.get "/" do

	@incompleteTasks = Task.sort_by_status(2)
	@completedTasks = Task.sort_by_status(1)
	erb :"home"

end

MyApp.get "/filtered" do

	@theseAreNotDone = Task.family_member_sorted_by_status(params[:user], 2)
	@theseAreDone = Task.family_member_sorted_by_status(params[:user], 1)
	@member = Name.print_name(params[:user])
	erb :"filtered"
end

MyApp.post "/new/process" do

	addTask = Task.save(params[:task], params[:person])
	redirect '/'
end


MyApp.post "/edit/process" do
	selectedTask = Task.find("tasks", params[:num])
  	addNewVersionofTask = selectedTask.update_attributes(params[:num],params[:person], params[:task], params[:status])
  	redirect '/'
end



MyApp.post '/delete' do
	@deleteTaskByID = Task.delete("tasks", params[:num])
	redirect '/'
end
