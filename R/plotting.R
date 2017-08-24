#' @import ggplot2
#' @export
plot_timestep <- function(data, gen = 1, message = T) {
  # find index of generation or closest one
  if (gen %in% data$savedGen) {
    igen <- which(data$savedGen == gen)
  } else {
    igen <- which.min(abs(data$savedGen - gen))
    gen <- data$savedGen[igen]
    if (message)
      cat("Plotting the closest generation available: ", gen)
  }

  allele_freq <- reshape2::melt(data$alleleFreq[,,igen],
                      varnames = c("deme","locus"), value.name = "freq")
  allele_freq$locus <- as.factor(allele_freq$locus)

  cols <- colorspace::diverge_hcl(dim(data$alleleFreq)[2])

  f <- ggplot(allele_freq, aes(x = deme, y = freq, colour = locus)) +
    geom_line() +
    scale_colour_manual(values = cols) +
    ylim(c(0,1)) +
    labs(x = "demes", y = "allele frequency") +
    theme_classic() +
    theme(legend.position = "none")


  w <- qplot(seq(1, dim(data$w)[1]), data$w[,igen], geom = "line") +
    ylim(c(0, 1)) +
    labs(x = "demes", y = "mean w") +
    theme_classic()

  gridExtra::grid.arrange(w, f, nrow = 4, ncol = 1,
                          layout_matrix = matrix(c(1,2,2,2)),
                          top = paste("generation", gen))
}
