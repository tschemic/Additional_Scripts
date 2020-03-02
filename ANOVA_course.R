# Data creation
dc <- data.frame(s1 = rnorm(50, mean=6),
                 s2 = rnorm(50, mean=5),
                 s3 = rnorm(50, mean=7))
head(dc)
sc <- stack(dc)
head(sc)

cols <- c("green", "orange", "blue")
boxplot(dc, col=cols)

# Homoscedasdicity tests
bartlett.test(values ~ ind, sc)
bartlett.test(dc)
fligner.test(values ~ ind, sc)
fligner.test(dc)

# ANOVA
ac <- aov(values ~ ind, sc)
summary(ac) # "Mean Sq" shows the variances ("ind" is between-group and "residuals" is within groups)
plot(ac) # plots 1 & 3 show the constancy of variance, plot 2 the normality of the data


# Post Hoc Tests to check which groups are different (done after ANOVA if ANOVA showed difference)
# Tukey's Honestly Significant Differences (HSD) Test
hsd <- TukeyHSD(ac)
print(hsd)
plot(hsd) # shows 95% family-wise confidence intervals

# T-Test with multiple testing correction (is necessary since more then 2 groups are compared)
pairwise.t.test(sc$values, sc$ind, p.adjust.method = "BH")


# T-Test - ANOVA comparison
set.seed(137)
g1 <- rnorm(20, mean=1.7, sd=0.4)
g2 <- rnorm(20, mean=2.1, sd=0.4)
wf <- data.frame(grp1=g1, grp2=g2)
tf <- stack(wf)

t.test(g1, g2, var.equal = TRUE) # by default t.test function assumes unequal variance (heteroscedasticity) and uses Welch's t-test, thus var.equal=TRUE has to be specified if the classic Student's t-test is used (which needs homoscedasticity)
summary(aov(values~ind, tf)) # produces the same p-value

# ANOVA as linear regression
ld <- within(sc, {
  m <- as.integer(ind == "s2")
  w <- as.integer(ind == "s3")
})
lr <- lm(values ~ m + w, ld)
summary(lr) # "Estimate" are the group means, and F-statistic is also shown (same as with ANOVA)

ac <- aov(values ~ ind, sc)
summary(ac)
summary.aov(lr)


# Data with unequal variance
dcu <- data.frame(s1 = rnorm(50, mean=6, sd = 1),
                 s2 = rnorm(50, mean=5, sd = 3),
                 s3 = rnorm(50, mean=7, sd = 0.2))
cols <- c("green", "orange", "blue")
boxplot(dcu, col=cols)

bartlett.test(dcu)
fligner.test(dcu) # both tests show significance indicating unequal variances

scu <- stack(dcu)
wone <- oneway.test(values ~ ind, scu) # Welch's one-way test can be used with unequal variances
wone

# Games-Howell Post-Hoc test for samples with unequal variance (equivalent to TukeyHSD, which can only be used with equal variance)
source("gameshowell.R")
games.howell(scu$ind, scu$values) # Games-Howell test can also be used with non-normal distributions! (e.g. when Kruskal's non-parametric test of equality of group means was used instead of ANOVA)


# Non-normally disributed samples
set.seed(137)
g1 <- rgamma(20, shape = 2, scale = 2.0)
g2 <- rgamma(20, shape = 2, scale = 2.0)
g3 <- rgamma(20, shape = 2, scale = 2.0)
gd <- rgamma(20, shape = 2, scale = 2.0) + 1.5
d.same <- data.frame(grp1=g1, grp2=g2, grp3=g3)
d.diff <- d.same
d.diff$grp2 <- gd

kruskal.test(d.same) # Kruskal's test
kruskal.test(d.diff)


# Two-way ANOVA

p1 <- rep(c(rep("wt",3), rep("mutant",3), rep("kockout",3)), 5)
p2 <- rep(x = c("food1", "food2", "food3"), 15)
d <- rnorm(45, mean=6)
d2 <- data.frame(P1 = p1, P2 = p2, Data = d)
ms <- with(d2, tapply(Data, list(P1, P2), mean)) # calculates means e.g. for plotting
barplot(ms, beside = TRUE, col = rainbow(3))

with(d2, interaction.plot(P1, P2, Data)) # R standard function for plotting 2-way ANOVA datasets

model <- aov(Data ~ P1 * P2, d2) # full model - checks individual factors and combination
summary.aov(model)
summary.lm(model) # results summarized as linear model -  shows more details

noint.model <- aov(Data ~ P1 + P2, d2) # model without interaction
summary.aov(noint.model)
summary.lm(noint.model)

# 2-way post-hoc tests
hsd <- TukeyHSD(noint.model, "P1")
hsd
plot(hsd)


# Nested design

p2 <- rep(c(rep("wt",3), rep("mutant",3), rep("kockout",3)), 5)
p3 <- rep(x = c("food1", "food2", "food3"), 15)
p1 <- c(rep("exp1",9), rep("exp2",9), rep("exp3",9), rep("exp4",9), rep("exp5",9))
d <- rnorm(45, mean=6)
nd <- data.frame(P1 = p1, P2 = p2, P3 = p3, Data = d)

bad <- aov(Data ~ P2 * P3, nd)
summary(bad)
good <- aov(Data ~ P2 * P3 + Error(P1/P2), nd) # the Error term tells the ANOVA about the nested design (corrects the degrees of freedom)
summary(good)




