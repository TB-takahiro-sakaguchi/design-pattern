# Subject
module Subject
  def initialize
    @observers = []
  end

  def add_observer(observer)
    @observers << observer
  end

  def delete_observer(observer)
    @observers.delete(observer)
  end

  def notify_observers
    @observers.each do |observer|
      observer.update(self)
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

# Observer
class Payroll
  def update(changed_employee)
    puts("updated: #{changed_employee.name}")
    puts("now salary: #{changed_employee.salary}")
  end
end

# Observer
class TaxMan
  def update(changed_employee)
    puts("#{changed_employee.name} was confirmed by TaxMan")
  end
end

fred = Employee.new('Fred', 'Crane Operator', 30_000.0)
payroll = Payroll.new
fred.add_observer(payroll)
fred.salary = 36_000.0
# updated: Fred
# now salary: 36000.0

tax_man = TaxMan.new
fred.add_observer(tax_man)
fred.salary = 45_000.0
# updated: Fred
# now salary: 45000.0
# Fred was confirmed by TaxMan

fred.delete_observer(payroll)
fred.salary = 47_000.0
# Fred was confirmed by TaxMan
