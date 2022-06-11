require './report'
require './html_formatter'
require './plain_text_formatter'

html_formatter = HtmlFormatter.new
report = Report.new(html_formatter)
report.output_report

plain_text_formatter = PlainTextFormatter.new
report = Report.new(plain_text_formatter)
report.output_report

report.formatter = html_formatter
report.output_report
