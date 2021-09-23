##########
## KPOP ##
##########

## Train neural net with simulated data


library(keras)


#install_keras() #Requires Anaconda and Python 3.x!!!


#Define training and testing datasets
set.seed(44)
inTraining <- sample(1:nrow(sim_subgroup_shuffled), round(nrow(sim_subgroup_shuffled)*.75))

#Data as matrices
x_train <- sim_subgroup_shuffled[inTraining, (nlevels(sim_subgroup$kpop)+1):ncol(sim_subgroup_shuffled)]
x_test <- sim_subgroup_shuffled[-inTraining, (nlevels(sim_subgroup$kpop)+1):ncol(sim_subgroup_shuffled)]

y_train <- sim_subgroup_shuffled[inTraining, 1:nlevels(sim_subgroup$kpop)]
y_test <- sim_subgroup_shuffled[-inTraining, 1:nlevels(sim_subgroup$kpop)]


#Define model
input_shape <- ncol(x_train)
output_units <- ncol(y_train)

model <- keras_model_sequential()

model %>%
  layer_dense(units = 64, activation = "relu", input_shape = input_shape,
              kernel_regularizer = regularizer_l2(l = 0.001)) %>%
  layer_dropout(rate = 0.5) %>%
  layer_dense(units = 32, activation = "relu",
              kernel_regularizer = regularizer_l2(l = 0.001)) %>%
  layer_dropout(rate = 0.5) %>%
  layer_dense(units = output_units, activation="softmax")

#Compile model
model %>% compile(
  loss = 'categorical_crossentropy',
  #optimizer = optimizer_sgd(lr=.01, momentum=.95, decay=0),
  #optimizer = optimizer_rmsprop(),
  optimizer = optimizer_adam(),
  metrics = c('accuracy')
)

#Train model
history <- model %>% fit(
  x_train, y_train, 
  epochs = 20, batch_size = 128, 
  validation_split = 0.2
)

#Evaluate model
model %>% evaluate(x_test, y_test)

#Save model
model %>% save_model_hdf5("subgroup_model.h5")
