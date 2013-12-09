# Tex2Png - A Sinatra Web App which lets you convert LaTeX mathematical formulas to png images via http requests.
#
# Dependencies: LaTeX
#
# Inspired by Tex2Png by Thomas Pelletier (https://github.com/pelletier/tex2png)

require 'sinatra'
require 'digest'
load 'settings.rb'

# LaTeX document skeleton
document_top = "\\documentclass{article}
\\everymath{\\displaystyle}
\\begin{document}
\\pagestyle{empty}
$"

document_bottom = "$
\\end{document}"

# Document resolution, hardcoded.
resolution = 119

get "/" do
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
