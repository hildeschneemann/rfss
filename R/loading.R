print_info <- function() {

}

#' Load an hdf5 file produced by the Fisher Stepping Stone model.
#'
#' @description Load an hdf5 file produced by the Fisher Stepping Stone model,
#' either entirelly or only for a specified dataset.
#'
#' @param file Path to the file.
#' @param dataset optional specific dataset to open
#'
#' @return A list containing all datasets and parameters from the file.
#' Or a simple array when a specific dataset is chosen.
#'
#' @examples
#' file <- system.file("extdata", "result_sim.h5", package = "rfss")
#' result_sim <- load_h5(file)
#'
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
