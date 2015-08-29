#' Build .Rmd yaml header
#'
#' returns a character vector with all the necessary formatting to pass to
#' \code{cat()} or \code{writeLines()} and produce a yaml header for .Rmd
#'
#' @param keep_md Boolean for keeping markdown document when knitting
#' @param variant string of which markdown variant to knit.
#' @examples
#'  cat(bld_rmd_yaml(), sep = "\n")
#'  @keywords internal
bld_rmd_yaml <- function(keep_md = TRUE, variant = "markdown_github") {
  params <- c("output", "html_document", "keep_md", "variant")
  values <- c("", "", keep_md, variant)
  indents <- c(0, 1, 2, 2)
  lines <- Map(bld_yaml_line, params, values, indents)
  c("---", unlist(lines), "---")
}

#' Build a yaml parameter line
#'
#' Build a yaml header parameter line by pasting together indentation,
#' parameter name, separator, and value.
#'
#' @param param name of the parameter
#' @param value value of the parameter
#' @param indent_lvl how many levels of indentation, where each level is indent
#' @param indent was string to use for indentation. default is "  ".
#' @param sep what separates the param from the value. default is ":".
#' @examples
#'  bld_yaml_line("variant", "markdown_github", 2)
#' @keywords internal
bld_yaml_line <- function(param, value, indent_lvl, indent = "  ", sep = ":") {
  indent_spaces <- paste0(rep(indent, indent_lvl), collapse = "")
  paste0(indent_spaces, param, sep," ", value)
}

#' Build .Rmd r code chunk
#'
#' Build a code chunk into character vector of lines to pass to \code{cat()} or
#' \code{writeLines()}.
#'
#' @param name name to use for the chunk
#' @param opts options for code chunk
#' @param body content of the chunk
#' @examples
#'  my_opts <- c("child=\"my-child.Rmd", "fig.path=\"figure/\"")
#'  cat(bld_code_chunk("my-chunk", my_opts), sep = "\n")
#' @keywords internal
bld_code_chunk <- function(name = NULL, opts = NULL, body = NULL) {
  if(!is.null(opts)) name <- paste0(" ",name,", ")
  opts <- paste0(opts, collapse = ", ")
  start <- paste0("```{r", name, opts, "}")
  end <- "```"
  c(start, body, end)
}
