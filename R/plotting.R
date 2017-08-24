plot_timestep <- function(data, gen = 1, message = T) {
  # find index of generation or closest
  if (gen %in% data$savedGen) {
    igen <- which(data$savedGen == gen)
  } else {
    igen <- which.min(abs(data$savedGen - gen))
    gen <- data$savedGen[igen]
    if (message)
      cat("Plotting the closest generation available: ", gen)
  }
  allele_freq <- melt(data$alleleFreq[,,igen],
                        varnames = c("deme","locus"), value.name = "freq")
  allele_freq$locus <- as.factor(allele_freq$locus)

  cols <- diverge_hcl(dim(data$alleleFreq)[2])

  ggplot(allele_freq, aes(x = deme, y = freq, colour = locus)) +
    geom_line() +
    scale_colour_manual(values = cols) +
    ylim(c(0,1)) +
    labs(title = paste("generation", gen)) +
    theme_classic() +
    theme(legend.position = "none")
}
