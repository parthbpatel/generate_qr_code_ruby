require 'prawn/qrcode'
require 'prawn/measurement_extensions'

def generate_qr_code_and_render_in_pdf
  pdf = Prawn::Document.new(page_size: [65.mm, 40.mm], margin: [10,10,10,10])
  pdf.font_size 8
  array = %w[Parth https://botreetechnologies.com]
  array.each do |row|
    puts "generating QR code for: #{row}"
    qrcode_content = row
    if !qrcode_content.empty?
      qrcode = RQRCode::QRCode.new(row, level: :h, size: 4)
      pdf.move_down(5)
      pdf.render_qr_code(qrcode, dot: 1.2, align: :left)
      pdf.move_up(20)
      pdf.indent(55) do
        pdf.text qrcode_content
      end
      pdf.start_new_page
    end
  end
  pdf.render_file("sample.pdf")
end
generate_qr_code_and_render_in_pdf
