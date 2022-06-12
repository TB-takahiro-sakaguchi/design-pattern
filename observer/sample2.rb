require 'observer'

# Observable
class Employee
  include Observable

  attr_reader :name, :address
  attr_reader :salary

  def initialize(name, title, salary)
    @name = name
    @title = title
    @salary = salary
  end

  def salary=(new_salary)
    @salary = new_salary
    changed # オブジェクトが変更されたかどうかのフラグを設定する
    notify_observers(self)
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
  def confirm(changed_employee)
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
fred.add_observer(tax_man, :confirm)
fred.salary = 45_000.0
# updated: Fred
# now salary: 45000.0
# Fred was confirmed by TaxMan

puts fred.count_observers
# 2

fred.delete_observer(payroll)
fred.salary = 47_000.0
# Fred was confirmed by TaxMan

puts fred.count_observers
# 1
