class Report < ApplicationRecord
  include Discard::Model


  def item(text)
    @count ||= 0
    @count += 1
    bold "#{@count}. #{text}"
  end

  def order
    options[:order]
  end
end

report = MyReport.new File.join(__dir__, 'report.erb'), {
  order: { id: 70 }
}
@printer << report.render
@printer.cut!
@printer.to_escpos
File.open('/dev/usb/lp0', 'w:ascii-8bit') { |f| f.write(printer.to_escpos) }
# @printer.to_escpos or @printer.to_base64 contains resulting ESC/POS data


end