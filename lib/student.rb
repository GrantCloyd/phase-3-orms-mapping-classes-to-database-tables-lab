class Student
  attr_reader :id
  attr_accessor :name, :grade
  def initialize(name, grade, id=nil)
  @name = name
  @grade = grade
  @id = id
  end

  def self.create_table  
  sql = <<-SQL
    CREATE TABLE IF NOT EXISTS students(
      id INTEGER PRIMARY KEY,
      name TEXT,
      grade TEXT
      
    );
     SQL
     DB[:conn].execute(sql)
  end

  def self.drop_table 
  sql = "
  DROP TABLE IF EXISTS students;
  "
  DB[:conn].execute(sql)
  end

  def save  
  sql = <<-SQL 
  INSERT INTO students (name, grade) VALUES ("#{self.name}", "#{self.grade}")
  SQL
  DB[:conn].execute(sql)

  @id = DB[:conn].execute("SELECT last_insert_rowid() FROM Students").first.first
  end

  def self.create(hashtributes = {})
   #hashtributes.each {|key, value| self.send(("#{key}="), value)}
   student = Student.new(hashtributes[:name], hashtributes[:grade])
   student.save
   student
  end

  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]  
  
end
