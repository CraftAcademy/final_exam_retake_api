# KCSC API challenge

This is the API application that powers the Service Search Client for Kensington & Chelsea Social Council Self Care Service. 

The application is buggy and there are failing tests. Your job is to: 

1. fix the test suite/implementation and go all green on the tests and remove the warnings (if there are any)
2. set up and configure Continious Integration
3. deploy the application to Heroku

## Install instructions

This is for the most part a regular Rails app. So follow the ordinary steps to install it on your local host.

The Master key for this application will be provided by the exam facilitator. 

There is, however one part of the insallation that is a bit tricky. It makes use of Elasticsearch. In order to be able to run search functionality in test end development environments, you need to install it on your computer.

OSX: https://www.elastic.co/guide/en/elasticsearch/reference/current/brew.html

Ubuntu: https://www.elastic.co/guide/en/elasticsearch/reference/current/deb.html


## Endpoints

Collection of available services
```
GET /api/services
```

Search interface
```
POST /api/search?q=<search term>
```
