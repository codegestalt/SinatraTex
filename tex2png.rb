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
# \\usepackage{amssymb,amsmath}
# \\usepackage{mathtools}
# \\usepackage{dsfont}
# \\everymath{\displaystyle}

document_bottom = "$
\\end{document}"

# Document resolutions, hardcoded. This is the result of:
# >>> MAX_RES = 10
# >>> [int(round(100*2**(i/4.0))) for i in range(MAX_RES+1)]
# resolutions = [100, 119, 141, 168, 200, 238, 283, 336, 400, 476, 566]
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

  # if not int(size) in range(1, 11):
  #   log("err", "Size %s not in range (1 to 10)" % size)
  #   return ErrorImage()
  # end

  # Assemble the complete document source code (head + corp + foot)
  complete_tex_doc = "%s%s%s" % [document_top, tex, document_bottom]

  # Write the tex file
  tex_path = '%s/%s.tex' % [TEMP_TEX, uid]
  tex_file = File.open(tex_path, 'w')
  tex_file.write(complete_tex_doc)
  tex_file.close()

  # Convert to dvi
  system("latex --interaction=nonstopmode -output-directory=%s %s" % [TEMP_DVI, tex_path])
  # log("render", "%s (size=%s)" % (tex, size))

  # We do not need the tex file anymore
  system("rm %s" % [tex_path])

  # Compute the complete dvi file path
  dvi_path = "%s/%s.dvi" % [TEMP_DVI, uid]

  # The compilation succeeded, have fun with png
  if File.exists?(dvi_path)

    # Convert to png
    system("dvipng -T tight -bg Transparent -D %s -o %s %s" % [resolution, png_path, dvi_path])
    # system("dvipng -T tight -bg Transparent -D %s -o %s %s" % (resolutions[int(size)], png_path, dvi_path))

    # Remove the dvi file
    system("rm %s" % [dvi_path])

    # Return the result of our beautiful work
    content_type "image/png"
    File.read(File.join(png_path))
  else
    # # Something nasty happened during the compilation
    # # 1) Log it
    # dvi_log_path = "%s/%s.log" % (TEMP_DVI, uid)
    # log("err", "The compilation failed, see %s in the dvi temporary directory" % dvi_log_path)
    # # 2) Excuse
    # return ErrorImage()
  end
end
