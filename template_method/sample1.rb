# 基底抽象クラス
class Report
  def initialize
    @title = '月次報告'
    @text = %w[順調 最高の調子]
  end

  def output_report
    output_start
    output_head
    output_body_start
    output_body
    output_body_end
    output_end
  end

  # フックメソッド
  def output_start; end

  # フックメソッド
  def output_head
    # 標準実装
    output_line(@title)
  end

  # フックメソッド
  def output_body_start; end

  def output_body
    @text.each do |line|
      output_line(line)
    end
  end

  def output_line(_line)
    raise 'Called abstract method: output_line'
  end

  # フックメソッド
  def output_body_end; end

  # フックメソッド
  def output_end; end
end

# 具象クラス
class HtmlReport < Report
  def output_start
    puts('<html>')
  end

  def output_head
    puts(' <head>')
    puts(" <title>#{@title}</title>")
    puts(' </head>')
  end

  def output_body_start
    puts(' <body>')
  end

  def output_line(line)
    puts("  <p>#{line}</p>")
  end

  def output_body_end
    puts(' </body>')
  end

  def output_end
    puts('</html>')
  end
end

# 具象クラス
class PlainTextReport < Report
  def output_head
    puts("**** #{@title} ****")
  end

  def output_line(line)
    puts(line)
  end
end

html_report = HtmlReport.new
html_report.output_report

plain_text_report = PlainTextReport.new
plain_text_report.output_report
