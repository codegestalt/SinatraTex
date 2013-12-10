# SinatraTex - A Sinatra Web App which lets you convert LaTeX to different formats (pdf/png)
#
# 1) post to /pdf converts tex to pdf      | params: { name: 'filename', tex: 'tex' }
# 2) get  to /png converts math tex to png | params: { tex: "y=f(x)" }
#    Example: localhost:9292/png?tex=y=f(x)
#
# Dependencies: LaTeX, STIX Fonts

require "rubygems"
require "sinatra/base"
require 'digest'
require 'json'
load 'settings.rb'

class SinatraTex < Sinatra::Base

  post "/pdf" do
    name = params[:name]
    tex  = params[:tex]

    # Prepare data
    m = Digest::MD5.new
    m.update("%s%s" % [name, tex])
    uid = m.hexdigest

    # Compute the resulting pdf path
    pdf_path = "%s/%s.pdf" % [TEMP_PDF, uid]

    # This file already exists
    if File.exists?(pdf_path)
      # Return existing pdf
      content_type "application/pdf"
      return File.read(File.join(pdf_path))
    end

    tex_path = '%s/%s.tex' % [TEMP_TEX, uid]
    tex_file = File.open(tex_path, 'w')
    tex_file.write(tex)
    tex_file.close

    system("pdflatex --interaction=nonstopmode -output-directory=%s %s" % [TEMP_PDF, tex_path])
    if File.exists?(pdf_path)
      content_type "application/pdf"
      return File.read(File.join(pdf_path))
    end
  end

  # The png conversion is based on Thomas Pelletier's Tex2Png (https://github.com/pelletier/tex2png), thanks for the bacon!
  get "/png" do

    # LaTeX document skeleton
    document_top = "\\documentclass{article}
    \\usepackage{stix}
    \\usepackage{mathtools}
    \\everymath{\\displaystyle}
    \\begin{document}
    \\pagestyle{empty}
    $"

    document_bottom = "$
    \\end{document}"

    # Document resolution, hardcoded.
    resolution = 119

    tex = params[:tex]

    # Prepare data
    m = Digest::MD5.new
    m.update("%s" % [tex])
    uid = m.hexdigest

    # Compute the resulting png path
    png_path = "%s/%s.png" % [TEMP_PNG, uid]

    # This file already exists
    if File.exists?(png_path)
      # Return existing image
      content_type "image/png"
      return File.read(File.join(png_path))
    end

    # Assemble the complete document source code (head + corp + foot)
    complete_tex_doc = "%s%s%s" % [document_top, tex, document_bottom]

    # Write the tex file
    tex_path = '%s/%s.tex' % [TEMP_TEX, uid]
    tex_file = File.open(tex_path, 'w')
    tex_file.write(complete_tex_doc)
    tex_file.close()

    # Convert to dvi
    system("latex --interaction=nonstopmode -output-directory=%s %s" % [TEMP_DVI, tex_path])

    # We do not need the tex file anymore
    system("rm %s" % [tex_path])

    # Compute the complete dvi file path
    dvi_path = "%s/%s.dvi" % [TEMP_DVI, uid]

    # The compilation succeeded, have fun with png
    if File.exists?(dvi_path)

      # Convert to png
      system("dvipng -T tight -bg Transparent -D %s -o %s %s" % [resolution, png_path, dvi_path])

      # Remove the dvi file
      system("rm %s" % [dvi_path])

      # Return the result of our beautiful work
      content_type "image/png"
      File.read(File.join(png_path))
    else
      # TODO: Log when something nasty happened during the compilation
    end
  end

end
