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

# Usage
## Install
  1. Clone the repository
  2. run `bundle install` to install gems

## Run
Run the script by passing in the name of the server logs you would like to parse

  `$ ruby main.rb webserver.log`

## Run tests
Go to the app directory and type the following:

`$ bundle exec rspec`
