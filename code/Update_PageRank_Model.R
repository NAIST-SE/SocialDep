library(rms)
data <- data.frame(read.csv("/Users/kanchanok/Documents/Pattara-sensei/data_to_create_model/Info_Maven1.1_Model(update).csv"))
model_data <- data.frame( data$Versions.Count, data$SourceRank, data$Dependent.Projects.Count,
                          data$Dependent.Repositories.Count, data$Repository.Size, 
                          data$Repository.Stars.Count, data$Repository.Forks.Count, 
                          data$Repository.Open.Issues.Count,
                          data$Repository.Watchers.Count, data$Repository.Contributors.Count,
                          data$pageranks, data$Today_UpDate, data$Update_Create, data$Degree)
names(model_data)[1] <- "Versions_Count"
names(model_data)[2] <- "SourceRank"
names(model_data)[3] <- "Dependent_Projects_Count"
names(model_data)[4] <- "Dependent_Repositories_Count"
names(model_data)[5] <- "Repository_Size"
names(model_data)[6] <- "Repository_Stars_Count"
names(model_data)[7] <- "Repository_Forks_Count"
names(model_data)[8] <- "Repository_Open_Issues_Count"
names(model_data)[9] <- "Repository_Watchers_Count"
names(model_data)[10] <- "Repository_Contributors_Count"
names(model_data)[11] <- "pageranks"
names(model_data)[12] <- "Today_UpDate_Months"
names(model_data)[13] <- "Update_Create_Months"
names(model_data)[14] <- "Degree"


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
              'Repository_Contributors_Count', 'Today_UpDate_Months',
              'Update_Create_Months', 'Repository_Forks_Count',
              'Repository_Open_Issues_Count')
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


reject_vars <- c('Repository_Watchers_Count' )
ind_vars <- ind_vars[!(ind_vars%in% reject_vars)]
vc <- varclus(~ ., data = model_data[, ind_vars], trans='abs')
plot(vc)
threashold <- 0.7
abline(h=1-threashold, col = "red", lty = 2)

reject_vars <- c('Repository_Forks_Count' )
ind_vars <- ind_vars[!(ind_vars%in% reject_vars)]
vc <- varclus(~ ., data = model_data[, ind_vars], trans='abs')
plot(vc)
threashold <- 0.7
abline(h=1-threashold, col = "red", lty = 2)

reject_vars <- c('Repository_Open_Issues_Count' )
ind_vars <- ind_vars[!(ind_vars%in% reject_vars)]
vc <- varclus(~ ., data = model_data[, ind_vars], trans='abs')
plot(vc)
threashold <- 0.7
abline(h=1-threashold, col = "red", lty = 2)

reject_vars <- c('SourceRank')
ind_vars <- ind_vars[!(ind_vars%in% reject_vars)]
vc <- varclus(~ ., data = model_data[, ind_vars], trans='abs')
plot(vc)
threashold <- 0.7
abline(h=1-threashold, col = "red", lty = 2)

red <- redun(~., data=model_data[,ind_vars], nk = 0)
red

spearman2 = spearman2(log1p(pageranks) ~ Today_UpDate_Months +  Update_Create_Months + Versions_Count +Dependent_Projects_Count + Repository_Contributors_Count +  Repository_Size, data = model_data, p = 2)
plot(spearman2)

fit <- ols(log1p(pageranks) ~ rcs(Repository_Contributors_Count,5) + rcs(Repository_Size ,3) +  Today_UpDate_Months , data = model_data, x = T, y = T )
fit

num_tier = 1000
val <- validate(fit, B=num_tier)
val

chisq <- anova(fit, test = "Chisq")
chisq

bootcov_obj = bootcov(fit,B=num_tier)
response_curve = Predict(bootcov_obj,
                         Today_UpDate_Months,
                         fun = function (x) return (exp(x)))

plot(response_curve)
response_curve

#Maven1.2
library(rms)
data <- data.frame(read.csv("/Users/kanchanok/Documents/Pattara-sensei/data_to_create_model/Info_Maven1.2_Model(update).csv"))
model_data <- data.frame( data$Versions.Count, data$SourceRank, data$Dependent.Projects.Count,
                          data$Dependent.Repositories.Count, data$Repository.Size, 
                          data$Repository.Stars.Count, data$Repository.Forks.Count, 
                          data$Repository.Open.Issues.Count,
                          data$Repository.Watchers.Count, data$Repository.Contributors.Count,
                          data$pageranks, data$Today_UpDate, data$Update_Create, data$Degree)
names(model_data)[1] <- "Versions_Count"
names(model_data)[2] <- "SourceRank"
names(model_data)[3] <- "Dependent_Projects_Count"
names(model_data)[4] <- "Dependent_Repositories_Count"
names(model_data)[5] <- "Repository_Size"
names(model_data)[6] <- "Repository_Stars_Count"
names(model_data)[7] <- "Repository_Watchers_Count"
names(model_data)[8] <- "Repository_Contributors_Count"
names(model_data)[9] <- "pageranks"
names(model_data)[10] <- "Today_UpDate_Months"
names(model_data)[11] <- "Update_Create_Months"
names(model_data)[12] <- "Degree"


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
              'Repository_Contributors_Count', 'Today_UpDate_Months',
              'Update_Create_Months')
vc <- varclus(~ ., data = model_data[, ind_vars], trans='abs')
plot(vc)
threashold <- 0.7
abline(h=1-threashold, col = "red", lty = 2)


reject_vars <- c('Repository_Watchers_Count' )
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


reject_vars <- c('Repository_Contributors_Count' )
ind_vars <- ind_vars[!(ind_vars%in% reject_vars)]
vc <- varclus(~ ., data = model_data[, ind_vars], trans='abs')
plot(vc)
threashold <- 0.7
abline(h=1-threashold, col = "red", lty = 2)



red <- redun(~., data=model_data[,ind_vars], nk = 0)
red

spearman2 = spearman2(log1p(pageranks) ~ Today_UpDate_Months +  Update_Create_Months + Repository_Size + SourceRank + Versions_Count + Dependent_Projects_Count + Dependent_Repositories_Count, data = model_data, p = 2)
plot(spearman2)

fit <- ols(log1p(pageranks) ~ rcs(Today_UpDate_Months,5) + rcs(Repository_Size ,3) +  Versions_Count, data = model_data, x = T, y = T )
fit

num_tier = 1000
val <- validate(fit, B=num_tier)
val

chisq <- anova(fit, test = "Chisq")
chisq

bootcov_obj = bootcov(fit,B=num_tier)
response_curve = Predict(bootcov_obj,
                         Today_UpDate_Months,
                         fun = function (x) return (exp(x)))

plot(response_curve)
response_curve

#RubyGems1.1
library(rms)
data <- data.frame(read.csv("/Users/kanchanok/Documents/Pattara-sensei/data_to_create_model/Info_RubyGems1.1_Model(update).csv"))
model_data <- data.frame( data$Versions.Count, data$SourceRank, data$Dependent.Projects.Count,
                          data$Dependent.Repositories.Count, data$Repository.Size, 
                          data$Repository.Stars.Count, data$Repository.Forks.Count, 
                          data$Repository.Open.Issues.Count,
                          data$Repository.Watchers.Count, data$Repository.Contributors.Count,
                          data$pageranks, data$Today_UpDate, data$Update_Create, data$Degree)
names(model_data)[1] <- "Versions_Count"
names(model_data)[2] <- "SourceRank"
names(model_data)[3] <- "Dependent_Projects_Count"
names(model_data)[4] <- "Dependent_Repositories_Count"
names(model_data)[5] <- "Repository_Size"
names(model_data)[6] <- "Repository_Stars_Count"
names(model_data)[7] <- "Repository_Forks_Count"
names(model_data)[8] <- "Repository_Open_Issues_Count"
names(model_data)[9] <- "Repository_Watchers_Count"
names(model_data)[10] <- "Repository_Contributors_Count"
names(model_data)[11] <- "pageranks"
names(model_data)[12] <- "Today_UpDate_Months"
names(model_data)[13] <- "Update_Create_Months"
names(model_data)[14] <- "Degree"


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
              'Repository_Contributors_Count', 'Today_UpDate_Months',
              'Update_Create_Months', 'Repository_Forks_Count',
              'Repository_Open_Issues_Count')
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

reject_vars <- c('Dependent_Repositories_Count' )
ind_vars <- ind_vars[!(ind_vars%in% reject_vars)]
vc <- varclus(~ ., data = model_data[, ind_vars], trans='abs')
plot(vc)
threashold <- 0.7
abline(h=1-threashold, col = "red", lty = 2)

reject_vars <- c('Repository_Forks_Count')
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


reject_vars <- c('Repository_Watchers_Count')
ind_vars <- ind_vars[!(ind_vars%in% reject_vars)]
vc <- varclus(~ ., data = model_data[, ind_vars], trans='abs')
plot(vc)
threashold <- 0.7
abline(h=1-threashold, col = "red", lty = 2)


reject_vars <- c('Repository_Open_Issues_Count')
ind_vars <- ind_vars[!(ind_vars%in% reject_vars)]
vc <- varclus(~ ., data = model_data[, ind_vars], trans='abs')
plot(vc)
threashold <- 0.7
abline(h=1-threashold, col = "red", lty = 2)

red <- redun(~., data=model_data[,ind_vars], nk = 0)
red

spearman2 = spearman2(log1p(pageranks) ~ Today_UpDate_Months +  Update_Create_Months + Repository_Size + Versions_Count + Dependent_Projects_Count + Repository_Contributors_Count , data = model_data, p = 2)
plot(spearman2)

fit <- ols(log1p(pageranks) ~ rcs(Today_UpDate_Months,5) + rcs(Dependent_Projects_Count,3) +  Repository_Contributors_Count , data = model_data, x = T, y = T )
fit

num_tier = 1000
val <- validate(fit, B=num_tier)
val

chisq <- anova(fit, test = "Chisq")
chisq

bootcov_obj = bootcov(fit,B=num_tier)
response_curve = Predict(bootcov_obj,
                         Today_UpDate_Months,
                         fun = function (x) return (exp(x)))

plot(response_curve)
response_curve


#RubyGems1.2
library(rms)
data <- data.frame(read.csv("/Users/kanchanok/Documents/Pattara-sensei/data_to_create_model/Info_RubyGems1.2_Model(update).csv"))
model_data <- data.frame( data$Versions.Count, data$SourceRank, data$Dependent.Projects.Count,
                          data$Dependent.Repositories.Count, data$Repository.Size, 
                          data$Repository.Stars.Count, data$Repository.Forks.Count, 
                          data$Repository.Open.Issues.Count,
                          data$Repository.Watchers.Count, data$Repository.Contributors.Count,
                          data$pageranks, data$Today_UpDate, data$Update_Create, data$Degree)
names(model_data)[1] <- "Versions_Count"
names(model_data)[2] <- "SourceRank"
names(model_data)[3] <- "Dependent_Projects_Count"
names(model_data)[4] <- "Dependent_Repositories_Count"
names(model_data)[5] <- "Repository_Size"
names(model_data)[6] <- "Repository_Stars_Count"
names(model_data)[7] <- "Repository_Watchers_Count"
names(model_data)[8] <- "Repository_Contributors_Count"
names(model_data)[9] <- "pageranks"
names(model_data)[10] <- "Today_UpDate_Months"
names(model_data)[11] <- "Update_Create_Months"
names(model_data)[12] <- "Degree"


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
              'Repository_Contributors_Count', 'Today_UpDate_Months',
              'Update_Create_Months')
vc <- varclus(~ ., data = model_data[, ind_vars], trans='abs')
plot(vc)
threashold <- 0.7
abline(h=1-threashold, col = "red", lty = 2)


reject_vars <- c('Repository_Watchers_Count' )
ind_vars <- ind_vars[!(ind_vars%in% reject_vars)]
vc <- varclus(~ ., data = model_data[, ind_vars], trans='abs')
plot(vc)
threashold <- 0.7
abline(h=1-threashold, col = "red", lty = 2)

reject_vars <- c('Dependent_Repositories_Count' )
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

reject_vars <- c('SourceRank' )
ind_vars <- ind_vars[!(ind_vars%in% reject_vars)]
vc <- varclus(~ ., data = model_data[, ind_vars], trans='abs')
plot(vc)
threashold <- 0.7
abline(h=1-threashold, col = "red", lty = 2)


reject_vars <- c('Repository_Contributors_Count' )
ind_vars <- ind_vars[!(ind_vars%in% reject_vars)]
vc <- varclus(~ ., data = model_data[, ind_vars], trans='abs')
plot(vc)
threashold <- 0.7
abline(h=1-threashold, col = "red", lty = 2)

red <- redun(~., data=model_data[,ind_vars], nk = 0)
red

spearman2 = spearman2(log1p(pageranks) ~ Today_UpDate_Months +  Update_Create_Months + Repository_Size + Versions_Count + Dependent_Projects_Count , data = model_data, p = 2)
plot(spearman2)

fit <- ols(log1p(pageranks) ~ rcs(Today_UpDate_Months,5) + rcs(Versions_Count,3) +  Repository_Size + Dependent_Projects_Count, data = model_data, x = T, y = T )
fit

num_tier = 1000
val <- validate(fit, B=num_tier)
val

chisq <- anova(fit, test = "Chisq")
chisq

bootcov_obj = bootcov(fit,B=num_tier)
response_curve = Predict(bootcov_obj,
                         Today_UpDate_Months,
                         fun = function (x) return (exp(x)))

plot(response_curve)
response_curve

