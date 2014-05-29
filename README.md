#MyCookbook

##General Assembly WDI May 30, Project 1

##Overview

MyCookbook is a web application that allows users to compile a "Cookbook" using recipes gathered through either (a) form-based submission (for family or personal recipes), or (b) a search of hundreds of thousands of recipes using BigOven's API. Users also can use the Grocery List feature to compile a shopping list using the ingredients from selected recipes in their Cookbook.

MyCookbook was developed for a project for the April 2014 Web Development Immersive course at General Assembly. It was developed over a week-long sprint to model the agile software development process.

##Technologies Used
* Ruby 2.1.1
* Rails 4.1.1
* PostgreSQL Database
* Authentication & Authorization from scratch using (http://bcrypt-ruby.rubyforge.org/ "bcrypt-ruby")
* (http://api.bigoven.com/ "BigOven API") & (https://github.com/jnunemaker/httparty "HTTParty")

##User Stories Completed
* User can only search recipes without being logged in or having account
* User can sign up for an account with an email address and password
* User can login and logout of their account
* User can perform basic recipe search by entering search terms
* User can see list of search results and link to page for specific search result
* User can elect to save specific search result to their Cookbook
* User can enter their own recipe and add it to their Cookbook
* User can see a list of the recipes saved to their Cookbook
* User can edit all recipes in their Cookbook, regardless of origin
* User can delete recipes from their Cookbook
* User can select recipes to add to their Grocery List


##Production
Explore MyCookbook for yourself on (http://warm-lowlands-3385.herokuapp.com)

##Backlog
A full list of user stories can be found by looking at (https://www.pivotaltracker.com/s/projects/1086748 "Pivotal Tracker")
