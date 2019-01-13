	Intro

	What is this repository for?

We're going to use historical information about bank - marketing to build a model, which is going to give us the ability to predict future results regarding balance for the bank clients.

In R language I can deal with missing values; working with categorical variables; robust models (which deal with outliers); 

Basic concepts of machine learning

I used a random forest, an algorithm which grows multiple decision trees from the features presented to it, and has each individual tree "vote" on the outcome for each new input vector (or in other words, new match to predict). It's fast, fairly accurate, and it gives an unbiased estimate of the generalization error, which makes cross-validation unnecessary for this particular algorithm.

How the data is prepared (the most important step)

In many machine learning data preparation is a very important part and it will cover:

    Get the raw data
    Data clean-up: this will mean removing orphan values, aberrations or other anomalies
    Data grouping: taking many data points and transforming into an aggregated data point
    Data enhancing: adding other aspects of the data derived from own, or from external sources
    Splitting the data in train and test data
    Split each of the train and test data into inputs and outputs.
    Typically, a problem will have many inputs and a few outputs
    Rescale the data so it’s between 0 and 1 (this will help the network removing high/low biases)
    Getting the raw data
    Data clean-up
    The empty values in the data frame are dropped
    Data grouping and data enhancing
    Splitting the data in train and test data
    Split each of the train and test data into inputs and outputs.

The Data

We're going to use a dataset containing more than forty-thousand clients of the bank. The dataset is available as CSV files.

Getting the raw data

In our case getting data for a CSV file in R language is really easy with this lines of code:

if(!file.exists(bm)){tryCatch(bm)}

if(file.exists(bm)) bm_original <- read.csv(bm, header = TRUE, stringsAsFactors = FALSE, sep = ";")

Data cleanup

First let's perform some basic cleanup on the dataset and eliminate any duplicates that may exist in the dataset, generate an id column for future use (joins etc).

Data Exploration and Visualisation

The best way to understand a dataset is to turn it into multiple pictures.
Fortunately, R has some useful tools in this regard - and a lot of them come with the very popular ggplot2 package

Data grouping & data enhancing

Now, we can create some aditional features about the education of the clients eliminate the clients with unknown education from the dataset. 

Until this point we've only looked at individual client. However, what we really need is to look at each client's performance over its history.

When we build our predictive model, we'd like to supply it with as many features about each client to be involved . For that, we need to have a bank - performance dataset with historical data.

Data cleanup again.

Transform old job names into new ones( with CL).

Data visualisation again

  what is the occurence frequency for martital statut?
  distribution of balance per customer
  distribution of customer age
  
Data clean up again

I'd like to get rid of outliers - values which are far away at the end of the spectrum of possible values for this variable. The reason is that outliers can drastically change the results of the data analysis and statistical modeling. Outliers increase the error variance, reduce the power of statistical tests, and ultimately they can bias or influence estimates.

  get rid of all the outliers by selecting the balance to [-8000, 8000]
  job and adjustment coefficients for them
  set missing values to 1
 
 Data grouping & data enhancing 
  
  Feature Engineering

Now, let's calculate some lag features for the clients of the bank.

We'll look at the previous N clients, and we'll calculate the percentage of bal, dtion, edumar for those past N clients.

Because data in the past might influence our prediction, we need for each of the dataframe rows to add columns reference to the past rows. This is because each of the row will serve as a training point, and if we want the prediction to take into account previous datapoints that's exactly what we should do add more columns.

Data cleanup (again) 
Training our first model
It is going to describe the features we want to use and the outcome we're trying to predict.

Splitting the data in train and test data 

We're going to split our bank_features into a training and a testing dataset. We're going to be using the training data to fit our model, then we're going to use the testing data to evaluate its accuracy.

Model Evaluation

We can now expose our trained model to the test dataset, and calculate performance metrics.


Other parameters here:

importance - This is the extractor function for variable importance measures as produced by randomForest.
varImpPlot - Dotchart of variable importance as measured by a Random Forest

predict.randomForest - Prediction of test data using random forest.

Mean Absolute Error (MAE)- MAE measures the average magnitude of the errors in a set of predictions, without considering their direction. It’s the average over the test sample of the absolute differences between prediction and actual observation where all individual differences have equal weight.

Root mean squared error (RMSE) - RMSE is a quadratic scoring rule that also measures the average magnitude of the error. It’s the square root of the average of squared differences between prediction and actual observation.


  


