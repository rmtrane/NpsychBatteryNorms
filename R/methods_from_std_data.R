#' Helper to extract methods from standardized columns
#'
#' @param std_data `data.frame`/`tibble` with some standardized columns
#' @param std_cols optional; specify columns to get methods for. If omitted, will
#'   return method attribute from all columns that have said attribute
#'
#' @export
methods_from_std_data <- function(std_data, std_cols) {

  ## If no columns are specified, we find columns named 'std_'
  if (missingArg(std_cols)) {
    method_attrs <- lapply(std_data, attr, "method")
    std_cols <- names(method_attrs[!unlist(lapply(method_attrs, is.null))])
  }

  ## Get attributes for standardized columns
  methods <- lapply(std_data[, std_cols], \(x) c(method = attr(x, "method"), version = attr(x, "version")))

  ## Remove prefix from names
  names(methods) <- gsub(x = names(methods), pattern = "^std_", replacement = "")

  return(methods)
}
