library(rms)
data <- data.frame(read.csv("/Users/kanchanok/Documents/Pattara-sensei/data_to_create_model/Info_PyPI1.1_Model(update).csv"))
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

budget =  floor( model_data$Degree / 15)
budget

library(moments)
skewness(model_data$Degree)
kurtosis(model_data$Degree)

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


reject_vars <- c('Repository_Forks_Count')
ind_vars <- ind_vars[!(ind_vars%in% reject_vars)]
vc <- varclus(~ ., data = model_data[, ind_vars], trans='abs')
plot(vc)
threashold <- 0.7
abline(h=1-threashold, col = "red", lty = 2)

reject_vars <- c('Dependent_Projects_Count' )
ind_vars <- ind_vars[!(ind_vars%in% reject_vars)]
vc <- varclus(~ ., data = model_data[, ind_vars], trans='abs')
plot(vc)
threashold <- 0.7
abline(h=1-threashold, col = "red", lty = 2)

reject_vars <- c('SourceRank','Repository_Watchers_Count' )
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

reject_vars <- c('Dependent_Repositories_Count' )
ind_vars <- ind_vars[!(ind_vars%in% reject_vars)]
vc <- varclus(~ ., data = model_data[, ind_vars], trans='abs')
plot(vc)
threashold <- 0.7
abline(h=1-threashold, col = "red", lty = 2)

reject_vars <- c('Versions_Count' )
ind_vars <- ind_vars[!(ind_vars%in% reject_vars)]
vc <- varclus(~ ., data = model_data[, ind_vars], trans='abs')
plot(vc)
threashold <- 0.7
abline(h=1-threashold, col = "red", lty = 2)



red <- redun(~., data=model_data[,ind_vars], nk = 0)
red

spearman2 = spearman2(log1p(Degree) ~ Today_UpDate_Months +  Update_Create_Months + Repository_Size + Repository_Contributors_Count , data = model_data, p = 2)
plot(spearman2)

fit <- ols(log1p(Degree) ~ rcs(Repository_Contributors_Count,5) + rcs(Repository_Size,3) + Today_UpDate_Months, data = model_data, x = T, y = T )
fit

num_tier = 1000
val <- validate(fit, B=num_tier)
val

chisq <- anova(fit, test = "Chisq", tol=1e-13)
chisq

bootcov_obj = bootcov(fit,B=num_tier)
response_curve = Predict(bootcov_obj,
                         Repository_Contributors_Count,
                         fun = function (x) return (exp(x)))

plot(response_curve)
response_curve