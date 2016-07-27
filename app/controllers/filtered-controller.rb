MyApp.get "/filtered" do
	@theseAreNotDone = Task.familyMemberIncompleteTasks("tasks.txt", params[:user])
	@theseAreDone = Task.familyMemberCompletedTasks("tasks.txt", params[:user])
	@member = params[:user]
	erb :"filtered"
end


