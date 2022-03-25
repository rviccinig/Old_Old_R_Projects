# Estimating 
library("hrbrthemes")


# Read the data
islands <- list()
islands[[1]] <- c(0.2, 0.2, 0.2, 0.2, 0.2)
islands[[2]] <- c(0.8, 0.1, 0.05, 0.025, 0.025)
islands[[3]] <- c(0.05, 0.15, 0.7, 0.05, 0.05)
names(islands) <- c("Island 1", "Island 2", "Island 3")

islands

information_entropy <- function(distribution) {
  # -expected value of log (p)
  return(-sum(distribution * log(distribution)))
}

islands %>% 
  map_df(information_entropy) %>%
  mutate(x = "o") %>% 
  pivot_longer(cols = -x, names_to = "island", values_to = "information_entropy") %>% 
  ggplot(aes(y = fct_reorder(island, information_entropy), x = information_entropy)) +
  geom_col(aes(fill = island),alpha = 0.8) +
  scale_fill_viridis_d() +
  labs(y = "", 
       subtitle = "Island 1 has the highest entropy",
       title = "Information Entropy by Island") +
  hrbrthemes::theme_ipsum_rc(grid = "x") +
  theme(legend.position = "none")


