# Component
class Task
  attr_accessor :name, :parent

  def initialize(name)
    @name = name
    @parent = nil
  end

  def time_required
    0.0
  end
end

# Composite
class CompositeTask < Task
  def initialize(name)
    super(name)
    @sub_tasks = []
  end

  def add_sub_task(task)
    @sub_tasks << task
    task.parent = self
  end

  def remove_sub_task(task)
    @sub_tasks.delete(task)
    task.parent = nil
  end

  def time_required
    time = 0.0
    @sub_tasks.each { |task| time += task.time_required }
    time
  end
end

# Leaf
class FirstTask < Task
  def initialize
    super('The first task')
  end

  def time_required
    1.0
  end
end

# Leaf
class SecondTask < Task
  def initialize
    super('The second task')
  end

  def time_required
    2.0
  end
end

# Composite Object
class DailyTask < CompositeTask
  def initialize
    super('Daily task')
    add_sub_task(FirstTask.new)
    add_sub_task(SecondTask.new)
  end
end

daily_task = DailyTask.new
puts daily_task.time_required
