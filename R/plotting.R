plot_timestep <- function(data, timestep = 1) {
  allele_freq <- data$alleleFreq[,,timestep]
  allele_freq.l <- melt(allele_freq, id.vars = "deme")
  ggplot(allele_freq.l, aes(x = deme, y = value, colour = variable)) +
    geom_line() +
    scale_colour_manual(values = cols) +
    ylim(c(0,1)) +
    theme_classic() +
    theme(legend.position = "none")
}
