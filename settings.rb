### Variables which are good to tweak ###

# Main Path
output_temp_dir = "/tmp/tex2png"

# Temporary dvi file
TEMP_PDF = "%s/pdf" % output_temp_dir

# Temporary dvi file
TEMP_DVI = "%s/dvi" % output_temp_dir

# Temporary png file
TEMP_PNG = "%s/png" % output_temp_dir

# Temporary tex file
TEMP_TEX = "%s/tex" % output_temp_dir

# Loggin access and errors
LOGFILE = "%s/log" % output_temp_dir

TEX_BLACKLIST = ["\\def", "\\let", "\\futurelet",
        "\\newcommand", "\\renewcommand", "\\else", "\\fi", "\\write",
        "\\input", "\\include", "\\chardef", "\\catcode", "\\makeatletter",
        "\\noexpand", "\\toksdef", "\\every", "\\errhelp", "\\errorstopmode",
        "\\scrollmode", "\\nonstopmode", "\\batchmode", "\\read", "\\csname",
        "\\newhelp", "\\relax", "\\afterground", "\\afterassignment",
        "\\expandafter", "\\noexpand", "\\special", "\\command", "\\loop",
        "\\repeat", "\\toks", "\\output", "\\line", "\\mathcode", "\\name",
        "\\item", "\\section", "\\mbox", "\\DeclareRobustCommand", "\\[", "\\]"];
