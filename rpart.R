install.packages("rpart")
require(rpart)

inputData <- read.csv("UCIDataNorm.csv")

# train <- as.data.frame(split(data, cumsum(1:nrow(data) %in% 15121)))

smp_size <- 15121

## set the seed to make your partition reproductible
set.seed(123)
train_ind <- sample(seq_len(nrow(inputData)), size = smp_size)

train <- inputData[train_ind, ]
test <- inputData[-train_ind, ]

#attributes <- names(inputData[,-13])
rpart.model <- rpart(as.character(Cover_Type) ~ Elevation + Aspect + Slope + Horizontal_Distance_To_Hydrology + Vertical_Distance_To_Hydrology + Horizontal_Distance_To_Roadways + Hillshade_9am + Hillshade_Noon + Hillshade_3pm + Horizontal_Distance_To_Fire_Points + Soil_Type + Wilderness_Area, data = train)
rpart.pred  <- predict(rpart.model, test)


result.class <- colnames(rpart.pred)[apply(rpart.pred,1,which.max)]

error <- mean(result.class != test[,13])
#printcp