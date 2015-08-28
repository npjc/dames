# take files names that are arranged in data_categories and turn them into a
# tidy data frame.
# defaults to 4 variables: abbreviation or acronym / increment / slug / extension
# dames stands for datafied names
read_dames <- function(dames, var_sep = "_", name_vars = c("aoa", "inc","slug","ext")) {
  pattern <- paste0("[", var_sep, "//.]")
  split_ls <- data.table::tstrsplit(dames, pattern, type.convert = T)
  named_ls <- setNames(split_ls, name_vars)
  dplyr::as_data_frame(named_ls)
}

# now need function to get next increment for folder or file
infer_next_inc <- function(dames_df, what = c("folders", "files"), inc_by = 1) {
  what <- match.arg(what)
  expr <- switch(what,
                 folders = ~is.na(ext),
                 files = ~!is.na(ext))
  inc_df <- dplyr::filter_(dames_df, expr)
  if(length(inc_df$inc) == 0) # to deal with case where this is the first one
    return(inc_by)
  # summarise_(.dots = list(max = ~max(incr)))
  max(inc_df$inc) + inc_by
}
# function to left pad inc if need be and convert to char
left_pad <- function(inc) {
  left_pad <- NULL
  if(nchar(inc) == 1) left_pad <- 0
  paste0(left_pad, inc, collapse="")
}

# assembles new dame based on provided args
newdame <- function(slug = "my-next-file", aoa = "AOA", path = ".", ptrn = "_") {
  files_and_dirs <- list.files(path, ptrn)
  if(length(files_and_dirs) == 0) {
    writeLines(c("---", "  output: ", "  html_document:", "  keep_md: TRUE",
                 "variant: markdown_github", "---", "", "```{r common-setup, echo=FALSE}",
                 "knitr::opts_chunk$set(", "  collapse = TRUE,", "  comment = \"#>\"",
                 ")", "pacman::p_load(readr,readrbio, dplyr, tidyr, stringi, ggplot2)",
                 "```", ""),"REF_00_template.Rmd")
    files_and_dirs <- list.files(path, ptrn)
  }
  dames_df <- read_dames(files_and_dirs)
  dames_df <- dplyr::filter_(dames_df, ~aoa == aoa)
  inc <- infer_next_inc(dames_df)
  inc <- left_pad(inc)
  slug <- reprex:::construct_safeslug(slug)
  paste(aoa, inc, slug, sep = "_")
}
