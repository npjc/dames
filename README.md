
dames stands for `d`ata n`ames`. Data names are file names with consistent formatting. Variables are consitently ordered and separated by a consistent separator. Variables are things like date (2015-08-28), abbreviation-or-accronym (AOA), slug-formatted-descriptor (slug-name-of-file-that-describes-its-contents), and file extension (ext).

For example:
```
AOA_01_slug-name-of-file-that-describes-its-contents.ext
```

You set your working directory to clean project directory:

```r
setwd("path/to/my/project")
```
![alt text](README-set-wd.png)

then you can build up your project with `nd`

```r
nd("first file")
nd("another file")
nd("third file with a different aoa",aoa = "DIFF")
```
![alt text](README-build-it-up.png)

Where the output of each op is an damed `.Rmd` file that contains a child link to the REF_template.Rmd (for common stuff) and a YAML header configured for keeping a github-flavoured markdown when knitting to html.

