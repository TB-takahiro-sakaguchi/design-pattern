class Renderer
  def render(text_object)
    text = text_object.text
    size = text_object.size_inches
    color = text_object.color

    puts text
    puts size
    puts color
  end
end

class TextObject
  attr_reader :text, :size_inches, :color

  def initialize(text, size_inches, color)
    @text = text
    @size_inches = size_inches
    @color = color
  end
end

class BritishTextObject
  attr_reader :string, :size_mm, :colour

  def initialize(string, size_mm, colour)
    @string = string
    @size_mm = size_mm
    @colour = colour
  end
end

text_object = TextObject.new('Hello World!!!', 500, 'black')
Renderer.new.render(text_object)

bto = BritishTextObject.new('Good Bye!!!', 400, 'white')
class << bto
  def text
    string
  end

  def size_inches
    size_mm / 10
  end

  def color
    colour
  end
end
Renderer.new.render(bto)

