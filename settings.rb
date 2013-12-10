### Variables which are good to tweak ###
require 'fileutils'

# Main Path
output_temp_dir = "./tmp/tex2png"
Dir.mkdir(output_temp_dir) unless File.exists?(output_temp_dir)

# Temporary dvi file
TEMP_DVI = "%s/dvi" % output_temp_dir
Dir.mkdir(TEMP_DVI) unless File.exists?(TEMP_DVI)

# Temporary png file
TEMP_PNG = "%s/png" % output_temp_dir
Dir.mkdir(TEMP_PNG) unless File.exists?(TEMP_PNG)

# Temporary tex file
TEMP_TEX = "%s/tex" % output_temp_dir
Dir.mkdir(TEMP_TEX) unless File.exists?(TEMP_TEX)

# Loggin access and errors
LOGFILE = "%s/log" % output_temp_dir
Dir.mkdir(LOGFILE) unless File.exists?(LOGFILE)

TEX_BLACKLIST = ["\\def", "\\let", "\\futurelet",
        "\\newcommand", "\\renewcommand", "\\else", "\\fi", "\\write",
        "\\input", "\\include", "\\chardef", "\\catcode", "\\makeatletter",
        "\\noexpand", "\\toksdef", "\\every", "\\errhelp", "\\errorstopmode",
        "\\scrollmode", "\\nonstopmode", "\\batchmode", "\\read", "\\csname",
        "\\newhelp", "\\relax", "\\afterground", "\\afterassignment",
        "\\expandafter", "\\noexpand", "\\special", "\\command", "\\loop",
        "\\repeat", "\\toks", "\\output", "\\line", "\\mathcode", "\\name",
        "\\item", "\\section", "\\mbox", "\\DeclareRobustCommand", "\\[", "\\]"];
