library(argparser)
library(pcalg)
library(RBGL)
library(bnlearn)

source("resources/code_for_binary_simulations/make_var_names.R")

p <- arg_parser("A program for running H2PC algorithm and save to file.")
p <- add_argument(p, "--filename", help = "output filename")
p <- add_argument(p, "--output_dir", help = "output dir", default = ".")
p <- add_argument(p, "--filename_data", help = "Dataset filename")
p <- add_argument(p, "--seed", help = "Random seed", type = "numeric", default = 1)
p <- add_argument(p, "--alpha", help = "Alpha parameter", type = "numeric")

argv <- parse_args(p)
directory <- argv$output_dir
filename <- file.path(argv$filename)
filename_data <- argv$filename_data
seed <- argv$seed
alpha <- argv$alpha
data <- read.csv(filename_data, sep = ",", check.names = FALSE)
data <- data[-1,] # Remove range header
set.seed(seed)

datanew <- matrixToDataframe(data, names(data))
# TODO: BUG this is not working for some reason.
mmoutput <- h2pc(datanew, restrict.args = list(alpha = argv$alpha))
## convert to graphneldag
gnel_dag <- as.graphNEL(mmoutput)
adjmat <- as(gnel_dag, "matrix")
colnames(adjmat) <- names(data)

write.csv(adjmat, file = filename, row.names = FALSE, quote = FALSE)
