require './report'
require './html_report'
require './plain_text_report'

html_report = HtmlReport.new
html_report.output_report

plain_text_report = PlainTextReport.new
plain_text_report.output_report
