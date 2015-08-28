# main workhorse
nd <- function(slug = "my_next_file", aoa = "AOA", path = ".", ptrn = "[_]", template_path = "../REF_00_template.Rmd") {
  dame <- newdame(slug, aoa, path, ptrn)
  new_dir <- paste0(path, '/', dame)
  dir.create(new_dir)
  rmd_file <- reprex:::add_ext(dame,"Rmd")
  rmd_lines <- c("---", "output: ", "  html_document:", "    keep_md: TRUE",
                 "    variant: markdown_github", "---", "",
                 paste0("```{r common-setup, child=\"", template_path, "\"}"), "```", "")
  writeLines(rmd_lines, paste(new_dir, rmd_file, sep = "/"))
}
