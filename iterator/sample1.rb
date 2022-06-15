# 外部イテレータ
class ArrayIterator
  def initialize(array)
    @array = array
    @index = 0
  end

  def next?
    @index < @array.length
  end

  def item
    @array[@index]
  end

  def next_item
    value = @array[@index]
    @index += 1
    value
  end
end

array = %w[red green blue]
i = ArrayIterator.new(array)
puts("item: #{i.next_item}") while i.next?
# item: red
# item: green
# item: blue

i = ArrayIterator.new('abc')
puts("item: #{i.next_item}") while i.next?
# item: a
# item: b
# item: c

# 内部イテレータ
array.each { |element| puts("The element is #{element}") }
# The element is red
# The element is green
# The element is blue
