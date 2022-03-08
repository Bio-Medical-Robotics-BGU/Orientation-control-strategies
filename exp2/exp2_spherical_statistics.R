# EXPERIMENT 2 - SPHERICAL STATISTICS
# Part (1) - axis analysis within groups
# Part (2) - axis analysis between groups

# Part (1)

## trial 60 and 121
# Extrinsic
ina <- rep(1:2, each = 10)
x <- as.matrix(read.table("C:/exp2/text_files_exp2/trial60_121G1.txt", quote="\"", comment.char=""))
het.aov(x,ina)
spherconc.test(x, ina)
multivmf.mle(x, ina, tol = 1e-07, ell = FALSE)
# Intrinsic 
ina <- rep(1:2, each = 10)
x <- as.matrix(read.table("C:/exp2/text_files_exp2/trial60_121G2.txt", quote="\"", comment.char=""))
het.aov(x,ina)
spherconc.test(x, ina)
multivmf.mle(x, ina, tol = 1e-07, ell = FALSE)
# Control
ina <- rep(1:2, each = 10)
x <- as.matrix(read.table("C:/exp2/text_files_exp2/trial60_121G3.txt", quote="\"", comment.char=""))
het.aov(x,ina)
spherconc.test(x, ina)
multivmf.mle(x, ina, tol = 1e-07, ell = FALSE)

# trial 121 - first exposure
# Extrinsic
x <- as.matrix(read.table("C:/exp2/text_files_exp2/trial121G1.txt", quote="\"", comment.char=""))
mu<-c(0,-1/sqrt(2),1/sqrt(2))
meandir.test(x, mu,999)
# Intrinsic
x <- as.matrix(read.table("C:/exp2/text_files_exp2/trial121G2.txt", quote="\"", comment.char=""))
mu<-c(0,1/sqrt(2),1/sqrt(2))
meandir.test(x, mu,999)
# Control
x <- as.matrix(read.table("C:/exp2/text_files_exp2/trial121G3.txt", quote="\"", comment.char=""))
mu<-c(0,1/sqrt(2),1/sqrt(2))
meandir.test(x, mu,999)

## trial 121 and 300 - adaptation
ina <- rep(1:2, each = 10)
# Extrinsic
x <- as.matrix(read.table("C:/exp2/text_files_exp2/trial121_300G1.txt", quote="\"", comment.char=""))
het.aov(x,ina)
spherconc.test(x, ina)
multivmf.mle(x, ina, tol = 1e-07, ell = FALSE)
# Intrinsic 
x <- as.matrix(read.table("C:/exp2/text_files_exp2/trial121_300G2.txt", quote="\"", comment.char=""))
het.aov(x,ina)
spherconc.test(x, ina)
multivmf.mle(x, ina, tol = 1e-07, ell = FALSE)
# Control
x <- as.matrix(read.table("C:/exp2/text_files_exp2/trial121_300G3.txt", quote="\"", comment.char=""))
het.aov(x,ina)
spherconc.test(x, ina)
multivmf.mle(x, ina, tol = 1e-07, ell = FALSE)


## trial 300 - last exposure
# Extrinsic
x <- as.matrix(read.table("C:/exp2/text_files_exp2/trial300G1.txt", quote="\"", comment.char=""))
mu<-c(0,(sqrt(3)-1)/(2*sqrt(2)),(sqrt(3)+1)/(2*sqrt(2)))
meandir.test(x, mu,999)
# Intrinsic
x <- as.matrix(read.table("C:/exp2/text_files_exp2/trial300G2.txt", quote="\"", comment.char=""))
mu<-c(0,(sqrt(3)+1)/(2*sqrt(2)),(1-sqrt(3))/(2*sqrt(2)))
meandir.test(x, mu,999)
# Control
x <- as.matrix(read.table("C:/exp2/text_files_exp2/trial300G3.txt", quote="\"", comment.char=""))
mu<-c(0,(sqrt(3)+1)/(2*sqrt(2)),(1-sqrt(3))/(2*sqrt(2)))
meandir.test(x, mu,999)

## trial 60 and 300
# Extrinsic
ina <- rep(1:2, each = 10)
x <- as.matrix(read.table("C:/exp2/text_files_exp2/trial60_300G1.txt", quote="\"", comment.char=""))
het.aov(x,ina)
spherconc.test(x, ina)
multivmf.mle(x, ina, tol = 1e-07, ell = FALSE)
# Intrinsic 
ina <- rep(1:2, each = 10)
x <- as.matrix(read.table("C:/exp2/text_files_exp2/trial60_300G2.txt", quote="\"", comment.char=""))
het.aov(x,ina)
spherconc.test(x, ina)
multivmf.mle(x, ina, tol = 1e-07, ell = FALSE)
# Control
ina <- rep(1:2, each = 10)
x <- as.matrix(read.table("C:/exp2/text_files_exp2/trial60_300G3.txt", quote="\"", comment.char=""))
het.aov(x,ina)
spherconc.test(x, ina)
multivmf.mle(x, ina, tol = 1e-07, ell = FALSE)

## trial 120 and 301
# Extrinsic
ina <- rep(1:2, each = 10)
x <- as.matrix(read.table("C:/exp2/text_files_exp2/trial120_301G1.txt", quote="\"", comment.char=""))
het.aov(x[c(1:14,16:20),c(1:3)],ina[c(1:14,16:20)])
spherconc.test(x[c(1:14,16:20),c(1:3)], ina[c(1:14,16:20)])
multivmf.mle(x[c(1:14,16:20),c(1:3)], ina[c(1:14,16:20)], tol = 1e-07, ell = FALSE)
# Intrinsic 
ina <- rep(1:2, each = 10)
x <- as.matrix(read.table("C:/exp2/text_files_exp2/trial120_301G2.txt", quote="\"", comment.char=""))
het.aov(x[c(1:11,13:20),c(1:3)],ina[c(1:11,13:20)])
spherconc.test(x[c(1:11,13:20),c(1:3)],ina[c(1:11,13:20)])
multivmf.mle(x[c(1:11,13:20),c(1:3)],ina[c(1:11,13:20)], tol = 1e-07, ell = FALSE)
# Control
ina <- rep(1:2, each = 10)
x <- as.matrix(read.table("C:/exp2/text_files_exp2/trial120_301G3.txt", quote="\"", comment.char=""))
het.aov(x,ina)
spherconc.test(x, ina)
multivmf.mle(x, ina, tol = 1e-07, ell = FALSE)

# trial 301 - aftereffect
# Extrinsic
x <- as.matrix(read.table("C:/exp2/text_files_exp2/trial301G1.txt", quote="\"", comment.char=""))
mu<-c(0,1/sqrt(2),1/sqrt(2))
meandir.test(x[c(1:4,6:10),c(1:3)], mu,999)
vmf.mle(x[c(1:4,6:10),c(1:3)], fast = FALSE, tol = 1e-07)
# Intrinsic
x <- as.matrix(read.table("C:/exp2/text_files_exp2/trial301G2.txt", quote="\"", comment.char=""))
mu<-c(0,1/sqrt(2),1/sqrt(2))
meandir.test(x[c(1,3:10),c(1:3)], mu,999)
vmf.mle(x[c(1,3:10),c(1:3)], fast = FALSE, tol = 1e-07)
# Control
x <- as.matrix(read.table("C:/exp2/text_files_exp2/trial301G3.txt", quote="\"", comment.char=""))
mu<-c(0,-1/sqrt(2),1/sqrt(2))
meandir.test(x, mu,999)
vmf.mle(x, fast = FALSE, tol = 1e-07)

# trial 300 and 301 rotated -90 degrees around x - partial transfer
ina <- rep(1:2, each = 10)
x <- as.matrix(read.table("C:/exp2/text_files_exp2/trial301_300r90G1.txt", quote="\"", comment.char=""))
het.aov(x[c(1:4,6:20),c(1:3)],ina[c(1:4,6:20)])
spherconc.test(x[c(1:4,6:20),c(1:3)], ina[c(1:4,6:20)])
multivmf.mle(x[c(1:4,6:20),c(1:3)], ina[c(1:4,6:20)], tol = 1e-07, ell = FALSE)

## trial 301 and 360 - washout
# Extrinsic
ina <- c(1,1,1,1,1,1,1,1,1,2,2,2,2,2,2,2,2,2,2)
x <- as.matrix(read.table("C:/exp2/text_files_exp2/trial301_360G1.txt", quote="\"", comment.char=""))
het.aov(x[c(1:4,6:20),c(1:3)],ina)
spherconc.test(x[c(1:4,6:20),c(1:3)], ina)
multivmf.mle(x[c(1:4,6:20),c(1:3)], ina, tol = 1e-07, ell = FALSE)
# Intrinsic 
ina <- c(1,1,1,1,1,1,1,1,1,2,2,2,2,2,2,2,2,2,2)
x <- as.matrix(read.table("C:/exp2/text_files_exp2/trial301_360G2.txt", quote="\"", comment.char=""))
het.aov(x[c(1,3:20),c(1:3)],ina)
spherconc.test(x[c(1,3:20),c(1:3)], ina)
multivmf.mle(x[c(1,3:20),c(1:3)], ina, tol = 1e-07, ell = FALSE)
# Control
ina <- rep(1:2, each = 10)
x <- as.matrix(read.table("C:/exp2/text_files_exp2/trial301_360G3.txt", quote="\"", comment.char=""))
het.aov(x,ina)
spherconc.test(x, ina)
multivmf.mle(x, ina, tol = 1e-07, ell = FALSE)

# trial 360 - regain BL behavior
# Extrinsic
x <- as.matrix(read.table("C:/exp2/text_files_exp2/trial360G1.txt", quote="\"", comment.char=""))
mu<-c(0,1/sqrt(2),1/sqrt(2))
meandir.test(x, mu,999)
vmf.mle(x, fast = FALSE, tol = 1e-07)
# Intrinsic
x <- as.matrix(read.table("C:/exp2/text_files_exp2/trial360G2.txt", quote="\"", comment.char=""))
mu<-c(0,1/sqrt(2),1/sqrt(2))
meandir.test(x, mu,999)
vmf.mle(x, fast = FALSE, tol = 1e-07)
# Control
x <- as.matrix(read.table("C:/exp2/text_files_exp2/trial360G3.txt", quote="\"", comment.char=""))
mu<-c(0,-1/sqrt(2),1/sqrt(2))
meandir.test(x, mu,999)
vmf.mle(x, fast = FALSE, tol = 1e-07)

## trial 120 and 360
# Extrinsic
ina <- rep(1:2, each = 10)
x <- as.matrix(read.table("C:/exp2/text_files_exp2/trial120_360G1.txt", quote="\"", comment.char=""))
het.aov(x,ina)
spherconc.test(x,ina)
multivmf.mle(x,ina, tol = 1e-07, ell = FALSE)
# Intrinsic 
ina <- rep(1:2, each = 10)
x <- as.matrix(read.table("C:/exp2/text_files_exp2/trial120_360G2.txt", quote="\"", comment.char=""))
het.aov(x,ina)
spherconc.test(x,ina)
multivmf.mle(x,ina, tol = 1e-07, ell = FALSE)
# Control
ina <- rep(1:2, each = 10)
x <- as.matrix(read.table("C:/exp2/text_files_exp2/trial120_360G3.txt", quote="\"", comment.char=""))
het.aov(x,ina)
spherconc.test(x,ina)
multivmf.mle(x,ina, tol = 1e-07, ell = FALSE)


# Part (2)
# trial 60 - BL1
ina <- rep(1:3, each = 10)
x <- as.matrix(read.table("C:/exp2/text_files_exp2/trial60G123.txt", quote="\"", comment.char=""))
het.aov(x,ina)
spherconc.test(x, ina)
multivmf.mle(x, ina, tol = 1e-07, ell = FALSE)
# trial 120 - BL2
ina <- rep(1:3, each = 10)
x <- as.matrix(read.table("C:/exp2/text_files_exp2/trial120G123.txt", quote="\"", comment.char=""))
het.aov(x,ina)
spherconc.test(x, ina)
multivmf.mle(x, ina, tol = 1e-07, ell = FALSE)
# trial 121 - first exposure
ina <- rep(1:3, each = 10)
x <- as.matrix(read.table("C:/exp2/text_files_exp2/trial121G123.txt", quote="\"", comment.char=""))
het.aov(x,ina)
spherconc.test(x, ina)
multivmf.mle(x, ina, tol = 1e-07, ell = FALSE)

het.aov(x[c(1:4,6:11,13:20),c(1:3)],ina[c(1:4,6:11,13:20)]) # extrinsic vs. intrinsic
het.aov(x[c(1:4,6:10,21:30),c(1:3)],c(1,1,1,1,1,1,1,1,1,2,2,2,2,2,2,2,2,2,2)) # extrinsic vs. control
het.aov(x[c(11,13:20,21:30),c(1:3)],ina[c(11,13:20,21:30)]-1) # intrinsic vs. control

# trial 300 - last exposure
ina <- rep(1:3, each = 10)
x <- as.matrix(read.table("C:/exp2/text_files_exp2/trial300G123.txt", quote="\"", comment.char=""))
het.aov(x,ina)
spherconc.test(x, ina)
multivmf.mle(x, ina, tol = 1e-07, ell = FALSE)
# trial 301 - aftereffect
ina <- rep(1:3, each = 10)
x <- as.matrix(read.table("C:/exp2/text_files_exp2/trial301G123.txt", quote="\"", comment.char=""))
het.aov(x[c(1:4,6:11,13:30),c(1:3)],ina[c(1:4,6:11,13:30)])
spherconc.test(x[c(1:4,6:11,13:30),c(1:3)], ina[c(1:4,6:11,13:30)])
multivmf.mle(x[c(1:4,6:11,13:30),c(1:3)], ina[c(1:4,6:11,13:30)], tol = 1e-07, ell = FALSE)


het.aov(x[c(1:4,6:11,13:20),c(1:3)],ina[c(1:4,6:11,13:20)]) # extrinsic vs. intrinsic
het.aov(x[c(1:4,6:10,21:30),c(1:3)],c(1,1,1,1,1,1,1,1,1,2,2,2,2,2,2,2,2,2,2)) # extrinsic vs. control
het.aov(x[c(11,13:20,21:30),c(1:3)],ina[c(11,13:20,21:30)]-1) # intrinsic vs. control

# trial mean(301-303) - aftereffect - averaging the first 3 trials of TFR
ina <- rep(1:3, each = 10)
x <- as.matrix(read.table("C:/exp2/text_files_exp2/meantrial301_302_303G123.txt", quote="\"", comment.char=""))
het.aov(x,ina)
spherconc.test(x, ina)
multivmf.mle(x, ina, tol = 1e-07, ell = FALSE)


het.aov(x[c(1:20),c(1:3)],ina[c(1:20)]) # extrinsic vs. intrinsic
het.aov(x[c(1:10,21:30),c(1:3)],ina[c(1:20)]) # extrinsic vs. control
het.aov(x[c(11:30),c(1:3)],ina[c(1:20)]) # intrinsic vs. control


# trial 360 - washout
ina <- rep(1:3, each = 10)
x <- as.matrix(read.table("C:/exp2/text_files_exp2/trial360G123.txt", quote="\"", comment.char=""))
het.aov(x,ina)
spherconc.test(x, ina)
multivmf.mle(x, ina, tol = 1e-07, ell = FALSE)