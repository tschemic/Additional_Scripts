### Example VCA analysis ###

library(VCA)

data(dataEP05A2_2)

# perform ANOVA-estimation of variance components
res <- anovaVCA(y~day/run, dataEP05A2_2)
res

# design with two main effects (ignoring the hierarchical structure of the design)
anovaVCA(y~day+run, dataEP05A2_2)

# compute confidence intervals, perform F- and Chi-Squared tests
INF <- VCAinference(res, total.claim=3.5, error.claim=2)
INF

data(VCAdata1)
data_sample1 <- VCAdata1[VCAdata1$sample==1,]

### plot data for visual inspection
varPlot(y~lot/day/run, data_sample1)

### estimate VCs for 4-level hierarchical design (error counted) for sample_1 data
anovaVCA(y~lot/day/run, data_sample1)

### using different model (ignoring the hierarchical structure of the design)
anovaVCA(y~lot+day+lot:day:run, data_sample1)

### same model with unbalanced data
anovaVCA(y~lot+day+lot:day:run, data_sample1[-c(1,11,15),])

### use the numerical example from the CLSI EP05-A2 guideline (p.25)
data(Glucose,package="VCA")
res.ex <- anovaVCA(result~day/run, Glucose)

### also perform Chi-Squared tests
### Note: in guideline claimed SD-values are used, here, claimed variances are used
VCAinference(res.ex, total.claim=3.4^2, error.claim=2.5^2)

### now use the six sample reproducibility data from CLSI EP5-A3
### and fit per sample reproducibility model
data(CA19_9)
fit.all <- anovaVCA(result~site/day, CA19_9, by="sample")

reproMat <- data.frame(
  Sample=c("P1", "P2", "Q3", "Q4", "P5", "Q6"),
  Mean= c(fit.all[[1]]$Mean, fit.all[[2]]$Mean, fit.all[[3]]$Mean,
          fit.all[[4]]$Mean, fit.all[[5]]$Mean, fit.all[[6]]$Mean),
  Rep_SD=c(fit.all[[1]]$aov.tab["error","SD"], fit.all[[2]]$aov.tab["error","SD"],
           fit.all[[3]]$aov.tab["error","SD"], fit.all[[4]]$aov.tab["error","SD"],
           fit.all[[5]]$aov.tab["error","SD"], fit.all[[6]]$aov.tab["error","SD"]),
  Rep_CV=c(fit.all[[1]]$aov.tab["error","CV[%]"],fit.all[[2]]$aov.tab["error","CV[%]"],
           fit.all[[3]]$aov.tab["error","CV[%]"],fit.all[[4]]$aov.tab["error","CV[%]"],
           fit.all[[5]]$aov.tab["error","CV[%]"],fit.all[[6]]$aov.tab["error","CV[%]"]),WLP_SD=c(sqrt(sum(fit.all[[1]]$aov.tab[3:4,"VC"])),sqrt(sum(fit.all[[2]]$aov.tab[3:4, "VC"])),
                                                                                                 sqrt(sum(fit.all[[3]]$aov.tab[3:4,"VC"])),sqrt(sum(fit.all[[4]]$aov.tab[3:4, "VC"])),sqrt(sum(fit.all[[5]]$aov.tab[3:4,"VC"])),sqrt(sum(fit.all[[6]]$aov.tab[3:4, "VC"]))),WLP_CV=c(sqrt(sum(fit.all[[1]]$aov.tab[3:4,"VC"]))/fit.all[[1]]$Mean*100,sqrt(sum(fit.all[[2]]$aov.tab[3:4,"VC"]))/fit.all[[2]]$Mean*100,sqrt(sum(fit.all[[3]]$aov.tab[3:4,"VC"]))/fit.all[[3]]$Mean*100,sqrt(sum(fit.all[[4]]$aov.tab[3:4,"VC"]))/fit.all[[4]]$Mean*100,sqrt(sum(fit.all[[5]]$aov.tab[3:4,"VC"]))/fit.all[[5]]$Mean*100,sqrt(sum(fit.all[[6]]$aov.tab[3:4,"VC"]))/fit.all[[6]]$Mean*100),Repro_SD=c(fit.all[[1]]$aov.tab["total","SD"],fit.all[[2]]$aov.tab["total","SD"],fit.all[[3]]$aov.tab["total","SD"],fit.all[[4]]$aov.tab["total","SD"],fit.all[[5]]$aov.tab["total","SD"],fit.all[[6]]$aov.tab["total","SD"]),Repro_CV=c(fit.all[[1]]$aov.tab["total","CV[%]"],fit.all[[2]]$aov.tab["total","CV[%]"],fit.all[[3]]$aov.tab["total","CV[%]"],fit.all[[4]]$aov.tab["total","CV[%]"],fit.all[[5]]$aov.tab["total","CV[%]"],fit.all[[6]]$aov.tab["total","CV[%]"]))


for(i in 3:8) reproMat[,i] <- round(reproMat[,i],digits=ifelse(i%%2==0,1,3))
reproMat

# now plot the precision profile over all samples
plot(reproMat[,"Mean"], reproMat[,"Rep_CV"], type="l", main="Precision Profile CA19-9",xlab="Mean CA19-9 Value", ylab="CV[%]")
grid()
points(reproMat[,"Mean"], reproMat[,"Rep_CV"], pch=16)


# load another example dataset and extract the "sample==1" subset
data(VCAdata1)
sample1 <- VCAdata1[which(VCAdata1$sample==1),]

# generate an additional factor variable and random errors according to its levels
sample1$device <- gl(3,28,252)
set.seed(505)
sample1$y <- sample1$y + rep(rep(rnorm(3,,.25), c(28,28,28)),3)


# fit a crossed-nested design with main factors'lot'and'device'
# and nested factors'day'and'run'nested below
res1 <- anovaVCA(y~(lot+device)/day/run, sample1)
res1

# fit same model for each sample using by-processing
lst <- anovaVCA(y~(lot+device)/day/run, VCAdata1, by="sample")
lst


