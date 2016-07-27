All tasks: GET /api/tasks
Individual tasks: GET /api/individualfamilymember?person=[name]





Example returned json file:

{"tasks":[{"status":"c","familyMember":"Mary","taskDescription":"Mop the basement","taskID":"52679669"},{"status":"c","familyMember":"Lisa","taskDescription":"Vacuum the rug","taskID":"34587544"},{"status":"i","familyMember":"Bob","taskDescription":"Change the AC filter","taskID":"88008004"},{"status":"i","familyMember":"Bob","taskDescription":"Dust the book shelves","taskID":"68249195"},{"status":"i","familyMember":"Mary","taskDescription":"Rake the leaves","taskID":"95182081"}]}

Key:
"i" - incomplete task
"c" - completed task
"taskID" - random task identifier




This API returns a json file with the current and completed tasks for the Johnson family.  Please feel free to use this data in any way you see fit.