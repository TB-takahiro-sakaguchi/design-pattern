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

# 仮想プロキシ1
# -> BankAccountインスタンスの生成を遅延させる
class VirtualAccountProxy1
  def initialize(starting_balance = 0)
    @starting_balance = starting_balance
  end

  def balance
    subject.balance
  end

  def deposit(amount)
    subject.deposit(amount)
  end

  def withdraw(amount)
    subject.withdraw(amount)
  end

  def subject
    @subject || (@subject = BankAccount.new(@starting_balance))
  end
end

proxy1 = VirtualAccountProxy1.new(100)
proxy1.deposit(50)
proxy1.withdraw(10)
puts proxy1.balance # => 140

# 仮想プロキシ2
# -> BankAccountインスタンス生成を遅延させる
# -> BankAccountインスタンス生成の責務を除外する
class VirtualAccountProxy2
  def initialize(&creation_block)
    @creation_block = creation_block
  end

  def balance
    subject.balance
  end

  def deposit(amount)
    subject.deposit(amount)
  end

  def withdraw(amount)
    subject.withdraw(amount)
  end

  def subject
    @subject || (@subject = @creation_block.call)
  end
end

proxy2 = VirtualAccountProxy1.new(200)
proxy2.deposit(100)
proxy2.withdraw(50)
puts proxy2.balance # => 250

# 仮想プロキシ3
# -> BankAccountインスタンス生成を遅延させる
# -> BankAccountインスタンス生成の責務を除外する
# -> メソッドを繰り返し記述するのをやめる
class VirtualAccountProxy3
  def initialize(&creation_block)
    @creation_block = creation_block
  end

  def method_missing(name, *args)
    subject.send(name, *args)
  end

  def respond_to_missing?(sym, include_private)
    subject.respond_to?(sym) ? true : super
  end

  def subject
    @subject || (@subject = @creation_block.call)
  end
end

proxy3 = VirtualAccountProxy1.new(500)
proxy3.deposit(200)
proxy3.withdraw(350)
puts proxy3.respond_to?(:balance) # => true
puts proxy3.balance # => 350
puts proxy3.respond_to?(:destroy) # => false
puts proxy3.destroy # => undefined method `destroy' for #<VirtualAccountProxy1:0x00007fdd5b0979b0> (NoMethodError)

