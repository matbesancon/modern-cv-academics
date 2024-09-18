# A modern CV for academics

This is a CV template built in [Typst](https://typst.app) on top of the great [Modern CV](https://github.com/DeveloperPaul123/modern-cv) template.

I adapted the base template to be more suited towards the expectations of academia and in particular generated anything that's a long enough list from TOML files.

## Installation

You will need [modern-cv](https://github.com/DeveloperPaul123/modern-cv) accessible, and the [hayagriva](https://github.com/typst/hayagriva) CLI installed for the multi-bib version.
After that, run `publications/convert_yaml.sh` to convert your bib publications to YAML, which will be imported by the CV.

## TOML files 

The data extracted from TOML files include in particular supervisions (at the Master's and doctoral levels, feel free to add anything suitable for your system), education curriculum, work experience, talks, teaching activities.
I typically find the other entries small enough to be written in plain text and adapted.
The ones moved out to TOML files are typically information required in various contexts in academia (grants, shorter and longer CV, etc), websites, activity reports, the format allows different documents to depend on a single data source with suitable filters. I use these data to generate some pages of my [website](https://matbesancon.xyz), reducing out-of-sync situations.

## Publications

This template offers two modes, 'highlighted' with a single publication list from a single bib file, and the per-section publication.

To use the single publication mode, just set `selectedpubsonly = true` at the appropriate spot in the text.

Per-section publications is the only part where I had to work around. 

First, typst currently supports bibtex and [hayagriva](https://github.com/typst/hayagriva), a specific yaml format with more features, some of these like manipulating the list of entries is what we needed to go around the lack of multi-bibliographies.
I was inspired by [avonmoll](https://gist.github.com/avonmoll/e62facc7040f781d9e9ca5d6def9dc82)'s tricks but replaced the automatic type detection with multiple bib files.

Because YAML is more unusual, I considered bib files as the original data, with a script `publications/convert_yaml.sh` which you can run from the publications folder once hayagriva is installed. This will generate the YAML files used by the CV.

The citation style can be changed, the default "american-physics-society" was chosen because it has numbers and the date shown (a surprisingly narrow intersection of requirements).
