class BankAccount
  attr_reader :balance

  def initialize(starting_balance = 0)
    @balance = starting_balance
  end

  def deposit(amount)
    @balance += amount
  end

  def withdraw(amount)
    @balance -= amount
  end
end

# 防御プロキシ
class AccountProtectionProxy
  def initialize(real_account, role)
    @subject = real_account
    @role = role
  end

  def deposit(amount)
    check_access
    @subject.deposit(amount)
  end

  def withdraw(amount)
    check_access
    @subject.withdraw(amount)
  end

  def check_access
    raise "Illegal access: #{@role} role cannot access account." unless @role == :admin
  end
end

account = BankAccount.new(100)
account.deposit(50)
account.withdraw(10)
puts account.balance # => 140

proxy = AccountProtectionProxy.new(account, :admin)
proxy.deposit(60)
proxy.withdraw(20)
puts account.balance # => 180

proxy = AccountProtectionProxy.new(account, :member)
proxy.deposit(30) # => Illegal access: member role cannot access account. (RuntimeError)

