MyApp.get "/" do

	@incompleteTasks = Task.sort_by_status(2)
	@completedTasks = Task.sort_by_status(1)
	erb :"home"

end


#I think i need to populate the ids for this!  Or something, somehow the edit function does
# not work for the filtered erb.... !!!
MyApp.get "/filtered" do

	@theseAreNotDone = Task.family_member_sorted_by_status(params[:user], 2)
	@theseAreDone = Task.family_member_sorted_by_status(params[:user], 1)
	@member = Name.print_name(params[:user])
	erb :"filtered"
end

MyApp.get "/new" do
	erb :"new"
end

MyApp.post "/new/process" do

	addTask = Task.save(params[:task], params[:person])
	redirect '/'
end

MyApp.post "/edit" do
	@selectTaskforEdit = Task.whereID(params[:num])
	erb :"edit"
end


MyApp.post "/edit/process" do
	selectedTask = Task.whereID(params[:num])
  	addNewVersionofTask = selectedTask.update_attributes(params[:num],params[:person], params[:task], params[:status])
  	redirect '/'
end



MyApp.post '/delete' do
	@deleteTaskByID = Task.deleteTask(params[:num])
	redirect '/'
end
