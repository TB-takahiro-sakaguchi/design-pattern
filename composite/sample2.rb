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

  def <<(task)
    @sub_tasks << task
    task.parent = self
  end

  def [](index)
    @sub_tasks[index]
  end

  def []=(index, new_value)
    @sub_tasks[index] = new_value
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

first_task = FirstTask.new
second_task = SecondTask.new
composite = CompositeTask.new('Composite task')
composite << first_task
composite << second_task

puts composite.time_required
# 3.0

puts composite[0].time_required
# 1.0

puts composite[1].time_required
# 2.0

composite[0] = second_task
puts composite.time_required
# 4.0
