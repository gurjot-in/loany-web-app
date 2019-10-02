


# Welcome to Loany .  A web app in Phoenix/Elixir

You will need to setup Phoenix/Elixir in your local machine to run the project

Please follow along for macOS

>   

 - update brew `brew update`
 - install postgres database `brew install postgresql`
 - install elixir lang   `brew install elixir`
 - install hex package manager `mix local.hex`
 - install the phoenix archive `mix archive.install hex phx_new 1.4.10`

You are all set :)

After cloning this repo 

    cd bynk_loany 

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

# Errors

 - for postgres authentication related issues use below solution

    `$ sudo -u postgres psql -c "ALTER USER postgres PASSWORD 'postgres';" `

    ` sudo service postgresql restart `

 - If still not resolved follow [`postgres guide`](https://wiki.postgresql.org/wiki/Detailed_installation_guides)


# Test Cases/Assumptions

 - Even if loan is approved , the same user can request a new application again
 - Loany cannot access DB in the algo , but if cache hit is missed it will fetch data from DB and populate cache
 - Loan amount should not be greater than SEK 999,999,999
 - Phone number is assumed to have max length of 9 digits
 
