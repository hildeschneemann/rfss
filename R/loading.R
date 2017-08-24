print_info <- function() {

}

#' @export
load_h5 <- function(file, dataset = NULL) {
  if (is.null(dataset)) {
    # load everything
    res <- rhdf5::h5read(file, name = "/")
    res$parameters <- rhdf5::h5readAttributes(file, "alleleFreq")
    # print information on simulation here
    return(res)
  } else {
    # load the specified dataset
    if (dataset %in% h5ls(file)$name) {
      res <- rhdf5::h5read(file, name = dataset)
    } else {
      warning("The dataset name you have specified does not exist.\n",
              "Try one of the following:\n",
              paste(rhdf5::h5ls(file)$name, collapse = "\n"))
    }
    return(res)
  }
}
