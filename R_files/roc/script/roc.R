library(readr)
require(ggplot2)

##### FUNCTIONS #####
plot_pred_type_distribution <- function(df, threshold) {
  v <- rep(NA, nrow(df))
  v <- ifelse(df$pred >= threshold & df$survived == 1, "TP", v)
  v <- ifelse(df$pred >= threshold & df$survived == 0, "FP", v)
  v <- ifelse(df$pred < threshold & df$survived == 1, "FN", v)
  v <- ifelse(df$pred < threshold & df$survived == 0, "TN", v)
  
  df$pred_type <- v
  
  ggplot(data=df, aes(x=survived, y=pred)) + 
    geom_violin(fill=rgb(1,1,1,alpha=0.6), color=NA) + 
    geom_jitter(aes(color=pred_type), alpha=0.6) +
    geom_hline(yintercept=threshold, color="red", alpha=0.6) +
    scale_color_discrete(name = "type") +
    labs(title=sprintf("Threshold at %.2f", threshold))
}

#### calc roc ####
calculate_roc <- function(df, cost_of_fp, cost_of_fn, n) {
  #sensitivity
  tpr <- function(df, threshold) {
    sum(df$pred <= threshold & df$survived == 1) / sum(df$survived == 1)
  }
  #true negative rate  = specificity
  tnr <- function(df, threshold) {
    sum(df$pred > threshold & df$survived == 0) / sum(df$survived == 0)
  }
  #false positive = fallout
  fpr <- function(df, threshold) {
    sum(df$pred <= threshold & df$survived == 0) / sum(df$survived == 0)
  }
  
  
  cost <- function(df, threshold, cost_of_fp, cost_of_fn) {
    sum(df$pred >= threshold & df$survived == 0) * cost_of_fp + 
      sum(df$pred < threshold & df$survived == 1) * cost_of_fn
  }
  
  roc <- data.frame(threshold = seq(0,1,length.out=n), tpr=NA, fpr=NA, tnr=NA, type=NA)
  roc$tpr <- sapply(roc$threshold, function(th) tpr(df, th))
  roc$fpr <- sapply(roc$threshold, function(th) fpr(df, th))
  roc$tnr <- sapply(roc$threshold, function(th) tnr(df, th))
  roc$cost <- sapply(roc$threshold, function(th) cost(df, th, cost_of_fp, cost_of_fn))
  
  return(roc)
}

#fpr/tpr
plot_roc_fallout_sensivity <- function(roc, threshold, cost_of_fp, cost_of_fn) {
  library(gridExtra)
  library(grid)
  
  norm_vec <- function(v) (v - min(v))/diff(range(v))
  
  idx_threshold = which.min(abs(roc$threshold-threshold))
  
  col_ramp <- colorRampPalette(c("black", "red", "orange", "green"))(100)
  col_by_cost <- col_ramp[ceiling(norm_vec(roc$cost)*99)+1]
  
  p_roc <- ggplot(roc, aes(x=fpr,y=tpr, group=type, color=type)) + 
    geom_path()+
   
    coord_fixed() +
   
    labs(title = sprintf("ROC")) + xlab("FPR") + ylab("recall/sensitivity(TPR)") 
 
 
  sub_title <- sprintf("asd")
  #grid.arrange(p_roc, p_cost, ncol=2, sub=textGrob(sub_title, gp=gpar(cex=1), just="bottom"))
  grid.arrange(p_roc, sub=textGrob(sub_title, gp=gpar(cex=1), just="bottom"))
  
}
plot_roc_specificity_sensivity <- function(roc, threshold, cost_of_fp, cost_of_fn) {
  library(gridExtra)
  library(grid)
  
  norm_vec <- function(v) (v - min(v))/diff(range(v))
  
  idx_threshold = which.min(abs(roc$threshold-threshold))
  
  col_ramp <- colorRampPalette(c("black", "red", "orange", "green"))(100)
  col_by_cost <- col_ramp[ceiling(norm_vec(roc$cost)*99)+1]
  
  p_roc <- ggplot(roc, aes(x=tnr,y=tpr, group=type, group=type)) + 
    geom_path(aes(color=roc$threshold))+ scale_colour_gradient2(low = "blue", mid = "yellow" , high = "red", 
                                                                midpoint=0.5) +
    #geom_line(color=rgb(0,0,1,alpha=0.3)) +
    #geom_point(color=col_by_cost, size=1, alpha=0.3) +
    coord_fixed() +
    #geom_line(aes(threshold,threshold), color=rgb(0,0,1,alpha=0.5)) +
    labs(title = sprintf("ROC")) + xlab("specificity (TNR)") + ylab("recall/sensitivity(TPR)") 
    #geom_hline(yintercept=roc[idx_threshold,"tpr"], alpha=0.5, linetype="dashed") +
    #geom_vline(xintercept=roc[idx_threshold,"fpr"], alpha=0.5, linetype="dashed")
  
  #p_cost <- ggplot(roc, aes(threshold, cost)) +
   # geom_line(color=rgb(0,0,1,alpha=0.3)) +
    #geom_point(color=col_by_cost, size=1, alpha=0.5) +
    #labs(title = sprintf("cost function")) +
    #geom_vline(xintercept=threshold, alpha=0.5, linetype="dashed")
  
  #sub_title <- sprintf("threshold at %.2f - cost of FP = %d, cost of FN = %d", threshold, cost_of_fp, cost_of_fn)
  sub_title <- sprintf("asd")
  #grid.arrange(p_roc, p_cost, ncol=2, sub=textGrob(sub_title, gp=gpar(cex=1), just="bottom"))
  grid.arrange(p_roc, sub=textGrob(sub_title, gp=gpar(cex=1), just="bottom"))

}

##### DATA IMPORT #######
roc_df_norm <- read_csv("~/Documents/master_thesis/R_files/roc/data/df.line_norm_56.txt")
roc_df_conversione <- read_csv("~/Documents/master_thesis/R_files/roc/data/df.conversione_56.txt")
roc_df_metri_lineare <- read_csv("~/Documents/master_thesis/R_files/roc/data/df.metri_lineare_56.txt")
roc_df_metri_log <- read_csv("~/Documents/master_thesis/R_files/roc/data/df.metri_log_56.txt")
roc_df_metri_lin_new <- read_csv("~/Documents/master_thesis/R_files/roc/data/df.metri_lin_new.txt")

#roc_df_norm <- read_csv("~/Documents/master_thesis/R_files/roc/data/df.norm_norm.txt")
#roc_df_conversione <- read_csv("~/Documents/master_thesis/R_files/roc/data/df.conversione_norm.txt")
#roc_df_metri_lineare <- read_csv("~/Documents/master_thesis/R_files/roc/data/df.metri_lineare_norm.txt")
#roc_df_metri_log <- read_csv("~/Documents/master_thesis/R_files/roc/data/df.metri_log_norm.txt")

roc_lab_norm <- read_csv("~/Documents/master_thesis/R_files/roc/data/df.lab_norm.txt")
roc_lab_conv <- read_csv("~/Documents/master_thesis/R_files/roc/data/df.lab_conv.txt")
roc_lab_linear <- read_csv("~/Documents/master_thesis/R_files/roc/data/df.lab_linear.txt")
roc_lab_log <- read_csv("~/Documents/master_thesis/R_files/roc/data/df.lab_log.txt")


#### LINEARIZZO
roc_df_conversione <- transform(roc_df_conversione, pred = (pred - min(pred)) / (max(pred) - min(pred)))
roc_df_metri_lineare <- transform(roc_df_metri_lineare, pred = (pred - min(pred)) / (max(pred) - min(pred)))
roc_df_metri_log <- transform(roc_df_metri_log, pred = (pred - min(pred)) / (max(pred) - min(pred)))
roc_df_metri_lin_new <- transform(roc_df_metri_lin_new, pred = (pred - min(pred)) / (max(pred) - min(pred)))

roc_lab_norm <- transform(roc_lab_norm, pred = (pred - min(pred)) / (max(pred) - min(pred)))
roc_lab_conv <- transform(roc_lab_conv, pred = (pred - min(pred)) / (max(pred) - min(pred)))
roc_lab_linear <- transform(roc_lab_linear, pred = (pred - min(pred)) / (max(pred) - min(pred)))
roc_lab_log <- transform(roc_lab_log, pred = (pred - min(pred)) / (max(pred) - min(pred)))

#### BIND
roc_bind <- rbind(roc_df_conversione, roc_df_norm, roc_df_metri_lineare, roc_df_metri_log)
View(roc_bind)
roc_bind_lab <- rbind(roc_lab_conv, roc_lab_linear, roc_lab_norm, roc_lab_log)

plot_pred_type_distribution(roc_bind_lab, 0.47)

roc_norm <- calculate_roc(roc_df_norm, 1, 2, n = 1000)
roc_norm$type="norm"
roc_conv <- calculate_roc(roc_df_conversione, 1, 2, n = 1000)
roc_conv$type = "conv"
roc_lin <- calculate_roc(roc_df_metri_lineare, 1, 2, n = 1000)
roc_lin$type = "metri_retta"
roc_log <- calculate_roc(roc_df_metri_log, 1, 2, n = 1000)
roc_log$type = "metri_log"
roc <- rbind(roc_norm, roc_conv, roc_lin, roc_log)

roc
#roc_conv_lab <- calculate_roc(roc_bind_lab,1,2, n=100)

plot_roc_specificity_sensivity(roc, 0.55, 1, 2)
plot_roc_fallout_sensivity(roc,0.55,1,2)

library(pROC)
auc(roc_df_norm$survived, roc_df_norm$pred)
