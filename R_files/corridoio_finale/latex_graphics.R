#grafici per latex

#algorithm percentage
library(readr)
require(ggplot2)
library(ggthemes)
library(extrafont)
library(plyr)
library(scales)

algorithm_percentage <- read_csv("~/Documents/master_thesis/R_files/corridoio_finale/algorithm_percentage_2.csv")

algorithm_percentage$top <- factor(algorithm_percentage$top, levels = c("5",  "3", "1"))
algorithm_percentage$algorithm <- factor(algorithm_percentage$algorithm, levels = c("trilateration","conversion dist logarithmic","conversion dist linear", "conversion Wi-Fi -> Bluetooth", "normalization"))

ggplot(aes(y = percentage, x = algorithm, fill = factor(top)), data = algorithm_percentage) + geom_bar(stat="identity", color = "white") +
  labs(fill = "Top") + coord_flip() + scale_fill_brewer(palette = 10) + scale_y_continuous(labels = dollar_format(suffix = "%", prefix = ""))
