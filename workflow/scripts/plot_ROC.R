library(ggplot2)
library("rjson")


toplot <- read.csv(snakemake@input[["csv"]])

config <- fromJSON(file = snakemake@input[["config"]])

param_annot <- config$benchmark_setup$evaluation$roc$text
path <- config$benchmark_setup$evaluation$roc$path
point <- config$benchmark_setup$evaluation$roc$point
errorbar <- config$benchmark_setup$evaluation$roc$errorbar


# Might have to go through all one by aone to get the ponit text.
# directlabels::geom_dl(aes(label = class), method = "smart.grid") +
ggplot() + {
  if (errorbar) {
    geom_errorbar(data = toplot,
                aes(x = FPRn_pattern_median,
                    ymin = TPR_pattern_q1,
                    ymax = TPR_pattern_q3,
                    col = id),
                    width = 0.01)
  }
} + {
  if (path) {
    geom_path(data = toplot,
          aes(x = FPRn_pattern_median,
              y = TPR_pattern_median,
              col = id))
  }
} + {
  if (point) {
    geom_point(data = toplot,
    aes(x = FPRn_pattern_median,
        y = TPR_pattern_median,
        col = id,
        shape = id),
        size = 1)
  }
} + {
  if (param_annot) {
    geom_text(data = toplot,
            aes(x = FPRn_pattern_median,
                y = TPR_pattern_median,
                label = curve_vals, col = id, shape = id),
          check_overlap = FALSE
          )
  }
} +
facet_wrap(. ~ adjmat + bn + data, nrow = 2) +
xlab("FPRp") +
ylab("TPR") +
ggtitle("Median FPRp/TPR (pattern graph)") +
theme_bw() +
theme(plot.title = element_text(hjust = 0.5)) +
ggsave(file = snakemake@output[["fpr_tpr_pattern"]])

ggplot() + {
  if (errorbar) {
    geom_errorbar(data = toplot,
              aes(x = FPRn_skel_median,
                  ymin = TPR_skel_q1,
                  ymax = TPR_skel_q3,
                  col = id),
              width = 0.01)
  }
} + {
  if (path) {
    geom_path(data = toplot,
          aes(x = FPRn_skel_median,
              y = TPR_skel_median,
              col = id))
  }
} + {
  if (point) {
    geom_point(data = toplot,
           aes(x = FPRn_skel_median,
               y = TPR_skel_median,
               col = id,
               shape = id),
               size = 1)
  }
} + {
  if (param_annot) {
    geom_text(data = toplot,
            aes(x = FPRn_skel_median,
                y = TPR_skel_q3,
                label = curve_vals, col = id, shape = id),
          check_overlap = FALSE
          )
  }
 } +
facet_wrap(. ~ adjmat + bn + data, nrow = 2) +
xlab("FPRp") +
ylab("TPR") +
ggtitle("Median FPRp/TPR (undirected skeleton)") +
theme_bw() +
theme(plot.title = element_text(hjust = 0.5)) +
ggsave(file = snakemake@output[["roc_FPRp_TPR_skel"]])


ggplot() + {
  if (errorbar) {
    geom_errorbar(data = toplot,
              aes(x = FPRp_skel_mean,
                  ymin = FNR_skel_q1,
                  ymax = FNR_skel_q3,
                  col = id),
              width = 0.01)
  }
} + {
  if (path) {
    geom_path(data = toplot,
          aes(x = FPRp_skel_mean,
              y = FNR_skel_mean,
              col = id))
  }
} + {
  if (point) {
    geom_point(data = toplot,
           aes(x = FPRp_skel_mean,
               y = FNR_skel_mean,
               col = id,
               shape = id),
               size = 1)
  }
} + {
  if (param_annot) {
    geom_text(data = toplot,
            aes(y = FNR_skel_q3,
                x = FPRp_skel_mean,
                label = curve_vals, col = id, shape = id),
          check_overlap = FALSE
          )
  }
} +
facet_wrap(. ~ adjmat + bn + data, nrow = 2) +
xlab("FPRp") +
ylab("FNR") +
ggtitle("Mean FPRp/FNR (undirected skeleton)") +
theme_bw() +
theme(plot.title = element_text(hjust = 0.5)) +
ggsave(file = snakemake@output[["FPRp_FNR_skel"]])

ggplot() + {
  if (errorbar) {
    geom_errorbar(data = toplot,
              aes(x = FNR_skel_mean,
                  ymin = FPR_skel_q1,
                  ymax = FPR_skel_q3,
                  col = id),
              width = 0.01)
  }
} + {
  if (path) {
    geom_path(data = toplot,
           aes(y = FPRp_skel_mean,
               x = FNR_skel_mean,
               col = id))
  }
} + {
  if (point) {
    geom_point(data = toplot,
           aes(y = FPRp_skel_mean,
               x = FNR_skel_mean,
               col = id,
               shape = id),
               size = 1)
  }
} + {
  if (param_annot) {
    geom_text(data = toplot,
        aes(x = FNR_skel_mean,
        y = FPRp_skel_mean,
        label = curve_vals, col = id, shape = id),
        check_overlap = FALSE
        )
  }
} +
facet_wrap(. ~ adjmat + bn + data, nrow = 2) +
ylab("FPR") +
xlab("FNR") +
ggtitle("Mean FNR/FPRp (undirected skeleton)") +
theme_bw() +
theme(plot.title = element_text(hjust = 0.5)) +
ggsave(file = snakemake@output[["fnr_fprp_skel"]])

# ggplot() +
# geom_col(data = toplot,
#     aes(x=id + curve_vals,y=SHD_pattern_mean)) + 
# ggtitle("Mean SHD (pattern graph)") +
# facet_wrap(. ~ adjmat + bn + data, nrow = 2) +
# ylab("Alg") +
# xlab("SHD") +
# theme_bw() +
# theme(plot.title = element_text(hjust = 0.5)) +
# ggsave(file = snakemake@output[["shd_pattern"]])

# ggplot() + geom_errorbar(data = toplot,
#               aes(x = log(FNR_skel_mean),
#                   ymin = log(FPR_skel_q1), 
#                   ymax = log(FPR_skel_q3), 
#                   col = id), 
#               width = 0.01) +
# geom_path(data = toplot,
#           aes(y = log(FPRp_skel_mean), 
#               x = log(FNR_skel_mean),
#               col = id)) +
# geom_point(data = toplot,
#            aes(y = log(FPRp_skel_mean), 
#                x = log(FNR_skel_mean),               
#                col = id, 
#                shape = id), 
#                size = 1) +
# {
#     if(param_annot) {
#         geom_text(data = toplot,
#         aes(x = log(FNR_skel_mean), 
#         y = log(FPR_skel_q3),               
#         label=curve_vals, col=id, shape=id),
#         check_overlap = TRUE
# #        ,nudge_x=-0.02,
# #        nudge_y=0.01
#         )} 
# }+
# facet_wrap(. ~ adjmat+bn+data+N, nrow = 2) +
# ylab("log FPR") +
# xlab("log FNR") +
# ggtitle("Mean log FNR/FPRp (undirected skeleton)") +
# theme_bw() +
# theme(plot.title = element_text(hjust = 0.5)) +
# ggsave(file=snakemake@output[["log_fnr_fprp_skel"]])

# Add support in config for path, errorbar, text, point
