# Språkbanke Text A0 PhD poster template
A LateX template for academic posters for Språkbanken Text.
The template is created to look like the official PowerPoint template from the University of Gothenburg.

By Staffan Melin.
Based on Arianna Masciolinis [poster](https://github.com/harisont/GUnofficial-poster-template).
Which in turn gives credits to the [SINTEF poster template](https://www.overleaf.com/latex/templates/sintef-poster/hksprrptfntf), published under CC-BY-4.0 by Federico Zenith, federico.zenith@gu.no.

## License
CC-BY-4.0.

## Usage
Use `xelatex sbposter.tex` to create the PDF. `xelatex` is necessary for handling OTF fonts.

This is made for an english poster. A swedish logo is provided in /images.

If you prefer a gray background, and the blocks on white, edit sbposter.cls and change \usebackgroundstyle{sb} to \usebackgroundstyle{sbgray}.
  
For printed posters, replace `rgb` with `cmyk` in `sbposter.cls`, line `\PassOptionsToPackage{rgb}{xcolor}`.

## Fonts
The Jost* otf font files must be placed in the same directory as the LaTeX source.

## Powerpoint
The University of Gothenburg has a [PowerPoint template](https://gunet.sharepoint.com/sites/mp-stod-och-service/SitePages/Mallar(1).aspx) for an academic poster.
