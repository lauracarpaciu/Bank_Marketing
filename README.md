	Intro

	What is this repository for?

We're going to use historical information about bank - marketing to build a model, which is going to give us the ability to predict future results regarding balance for the bank clients.

In R language I can deal with missing values; working with categorical variables; robust models (which deal with outliers); 

Basic concepts of machine learning

I used a random forest, an algorithm which grows multiple decision trees from the features presented to it, and has each individual tree "vote" on the outcome for each new input vector (or in other words, new match to predict). It's fast, fairly accurate, and it gives an unbiased estimate of the generalization error, which makes cross-validation unnecessary for this particular algorithm.

How the data is prepared (the most important step)

We're going to use a dataset containing more than forty-thousand clients of the bank. The dataset is available as CSV files.ł

The structure of the project.

Ask an interesting question;

Get the data;

Explore the data:

Visualisation of the data;
   
Data clean up:
   
-  this will mean removing orphan values, aberrations or other anomalies

Data grouping:
     
- taking many data points and transforming into an aggregated data point

Data enhancing:
        
- adding other aspects of the data derived from own, or from external sources

Splitting the data in train and test data:
        
- split each of the train and test data into inputs and outputs. Typically, a problem will have many inputs and a few outputs

Model the data;
            
Model evaluation;

Communicate and visualize the results;

Other parameters here(model evaluation):

Importance : Extract variable importance measure

Mean absolute error: link to: https://en.wikipedia.org/wiki/Mean_absolute_error

Root-mean-square deviation: link to : https://en.wikipedia.org/wiki/Root-mean-square_deviation






  


