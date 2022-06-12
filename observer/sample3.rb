# Subject
module Subject
  def initialize
    @observers = []
  end

  def add_observer(&observer)
    @observers << observer
  end

  def delete_observer(observer)
    @observers.delete(observer)
  end

  def notify_observers
    @observers.each do |observer|
      observer.call(self)
    end
  end
end

# Observable
class Employee
  include Subject

  attr_reader :name, :address
  attr_reader :salary

  def initialize(name, title, salary)
    super()
    @name = name
    @title = title
    @salary = salary
  end

  def salary=(new_salary)
    @salary = new_salary
    notify_observers
  end
end

fred = Employee.new('Fred', 'Crane Operator', 30_000.0)
fred.add_observer do |changed_employee|
  puts("updated: #{changed_employee.name}")
  puts("now salary: #{changed_employee.salary}")
end
fred.salary = 35_000.0
# updated: Fred
# now salary: 35000.0
