### Variables which are good to tweak ###
require 'fileutils'

# Main Path
output_temp_dir = "./tmp/sinatratex"
FileUtils.mkdir_p(output_temp_dir) unless File.exists?(output_temp_dir)

# Temporary pdf file
TEMP_PDF = "%s/pdf" % output_temp_dir
FileUtils.mkdir_p(TEMP_PDF) unless File.exists?(TEMP_PDF)

# Temporary dvi file
TEMP_DVI = "%s/dvi" % output_temp_dir
FileUtils.mkdir_p(TEMP_DVI) unless File.exists?(TEMP_DVI)

# Temporary png file
TEMP_PNG = "%s/png" % output_temp_dir
FileUtils.mkdir_p(TEMP_PNG) unless File.exists?(TEMP_PNG)

# Temporary tex file
TEMP_TEX = "%s/tex" % output_temp_dir
FileUtils.mkdir_p(TEMP_TEX) unless File.exists?(TEMP_TEX)

# Loggin access and errors
LOGFILE = "%s/log" % output_temp_dir
FileUtils.mkdir_p(LOGFILE) unless File.exists?(LOGFILE)

TEX_BLACKLIST = ["\\def", "\\let", "\\futurelet",
        "\\newcommand", "\\renewcommand", "\\else", "\\fi", "\\write",
        "\\input", "\\include", "\\chardef", "\\catcode", "\\makeatletter",
        "\\noexpand", "\\toksdef", "\\every", "\\errhelp", "\\errorstopmode",
        "\\scrollmode", "\\nonstopmode", "\\batchmode", "\\read", "\\csname",
        "\\newhelp", "\\relax", "\\afterground", "\\afterassignment",
        "\\expandafter", "\\noexpand", "\\special", "\\command", "\\loop",
        "\\repeat", "\\toks", "\\output", "\\line", "\\mathcode", "\\name",
        "\\item", "\\section", "\\mbox", "\\DeclareRobustCommand", "\\[", "\\]"];
