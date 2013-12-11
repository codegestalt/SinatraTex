# SinatraTex

A Sinatra Web App which lets you convert LaTeX to different formats (pdf/png)

# Installation

1. Download MacTEX from `https://www.tug.org/mactex/` and install it.
2. Clone this repository `git clone https://github.com/codegestalt/sinatratex.git`
3. Change directory `cd sinatratex`
4. Run bundler `bundle install`
5. Start the Rack server `bundle exec rackup`

## STIX Fonts

Converting math tex to png needs the STIX font for some characters e.g.: `\mathbb{N}`.
You need to install STIX Fonts so those get correctly converted.

* Download: http://www.stixfonts.org/
* Follow Instructions: http://tug.org/fonts/fontinstall.html

# Usage

## Math to PNG

`http://localhost:9292/png?tex=y=f(x)`

Parameters:

* `tex`: Math formula e.g.: `y=f(x)`

## TeX to PDF

HTTP POST to `http://localhost:9292`

Parameters:

* `name`: Document name, only needed for caching (document name needs to be adjusted on application side).
* `tex`: The TeX string which contents the whole document.
