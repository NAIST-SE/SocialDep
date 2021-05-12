library(rms)
data <- data.frame(read.csv("/Users/kanchanok/Documents/Pattara-sensei/New_RubyGems1.1_Projects_with_Info_withCheckPageRank.csv"))
model_data <- data.frame( data$Versions.Count, data$SourceRank, data$Dependent.Projects.Count,
                          data$Dependent.Repositories.Count, data$Repository.Size, 
                          data$Repository.Stars.Count, data$Repository.Forks.Count, 
                          data$Repository.Open.Issues.Count,
                          data$Repository.Watchers.Count, data$Repository.Contributors.Count,
                          data$pageranks)
names(model_data)[1] <- "Versions_Count"
names(model_data)[2] <- "SourceRank"
names(model_data)[3] <- "Dependent_Projects_Count"
names(model_data)[4] <- "Dependent_Repositories_Count"
names(model_data)[5] <- "Repository_Size"
names(model_data)[6] <- "Repository_Stars_Count"
names(model_data)[7] <- "Repository_Watchers_Count"
names(model_data)[8] <- "Repository_Contributors_Count"
names(model_data)[9] <- "pageranks"


dd <- datadist(model_data)
options(datadist = 'dd')

budget =  floor( model_data$pageranks / 15)
budget

library(moments)
skewness(model_data$pageranks)
kurtosis(model_data$pageranks)

ind_vars <- c('Versions_Count', 'SourceRank', 'Dependent_Projects_Count', 
              'Dependent_Repositories_Count', 'Repository_Size', 
              'Repository_Stars_Count', 'Repository_Watchers_Count', 
              'Repository_Contributors_Count')
vc <- varclus(~ ., data = model_data[, ind_vars], trans='abs')
plot(vc)
threashold <- 0.7
abline(h=1-threashold, col = "red", lty = 2)


reject_vars <- c('Repository_Watchers_Count', 'Dependent_Repositories_Count' )
ind_vars <- ind_vars[!(ind_vars%in% reject_vars)]
vc <- varclus(~ ., data = model_data[, ind_vars], trans='abs')
plot(vc)
threashold <- 0.7
abline(h=1-threashold, col = "red", lty = 2)


reject_vars <- c('SourceRank' )
ind_vars <- ind_vars[!(ind_vars%in% reject_vars)]
vc <- varclus(~ ., data = model_data[, ind_vars], trans='abs')
plot(vc)
threashold <- 0.7
abline(h=1-threashold, col = "red", lty = 2)

reject_vars <- c('Repository_Stars_Count' )
ind_vars <- ind_vars[!(ind_vars%in% reject_vars)]
vc <- varclus(~ ., data = model_data[, ind_vars], trans='abs')
plot(vc)
threashold <- 0.7
abline(h=1-threashold, col = "red", lty = 2)

red <- redun(~., data=model_data[,ind_vars], nk = 0)
red

spearman2 = spearman2(log1p(pageranks) ~ Repository_Contributors_Count   + Versions_Count  + Repository_Size + Dependent_Projects_Count , data = model_data, p = 2)
plot(spearman2)

fit <- ols(log1p(pageranks) ~ rcs(Repository_Contributors_Count,5) + rcs(Versions_Count,3) + Dependent_Projects_Count + Repository_Size, data = model_data, x = T, y = T )
fit

num_tier = 1000
val <- validate(fit, B=num_tier)
val

chisq <- anova(fit, test = "Chisq")
chisq

bootcov_obj = bootcov(fit,B=num_tier)
response_curve = Predict(bootcov_obj,
                         Repository_Size,
                         fun = function (x) return (exp(x)))

plot(response_curve)
response_curve