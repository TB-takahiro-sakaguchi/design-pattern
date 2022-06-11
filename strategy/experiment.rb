require './report'
require './html_formatter'
require './plain_text_formatter'

report = Report.new(HtmlFormatter.new)
report.output_report

report = Report.new(PlainTextFormatter.new)
report.output_report
