class Account
  attr_accessor :name, :balance

  def initialize(name, balance)
    @name = name
    @balance = balance
  end
end

class Portfolio
  include Enumerable

  def initialize
    @accounts = []
  end

  def each(&block)
    @accounts.each(&block)
  end

  def add_account(account)
    @accounts << account
  end
end

my_portfolio = Portfolio.new
my_portfolio.add_account(Account.new('first', 1_000))
my_portfolio.add_account(Account.new('second', 2_000))
my_portfolio.add_account(Account.new('third', 3_000))
my_portfolio.add_account(Account.new('fourth', 4_000))

puts 'yes' if my_portfolio.any? { |account| account.balance > 2_000 }
# yes

puts 'yes' if my_portfolio.all? { |account| account.balance > 100 }
# yes
