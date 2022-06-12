# Context
class Report
  attr_reader :title, :text
  attr_accessor :formatter

  def initialize(formatter)
    @title = 'report title'
    @text = %w[text1 text2 text3]
    @formatter = formatter
  end

  def output_report
    @formatter.output_report(self)
  end
end

# Strategy
class HtmlFormatter
  def output_report(context)
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
end

# Strategy
class PlainTextFormatter
  def output_report(context)
    puts("***** #{context.title} *****")
    context.text.each do |line|
      puts(line)
    end
  end
end

html_formatter = HtmlFormatter.new
report = Report.new(html_formatter)
report.output_report

puts
puts('==========')
puts

plain_text_formatter = PlainTextFormatter.new
report = Report.new(plain_text_formatter)
report.output_report

puts
puts('==========')
puts

report.formatter = html_formatter
report.output_report
