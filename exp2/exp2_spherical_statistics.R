# EXPERIMENT 2 - SPHERICAL STATISTICS
# Part (1) - axis analysis within groups
# Part (2) - axis analysis between groups

# Part (1)

## Early BL1 vs. Early TRN
# Extrinsic
for (tr in 1:10){
  ina <- rep(1:2, each = 10)
  x <- as.matrix(read.table(paste("C:/exp2/text_files_exp2/trial60_121G1_",as.character(tr),".txt",sep=""), quote="\"", comment.char=""))
  print(het.aov(x,ina))

  spherconc.test(x, ina)
  multivmf.mle(x, ina, tol = 1e-07, ell = FALSE)
}
# Intrinsic 
for (tr in 1:10){
  ina <- rep(1:2, each = 10)
  x <- as.matrix(read.table(paste("C:/exp2/text_files_exp2/trial60_121G2_",as.character(tr),".txt",sep=""), quote="\"", comment.char=""))
  print(het.aov(x,ina))
  spherconc.test(x, ina)
  multivmf.mle(x, ina, tol = 1e-07, ell = FALSE)
}

# Control
for (tr in 1:10){
  ina <- rep(1:2, each = 10)
  x <- as.matrix(read.table(paste("C:/exp2/text_files_exp2/trial60_121G3_",as.character(tr),".txt",sep=""), quote="\"", comment.char=""))
  print(het.aov(x,ina))
  spherconc.test(x, ina)
  multivmf.mle(x, ina, tol = 1e-07, ell = FALSE)
}

## Early TRN
# Extrinsic
for (tr in 1:10){
  x <- as.matrix(read.table(paste("C:/exp2/text_files_exp2/trial121G1_",as.character(tr),".txt",sep=""), quote="\"", comment.char=""))
  mu<-c(0,-1/sqrt(2),1/sqrt(2))
  print(meandir.test(x, mu,999))
  
}
# Intrinsic
for (tr in 1:10){
  x <- as.matrix(read.table(paste("C:/exp2/text_files_exp2/trial121G2_",as.character(tr),".txt",sep=""), quote="\"", comment.char=""))
  mu<-c(0,1/sqrt(2),1/sqrt(2))
  print(meandir.test(x, mu,999))
}
# Control
for (tr in 1:10){
  x <- as.matrix(read.table(paste("C:/exp2/text_files_exp2/trial121G3_",as.character(tr),".txt",sep=""), quote="\"", comment.char=""))
  mu<-c(0,1/sqrt(2),1/sqrt(2))
  print(meandir.test(x, mu,999))
}

## Early TRN vs. Late TRN
# Extrinsic
for (tr in 1:10){
  ina <- rep(1:2, each = 10)
  x <- as.matrix(read.table(paste("C:/exp2/text_files_exp2/trial121_300G1_",as.character(tr),".txt",sep=""), quote="\"", comment.char=""))
  print(het.aov(x,ina))
  spherconc.test(x, ina)
  multivmf.mle(x, ina, tol = 1e-07, ell = FALSE)
}
# Intrinsic 
for (tr in 1:10){
  ina <- rep(1:2, each = 10)
  x <- as.matrix(read.table(paste("C:/exp2/text_files_exp2/trial121_300G2_",as.character(tr),".txt",sep=""), quote="\"", comment.char=""))
  print(het.aov(x,ina))
  spherconc.test(x, ina)
  multivmf.mle(x, ina, tol = 1e-07, ell = FALSE)
}
# Control
for (tr in 1:10){
  ina <- rep(1:2, each = 10)
  x <- as.matrix(read.table(paste("C:/exp2/text_files_exp2/trial121_300G3_",as.character(tr),".txt",sep=""), quote="\"", comment.char=""))
  print(het.aov(x,ina))
  spherconc.test(x, ina)
  multivmf.mle(x, ina, tol = 1e-07, ell = FALSE)
}

## trial 300 - last exposure
# Extrinsic
for (tr in 1:10){
  x <- as.matrix(read.table(paste("C:/exp2/text_files_exp2/trial300G1_",as.character(tr),".txt",sep=""), quote="\"", comment.char=""))
  mu<-c(0,(sqrt(3)-1)/(2*sqrt(2)),(sqrt(3)+1)/(2*sqrt(2)))
  print(meandir.test(x, mu,999))
}
# Intrinsic
for (tr in 1:10){
  x <- as.matrix(read.table(paste("C:/exp2/text_files_exp2/trial300G2_",as.character(tr),".txt",sep=""), quote="\"", comment.char=""))
  mu<-c(0,(sqrt(3)+1)/(2*sqrt(2)),(1-sqrt(3))/(2*sqrt(2)))
  print(meandir.test(x, mu,999))
}
# Control
for (tr in 1:10){
  x <- as.matrix(read.table(paste("C:/exp2/text_files_exp2/trial300G3_",as.character(tr),".txt",sep=""), quote="\"", comment.char=""))
  mu<-c(0,(sqrt(3)+1)/(2*sqrt(2)),(1-sqrt(3))/(2*sqrt(2)))
  print(meandir.test(x, mu,999))
}

## Late BL1 vs. Late TRN
# Extrinsic
for (tr in 1:10){
  ina <- rep(1:2, each = 10)
  x <- as.matrix(read.table(paste("C:/exp2/text_files_exp2/trial60_300G1_",as.character(tr),".txt",sep=""), quote="\"", comment.char=""))
  print(het.aov(x,ina))
  spherconc.test(x, ina)
  multivmf.mle(x, ina, tol = 1e-07, ell = FALSE)
}
# Intrinsic 
for (tr in 1:10){
  ina <- rep(1:2, each = 10)
  x <- as.matrix(read.table(paste("C:/exp2/text_files_exp2/trial60_300G2_",as.character(tr),".txt",sep=""), quote="\"", comment.char=""))
  print(het.aov(x,ina))
  spherconc.test(x, ina)
  multivmf.mle(x, ina, tol = 1e-07, ell = FALSE)
}
# Control
for (tr in 1:10){
  ina <- rep(1:2, each = 10)
  x <- as.matrix(read.table(paste("C:/exp2/text_files_exp2/trial60_300G3_",as.character(tr),".txt",sep=""), quote="\"", comment.char=""))
  print(het.aov(x,ina))
  spherconc.test(x, ina)
  multivmf.mle(x, ina, tol = 1e-07, ell = FALSE)
}

## Late BL2 vs. Early TFR
# Extrinsic
for (tr in 1:10){
  ina <- rep(1:2, each = 10)
  x <- as.matrix(read.table(paste("C:/exp2/text_files_exp2/trial120_301G1_",as.character(tr),".txt",sep=""), quote="\"", comment.char=""))
  print(het.aov(x[c(1:14,16:20),c(1:3)],ina[c(1:14,16:20)]))
  spherconc.test(x[c(1:14,16:20),c(1:3)], ina[c(1:14,16:20)])
  multivmf.mle(x[c(1:14,16:20),c(1:3)], ina[c(1:14,16:20)], tol = 1e-07, ell = FALSE)
}
# Intrinsic 
for (tr in 1:10){
  ina <- rep(1:2, each = 10)
  x <- as.matrix(read.table(paste("C:/exp2/text_files_exp2/trial120_301G2_",as.character(tr),".txt",sep=""), quote="\"", comment.char=""))
  print(het.aov(x[c(1:11,13:20),c(1:3)],ina[c(1:11,13:20)]))
  spherconc.test(x[c(1:11,13:20),c(1:3)],ina[c(1:11,13:20)])
  multivmf.mle(x[c(1:11,13:20),c(1:3)],ina[c(1:11,13:20)], tol = 1e-07, ell = FALSE)
}
# Control
for (tr in 1:10){
  ina <- rep(1:2, each = 10)
  x <- as.matrix(read.table(paste("C:/exp2/text_files_exp2/trial120_301G3_",as.character(tr),".txt",sep=""), quote="\"", comment.char=""))
  print(het.aov(x,ina))
  spherconc.test(x, ina)
  multivmf.mle(x, ina, tol = 1e-07, ell = FALSE)
}

## Early TFR
# Extrinsic
for (tr in 1:10){
  x <- as.matrix(read.table(paste("C:/exp2/text_files_exp2/trial301G1_",as.character(tr),".txt",sep=""), quote="\"", comment.char=""))
  mu<-c(0,1/sqrt(2),1/sqrt(2))
  print(meandir.test(x[c(1:4,6:10),c(1:3)], mu,999))
  vmf.mle(x[c(1:4,6:10),c(1:3)], fast = FALSE, tol = 1e-07)
}

# Intrinsic
for (tr in 1:10){
  x <- as.matrix(read.table(paste("C:/exp2/text_files_exp2/trial301G2_",as.character(tr),".txt",sep=""), quote="\"", comment.char=""))
  mu<-c(0,1/sqrt(2),1/sqrt(2))
  print(meandir.test(x[c(1,3:10),c(1:3)], mu,999))
  vmf.mle(x[c(1,3:10),c(1:3)], fast = FALSE, tol = 1e-07)
}

# Control
for (tr in 1:10){
  x <- as.matrix(read.table(paste("C:/exp2/text_files_exp2/trial301G3_",as.character(tr),".txt",sep=""), quote="\"", comment.char=""))
  mu<-c(0,-1/sqrt(2),1/sqrt(2))
  print(meandir.test(x, mu,999))
  vmf.mle(x, fast = FALSE, tol = 1e-07)
}

## Late TRN vs. Early TFR  rotated -90 degrees around x
for (tr in 1:10){
  ina <- rep(1:2, each = 10)
  x <- as.matrix(read.table(paste("C:/exp2/text_files_exp2/trial301_300r90G1_",as.character(tr),".txt",sep=""), quote="\"", comment.char=""))
  print(het.aov(x[c(1:4,6:20),c(1:3)],ina[c(1:4,6:20)]))
  spherconc.test(x[c(1:4,6:20),c(1:3)], ina[c(1:4,6:20)])
  multivmf.mle(x[c(1:4,6:20),c(1:3)], ina[c(1:4,6:20)], tol = 1e-07, ell = FALSE)
}

## Early TFR vs. Late TFR
# Extrinsic
for (tr in 1:10){
  ina <- c(1,1,1,1,1,1,1,1,1,2,2,2,2,2,2,2,2,2,2)
  x <- as.matrix(read.table(paste("C:/exp2/text_files_exp2/trial301_360G1_",as.character(tr),".txt",sep=""), quote="\"", comment.char=""))
  print(het.aov(x[c(1:4,6:20),c(1:3)],ina))
  spherconc.test(x[c(1:4,6:20),c(1:3)], ina)
  multivmf.mle(x[c(1:4,6:20),c(1:3)], ina, tol = 1e-07, ell = FALSE)
}
# Intrinsic 
for (tr in 1:10){
  ina <- c(1,1,1,1,1,1,1,1,1,2,2,2,2,2,2,2,2,2,2)
  x <- as.matrix(read.table(paste("C:/exp2/text_files_exp2/trial301_360G2_",as.character(tr),".txt",sep=""), quote="\"", comment.char=""))
  print(het.aov(x[c(1,3:20),c(1:3)],ina))
  spherconc.test(x[c(1,3:20),c(1:3)], ina)
  multivmf.mle(x[c(1,3:20),c(1:3)], ina, tol = 1e-07, ell = FALSE)
}
# Control
for (tr in 1:10){
  ina <- rep(1:2, each = 10)
  x <- as.matrix(read.table(paste("C:/exp2/text_files_exp2/trial301_360G3_",as.character(tr),".txt",sep=""), quote="\"", comment.char=""))
  print(het.aov(x,ina))
  spherconc.test(x, ina)
  multivmf.mle(x, ina, tol = 1e-07, ell = FALSE)
}

## Late TFR
# Extrinsic
for (tr in 1:10){
  x <- as.matrix(read.table(paste("C:/exp2/text_files_exp2/trial360G1_",as.character(tr),".txt",sep=""), quote="\"", comment.char=""))
  mu<-c(0,1/sqrt(2),1/sqrt(2))
  print(meandir.test(x, mu,999))
  vmf.mle(x, fast = FALSE, tol = 1e-07)
}
# Intrinsic
for (tr in 1:10){
  x <- as.matrix(read.table(paste("C:/exp2/text_files_exp2/trial360G2_",as.character(tr),".txt",sep=""), quote="\"", comment.char=""))
  mu<-c(0,1/sqrt(2),1/sqrt(2))
  print(meandir.test(x, mu,999))
  vmf.mle(x, fast = FALSE, tol = 1e-07)
}
# Control
for (tr in 1:10){
  x <- as.matrix(read.table(paste("C:/exp2/text_files_exp2/trial360G3_",as.character(tr),".txt",sep=""), quote="\"", comment.char=""))
  mu<-c(0,-1/sqrt(2),1/sqrt(2))
  print(meandir.test(x, mu,999))
  vmf.mle(x, fast = FALSE, tol = 1e-07)
}

## Late BL2 vs. Late TFR
# Extrinsic
for (tr in 1:10){
  ina <- rep(1:2, each = 10)
  x <- as.matrix(read.table(paste("C:/exp2/text_files_exp2/trial120_360G1_",as.character(tr),".txt",sep=""), quote="\"", comment.char=""))
  print(het.aov(x,ina))
  spherconc.test(x,ina)
  multivmf.mle(x,ina, tol = 1e-07, ell = FALSE)
}
# Intrinsic 
for (tr in 1:10){
  ina <- rep(1:2, each = 10)
  x <- as.matrix(read.table(paste("C:/exp2/text_files_exp2/trial120_360G2_",as.character(tr),".txt",sep=""), quote="\"", comment.char=""))
  print(het.aov(x,ina))
  spherconc.test(x,ina)
  multivmf.mle(x,ina, tol = 1e-07, ell = FALSE)
}
# Control
for (tr in 1:10){
  ina <- rep(1:2, each = 10)
  x <- as.matrix(read.table(paste("C:/exp2/text_files_exp2/trial120_360G3_",as.character(tr),".txt",sep=""), quote="\"", comment.char=""))
  print(het.aov(x,ina))
  spherconc.test(x,ina)
  multivmf.mle(x,ina, tol = 1e-07, ell = FALSE)
}


# Part (2)

## Early TRN

for (tr in 1:10){
  x <- as.matrix(read.table(paste("C:/exp2/text_files_exp2/trial121G123_",as.character(tr),".txt",sep=""), quote="\"", comment.char=""))
  print(het.aov(x[c(1:4,6:11,13:20),c(1:3)],ina[c(1:4,6:11,13:20)]))} # extrinsic vs. intrinsic
for (tr in 1:10){
  x <- as.matrix(read.table(paste("C:/exp2/text_files_exp2/trial121G123_",as.character(tr),".txt",sep=""), quote="\"", comment.char=""))
  print(het.aov(x[c(1:4,6:10,21:30),c(1:3)],c(1,1,1,1,1,1,1,1,1,2,2,2,2,2,2,2,2,2,2)))} # extrinsic vs. control
for (tr in 1:10){
  x <- as.matrix(read.table(paste("C:/exp2/text_files_exp2/trial121G123_",as.character(tr),".txt",sep=""), quote="\"", comment.char=""))
  print(het.aov(x[c(11,13:20,21:30),c(1:3)],ina[c(11,13:20,21:30)]-1))} # intrinsic vs. control

## Late TRN

for (tr in 1:10){
  x <- as.matrix(read.table(paste("C:/exp2/text_files_exp2/trial300G123_",as.character(tr),".txt",sep=""), quote="\"", comment.char=""))
  print(het.aov(x[c(1:4,6:11,13:20),c(1:3)],ina[c(1:4,6:11,13:20)]))} # extrinsic vs. intrinsic
for (tr in 1:10){
  x <- as.matrix(read.table(paste("C:/exp2/text_files_exp2/trial300G123_",as.character(tr),".txt",sep=""), quote="\"", comment.char=""))
  print(het.aov(x[c(1:4,6:10,21:30),c(1:3)],c(1,1,1,1,1,1,1,1,1,2,2,2,2,2,2,2,2,2,2)))} # extrinsic vs. control
for (tr in 1:10){
  x <- as.matrix(read.table(paste("C:/exp2/text_files_exp2/trial3001G123_",as.character(tr),".txt",sep=""), quote="\"", comment.char=""))
  print(het.aov(x[c(11,13:20,21:30),c(1:3)],ina[c(11,13:20,21:30)]-1))} # intrinsic vs. control


## Early TFR

for (tr in 1:10){x <- as.matrix(read.table(paste("C:/exp2/text_files_exp2/trial301G123_",as.character(tr),".txt",sep=""), quote="\"", comment.char=""))
  print(het.aov(x[c(1:4,6:11,13:20),c(1:3)],ina[c(1:4,6:11,13:20)]))} # extrinsic vs. intrinsic
for (tr in 1:10){x <- as.matrix(read.table(paste("C:/exp2/text_files_exp2/trial301G123_",as.character(tr),".txt",sep=""), quote="\"", comment.char=""))
  print(het.aov(x[c(1:4,6:10,21:30),c(1:3)],c(1,1,1,1,1,1,1,1,1,2,2,2,2,2,2,2,2,2,2)))} # extrinsic vs. control
for (tr in 1:10){x <- as.matrix(read.table(paste("C:/exp2/text_files_exp2/trial301G123_",as.character(tr),".txt",sep=""), quote="\"", comment.char=""))
  print(het.aov(x[c(11,13:20,21:30),c(1:3)],ina[c(11,13:20,21:30)]-1))} # intrinsic vs. control