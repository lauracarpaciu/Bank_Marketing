	Intro

	What is this repository for?

We're going to use historical information about bank - marketing to build a model, which is going to give us the ability to predict future results regarding balance for the bank clients.

In R I can deal with missing values; working with categorical variables; robust models (which deal with outliers); 

Basic concepts of machine learning

How the data is prepared (the most important step)
The data processing and neural network technology choice

    I’ve chosen python for the backend because many major innovations in neural networks are found in python. A growing community with a lot of github repositories, tutorials blogs and books are here to help.
    For the data processing part I’ve used PANDAS.
(https://pandas.pydata.org/) Pandas make working with data easy. You can load tables from CSV, Excel, python data structures and reorder them, drop columns, add columns, index by a column and many other transformations.

Neural networks are data structures that resemble brain cells called neurons. Since discovered that a brain has special cells named neurons that communicate with other neurons by electrical impulses through “lines” called axons. If stimulated sufficiently (from many other neurons) the neurons will trigger an electric impulse further away in this “network” stimulating other neurons.
Computer algorithms try to replicate this biological process.
In computer, neural nets each neuron has a “trigger point” where if stimulated over that point it will propagate the stimulation forward, if not it would not. For this, each simulated neuron will have a bias, and each axon a weight. After a random initialization of these values a process called “learning” starts this means in a loop algorithm will do this steps:

    Stimulate the input neurons
    Propagate the signals through the network layers until the output neurons
    Read the output neurons and compare the results with the desired results
    Tweak the axons weights for a better result next time
    Start again until the number of loops has been reached
    One more thing, here well be using a supervised learning method. That means we'll teach the algorithm the inputs and the outputs also, so that given a new set of inputs it can predict the output.

How the data is prepared (the most important step)

In many machine learning and neural network problems data preparation is a very important part and it will cover:

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




