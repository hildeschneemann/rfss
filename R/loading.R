print_info <- function() {

}

load_h5 <- function(file, dataset = NULL) {
  if (is.null(dataset)) {
    # load everything
    res <- h5read(file, name = "/")
    res$parameters <- h5readAttributes(file, "alleleFreq")
    # print information on simulation here
    return(res)
  } else {
    # load the specified dataset
    if (dataset %in% h5ls(file)$name) {
      res <- h5read(file, name = dataset)
    } else {
      warning("The dataset name you have specified does not exist.\n",
              "Try one of the following:\n",
              paste(h5ls(file)$name, collapse = "\n"))
    }
    return(res)
  }
}
