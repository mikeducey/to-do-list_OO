
module ClassMethods

  # Selects a task from the database based on the id.
  #
  # This will be used to populate the data field when a task is to be edited.

  def find(table, id)
    selectTask = DB.execute("SELECT * FROM #{table} WHERE id == #{id}")
    selectedTask = selectTask[0]

    self.new(selectedTask["id"], selectedTask["task"], selectedTask["name"], selectedTask["status"])
  end

  # Deletes a task from the database based on the id.
  #
  # Nothing should be returned!

  def delete(table, id)
    DB.execute("DELETE from #{table} WHERE id == #{id}")
  end


end
