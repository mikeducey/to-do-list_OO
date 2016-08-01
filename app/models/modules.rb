
module TaskORM

  def self.find(id)
    records = DB.execute("SELECT * FROM #{table} WHERE id == #{id}")
    record = records[0]

    self.new(fields)
  end

  def self.findByStatus(status)
  	records = DB.execute("SELECT * FROM #{table} WHERE status == \"#{status}\"")
  end

  def self.findByNameAndStatus(name, status)
  	records = DB.execute("SELECT * FROM #{table} WHERE name == \"#{name}\" and status == \"#{status}\"")
  end

  def self.findByName(name)
  	names = DB.execute("SELECT * FROM #{table} WHERE name == \"#{name}\"")
  	name = names[0]

    Task.new(fields)
  end

end
