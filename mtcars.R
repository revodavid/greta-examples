## multiple regression

mtc.lm <- lm(mpg ~ disp + hp + wt, data=mtcars)
coef(summary(mtc.lm))
summary(mtc.lm)$sigma

# plot(fitted(mtc.lm),residuals(mtc.lm))

disp <- as_data(mtcars$disp)
hp <- as_data(mtcars$hp)
wt <- as_data(mtcars$wt)
mpg <- as_data(mtcars$mpg)

mpg.a0 <- variable()
mpg.a1 <- variable()
mpg.a2 <- variable()
mpg.a3 <- variable()
mpg.sigma <- variable(lower=0)

mean.mpg <- mpg.a0 + mpg.a1*disp + mpg.a2*hp + mpg.a3*wt
distribution(mpg) <- normal(mean.mpg, mpg.sigma)
m.mpg <- model(mpg.a0, mpg.a1, mpg.a2, mpg.a3, mpg.sigma)
plot(m.mpg)

draws.mpg <- mcmc(m.mpg, n_samples = 5000, warmup=2000, chains=1)
summary(draws.mpg)

draws.mpg10 <- mcmc(m.mpg, n_samples = 20000, warmup=2000, chains=1, n_cores=4)
summary(draws.mpg10)

library(bayesplot)
mcmc_trace(draws.mpg)
mcmc_trace(draws.mpg10)
mcmc_hist(draws.mpg10)
mcmc_intervals(draws.mpg10)


## analysis of variance

library(greta)

disp2 <- as_data(mtcars$disp)
hp2 <- as_data(mtcars$hp)
wt2 <- as_data(mtcars$wt)
mpg2 <- as_data(mtcars$mpg)
cyl.f <- as.vector(unclass(factor(mtcars$cyl)))
cyl <- as_data(cyl.f) # 1 2 3

mpg2.disp <- variable()
mpg2.hp <- variable()
mpg2.wt <- variable()
mpg2.cyl <- variable(dim=3)
mpg2.sigma <- variable(lower=0)

mean.mpg2 <- mpg2.disp*disp2 + mpg2.hp*hp2 + mpg2.wt*wt2 + mpg2.cyl[cyl.f]
distribution(mpg2) <- normal(mean.mpg2, mpg2.sigma)
m.mpg2 <- model(mpg2.disp, mpg2.hp, mpg2.wt, mpg2.cyl, mpg2.sigma)
plot(m.mpg2)

draws.mpg2 <- mcmc(m.mpg2, n_samples = 40000, warmup=4000, chains=1)
summary(draws.mpg2)
library(bayesplot)
mcmc_trace(draws.mpg2)


## compare with lm

mtc.lm2 <- lm(mpg ~ disp + hp + wt + factor(cyl) - 1, data=mtcars)
coef(summary(mtc.lm2))
summary(mtc.lm2)$sigma
plot(mtc.lm2)

