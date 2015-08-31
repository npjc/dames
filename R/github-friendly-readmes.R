#' knit all rmarkdown files into .md files in their own directories and name each
#' README.md so as to take advantage of the github previewing.
#' @keywords int
knit_rmds_to_rdme <- function() {
  rmds <- list.files(pattern = "\\.Rmd?", recursive = T, full.names = T)
  # split up along file paths
  split_up <- strsplit(rmds, "/",fixed = T)
  # for each rmd pull out the last element as it must be the actual file and
  # gsub to .md for output
  rmd_dames <- lapply(split_up, tail, 1)
  md_dames <- gsub("\\.Rmd?", ".md", rmd_dames)
  # everything but the last one must be it's parent directory
  rmd_dir_pieces <- lapply(split_up, head, -1)
  rmd_dir <- lapply(rmd_dir_pieces, paste0, collapse="/")
  knit_rdme <- function(input, dir, output = "README.md") {
    prev <- setwd(dir)
    knitr::knit(input, output)
    setwd(prev)
  }
  invisible(Map(knit_rdme, rmd_dames, rmd_dir))
}

#' knit just the .rmd in the current working directory to readme.md
#' @export
knitme <- function() {
  invisible(knitr::knit(list.files(pattern = "\\.Rmd?"), "README.md"))
}

#' read the readme paths:
#' @export
append_links <- function(common = "REF_00_template.Rmd") {
  rdmes <- list.files(pattern = "README\\.md?", recursive = T, full.names = T)
  rdmes <- setdiff(rdmes,"README.md")
  splits <- lapply(strsplit(rdmes, "/", fixed = T), head, -1)
  splits <- lapply(splits, paste0, collapse = "/")
  tmp <- paste0("[",splits,"](", rdmes,")")
  parent_lines <- readLines(common)
  parent_links <- grepl("\\]\\(", parent_lines) #get just the link line indices
  stable_lines <- parent_lines[!parent_links]
  links_to_unify <- parent_lines[parent_links]
  all <- c(stable_lines, tmp)
  writeLines(all, common)
}
