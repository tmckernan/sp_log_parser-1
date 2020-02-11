# Description
A ruby script that receives a log file as an argument

And returns the following:

 - list of webpages with most page views ordered from most pages views to less page views

    ```
    /home 90 visits 
    /index 80 visits etc...
    ```
 
 - list of webpages with most unique page views also ordered

    ```
    /about/2 8 unique views 
    /index 5 unique views etc...
    ```
   
# Approach
The main idea of the application is to parse the logfile line by line and populate a requests map.
The requests map is used for further calculations of all visits and unique visits.
At the end calculated data is printed to the STDOUT within a provided format.

1. A line of the logfile is passed to the `Request` object, it performs data validation 
2. The `Request` object is saved to the `RequestsMap`

    The RequestsMap has the following structure  
    `{ <endpoint string> => { <ip string> => <visits number> } }`

3. Counters calculate corresponding vists and create an Array of `EndpointVisits` objects

    `EndpointVisits` object is a simple structure that stores endpoint string and number of visits
    
4. `VisitsSorter` sorts the arrays of `EndpointVisits`
5. `STDOUTReporter` prints the sorted arrays within the provided format

# Usage
## Install
  1. Clone the repository
  2. run `bundle install` to install gems

## Run
Run the script by passing in the name of the server logs you would like to parse

  `$ ruby main.rb webserver.log`

## Run tests
Go to the app directory and type the following:

- To run specs

  `$ bundle exec rspec`

- To run rubocop 
  
  `$ bundle exec rubocop .`
