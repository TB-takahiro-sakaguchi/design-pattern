# Context
class Report
  attr_reader :title, :text
  attr_accessor :formatter

  def initialize(&formatter)
    @title = 'report title'
    @text = %w[text1 text2 text3]
    @formatter = formatter
  end

  def output_report
    @formatter.call(self)
  end
end

# Strategy(Proc)
HTML_FORMATTER = lambda do |context|
  puts('<html>')
  puts(' <head>')
  puts("  <title>#{context.title}</title>")
  puts(' </head>')
  puts(' <body>')
  context.text.each do |line|
    puts("  <p>#{line}</p>")
  end
  puts(' </body>')
  puts('</html>')
end

# Strategy(Proc)
PLAIN_TEXT_FORMATTER = lambda do |context|
  puts("***** #{context.title} *****")
  context.text.each do |line|
    puts(line)
  end
end

report = Report.new(&HTML_FORMATTER)
report.output_report
# <html>
#  <head>
#   <title>report title</title>
#  </head>
#  <body>
#   <p>text1</p>
#   <p>text2</p>
#   <p>text3</p>
#  </body>
# </html>

report = Report.new(&PLAIN_TEXT_FORMATTER)
report.output_report
# ***** report title *****
# text1
# text2
# text3
