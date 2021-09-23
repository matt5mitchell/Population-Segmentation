##########
## KPOP ##
##########

## Latent class analysis
## Identify prospective subgroups for use in qualitative analysis

library(poLCA)
library(broom)
library(tidyverse)

t1 <- Sys.time()


#Data prep
#Requires data frame "kpop" with patient characteristics
lcadata <- kpop %>% select(Gender, PrimaryRace, AgeBand, HomelessDescription, Income, EDvisits, IPmed, IPpsych, SelfHarm, Abuse, TBI, Developmental, Trauma, Schizophrenia, Bipolar, Depression, Anxiety, Alcohol, Opioid, StimCocaine, COPD, Diabetes, Heart, HepC, Kidney, Liver)
lcadata$Income <- ifelse(lcadata$MonthlyIncome > 0 , 1, 0)
lcadata$EDvisits <- cut(lcadata$EDvisits, breaks=c(0,1,2,4,7,1000), right=FALSE)
lcadata$IPmed <- cut(lcadata$IPmed, breaks=c(0,1,2,3,1000), right=FALSE)
lcadata$IPpsych <- cut(lcadata$IPpsych, breaks=c(0,1,2,3,1000), right=FALSE)
lcadata <- lapply(lcadata, factor)
levels(lcadata$PrimaryRace) <- list(AmInAlNa="American Indian or Alaska Native", Asian="Asian", Black="Black", Hispanic="Hispanic", Multiracial="MultiRacial", NaHaPacIs="Native Hawaiian or Other Pacific Islander", Declined="Patient Declined", Unknown="Unknown", White="White")
lcadata <- data.frame(lcadata)

#Fit models with i subgroups
lca <- list()
for(i in 1:30){
  lca[[i]] <- poLCA(cbind(Gender, PrimaryRace, AgeBand, HomelessDescription, Income, EDvisits, IPmed, IPpsych, SelfHarm, Abuse, TBI, Developmental, Trauma, Schizophrenia, Bipolar, Depression, Anxiety, Alcohol, Opioid, StimCocaine, COPD, Diabetes, Heart, HepC, Kidney, Liver) ~ 1,
                    nclass=i, maxiter=10000, nrep=10, data=lcadata)
}

results.lca <- data.frame()
for(i in 1:30){
  results.lca <- rbind(results.lca, glance(lca[[i]]))
}


#How long did that take?
print(difftime(Sys.time(), t1, units='mins'))


#Plot goodness of fit statistics
library(tidyverse)
results.lca %>%
  mutate(nclass=rownames(.)) %>%
  gather("Statistic", "Value", 2:3) %>%
  ggplot(aes(x=as.numeric(nclass), y=Value, group=Statistic)) + geom_line() + geom_point()
