MyApp.get "/" do

	@completedTasks = Task.completedTasks("tasks.txt")
	@incompleteTasks = Task.incompleteTasks("tasks.txt")
	erb :"home"

end


MyApp.get "/new" do
	erb :"new"
end

MyApp.get "/api/tasks" do
	require 'json'
	tasks_api = Task.convertToHash("tasks.txt")
	return tasks_api.to_json
end

MyApp.get "/api/individualfamilymember" do
	require 'json'
	family_member_tasks_api = Task.convertToHashForFamilyMember("tasks.txt", params[:person])
	return family_member_tasks_api.to_json
end

MyApp.post "/new/process" do

	@rightEmail = Task.sortByName(params[:person], "Bob", "Mary", "Joe", "Lisa", "michaeljducey@gmail.com", "michaeljducey@gmail.com", "mhughes27@gmail.com", "mhughes27@gmail.com")
	sendEmail = Task.sendTaskReminder(@rightEmail, params[:person], params[:task])
	@newtask = Task.createNewTask("tasks.txt", params[:person], params[:task], rand(99999999))
	redirect '/'
end


MyApp.post "/edit" do
	@task = params[:task]
	@person = params[:person]
	@status = params[:status]

	Task.editTask(params[:num], "tasks.txt")
	erb :"edit"
end


MyApp.post "/edit/process" do
	Task.deleteTask(params[:num],"tasks.txt")
	@edittask = Task.editExistingTask("tasks.txt", params[:status], params[:person], params[:task], rand(99999999))
  	redirect '/'
end



MyApp.post '/delete' do
	Task.deleteTask(params[:num],"tasks.txt")
	redirect '/'
end
