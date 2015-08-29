#' create a new dame (nd)
#'
#' describe the contents of a file in plain text, optionally adding an
#' acronym or abbreviation and \code{nd} will make a nice dame in its own
#' directory with left-padded numbering being infered based on what's already
#' there.
#'
#' @param slug string to be describe slug-part of the file dame
#' @param aoa acronym or abbreviation to add to the file dame
#' @param path path to work from, defaults to current directory
#' @param ptrn this is the pattern to use for infering which files/folders are
#'    part of the numbering and which are not.
#' @param common string path of a common template/reference/source file that
#'    each dame imports as a child at the start of the document.
#' @examples
#'    \dontrun{
#'    b4 <- list.files(, recursive = T)
#'    nd("the first part of my project is to explore", "EDA")
#'    nd("the second part is to fit models", "MDL")
#'    nd("fit more models", "MDL")
#'    aft <- list.files(, recursive = T)
#'    setdiff(aft, b4)
#'    }
#' @export
nd <- function(slug = "simple-slug", aoa = "AOA", path = ".", ptrn = "[_]", common = "../REF_00_template.Rmd") {
  # make dame and create its directory
  dame <- newdame(slug, aoa, path, ptrn)
  dame_dir <- file.path(path, dame)
  dir.create(dame_dir)
  # make dame.Rmd parts
  rmd_file <- paste0(dame,".Rmd") # add extension
  yaml_header <- bld_rmd_yaml()
  dame_opts <- c(paste0("child=\"",common, "\""), "include=FALSE")
  dame_chunk <- bld_code_chunk("common-setup", dame_opts)
  # write it to its directory
  dame_lines <- c(yaml_header, "", dame_chunk)
  writeLines(dame_lines, file.path(dame_dir, rmd_file))
}



