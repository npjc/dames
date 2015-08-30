



### What dames ?

dames stands for **d**ata n**ames**. 

Data names are file names with consistent formatting: 

* Variables are consitently ordered
* Variables are predictably delimited by a consistent separator. 
* Variables are things like:
    * date (`1991-07-03`)
    * abbreviation-or-accronym (`AOA`)
    * slug-formatted-descriptor (`slug-name-of-file-that-describes-its-contents`)
    * file extension (`ext`).

For example:

```r
eg <- "AOA_01_slug-name-of-file-that-describes-its-contents.ext"
dames:::read_dames(eg)
#> Source: local data frame [1 x 4]
#> 
#>     aoa   inc                                          slug   ext
#>   (chr) (int)                                         (chr) (chr)
#> 1   AOA     1 slug-name-of-file-that-describes-its-contents   ext
```

### Why dames ?

I was doing this manually in my projects and decided to make it easier on myself.
Use damed .Rmd files damed according to a logical projection (numbered indices) 
annotated with useful abbreviations/acronyms and slug-form names to be kind to 
future me.

### How do I use it ?

From your project directory:

```r
setwd("path/to/my/project")
```
![alt text](README-set-wd.png)

you can build up your project with `nd`

```r
nd("first file")
nd("another file")
nd("third file with a different aoa",aoa = "DIFF")
```
![alt text](README-build-it-up.png)

Where the output of each op is an damed `.Rmd` file that contains a child link to the REF_template.Rmd (for common stuff) and a YAML header configured for keeping a github-flavoured markdown when knitting to html.

#### but why a folder for each ?

This has a few purposes:

* with github hosting if you rename the knitted `.md` to `README.md` it will automatically preview in each directory. To do this is to use `knitme()`
if working in a dame directory, or `knit_rmds_to_rdme()` to do all the .Rmds in
a project home directory.

```r
knitme() # one .rmd dame
knit_rmds_to_rdme() # all the .rmds
append_links() # for github browsing deliciousness.
```

There is also `append_links()` which will append all the links to these readmes
into `00_REF_template.Rmd` which, when knitted, will generate the master readme
for that project with all the links!

* keeps all the bits relevant to a section in the same handy folder so everything is easy to find later on (making the location of the contents usefully informative).

 


### notes
- using [`reprex:::construct_safeslug()`](https::github.com/jennybc/reprex) cause it is nice and convenient; namespace it.
- many good people have put out great education on naming/organization of stuffs. Make a list.
- every time you use an aoa for the first time it should be added to a lexicon.csv file that lives in the project directory.
