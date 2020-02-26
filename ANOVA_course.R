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



