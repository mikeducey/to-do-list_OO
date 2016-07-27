MyApp.get "/" do

	@taskList = Task.new("tasks.txt")
	@completedTasks = @taskList.completedTasks
	@incompleteTasks = @taskList.incompleteTasks
	erb :"home"

end

MyApp.get "/new" do
	erb :"new"
end


