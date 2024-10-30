# README

# Project Overview
This project is a Coffee Shop system built with Ruby on Rails. Users can browse items by categories, add items to their cart, view cart details with taxes and discounts, and place orders. The application also provides a basic customer management system and order history.

# Technologies Used
* Ruby Version: 2.5.0
* Rails Version: 5.2
* Database: PostgreSQL
* Front-end: ERB templates with basic HTML/CSS
* Server: Puma (default for Rails)

# Installation and Setup Instructions

Clone the Repository:
* git clone https://github.com/seemakram15/Coffe-Shop.git
* cd Coffe-Shop

Install Dependencies:
* bundle install

Set up PostgreSQL Database:
* Make sure PostgreSQL is installed and running. Create the database:
* rails db:create
* rails db:migrate


Seed the Database:
* I am creating Categories and a sample user through Seed, so after migrating the database, you need to run it.
* rails db:seed

Start the Rails Server:
* rails server
