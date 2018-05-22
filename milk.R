library(nlme)
data(Milk)
View(Milk)

library(greta)

## One random effect per cow

sgmt <- Milk$Diet == "barley"
Cow <- unclass(Milk$Cow)[sgmt]
protein <- as_data(Milk$protein[sgmt])
Time <- as_data(Milk$Time[sgmt])

ncows <- length(levels(Milk$Cow)) 
sigma2 <- variable(lower=0)
sigma2_cow <- variable(lower=0)
alpha <- variable()
beta <- normal(0, sigma2_cow, dim=ncows)
pmean <- alpha + beta[Cow]*Time
distribution(protein) <- normal(pmean, sigma2) 
m <- model(alpha, sigma2, sigma2_cow)
plot(m)
draws <- mcmc(m, n_samples = 10000, warmup=2000, chains=1)

library(bayesplot)
mcmc_trace(draws)

## One random intercept per cow
## random slope per diet



