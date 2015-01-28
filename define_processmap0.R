# Define phase

library("SixSigma")
library("stringr")

fc <- file("define_processmap0_inoutsteps.txt")
raw0 <- strsplit(readLines(fc), ",")

inputs <- sapply(raw0[[1]], str_trim)
outputs <- sapply(raw0[[2]], str_trim)
steps <- sapply(raw0[[3]], str_trim)

# get io
ioraw <- read.csv("define_processmap0_steps.csv")
io <- list()
for (n in unique(ioraw$io)) {
  i <- 1
  io[[n]] <- list()
  for (m in lapply(strsplit(as.character(ioraw[ioraw$io==n, "steps"]), ";"), str_trim)[[1]]) {
    io[[n]][[i]] <- m
     i <- i + 1
  }
  remove(i)
}

# get params
paramraw <- read.csv("define_processmap0_param.csv")
param <- list()
for (n in unique(paramraw$io)) {
  param[[n]] <- paramraw[paramraw$io==n, c("xs", "classification")]
}


# get features
featraw <- read.csv("define_processmap0_feat.csv")
feat <- list()
for (n in unique(featraw$io)) {
  feat[[n]] <- featraw[featraw$io==n, c("ys", "classification")]
}


ss.pMap(steps, inputs, outputs, io, param, feat, sub="PSX Process")


