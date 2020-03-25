# RidesApp

Is a ride-hailing service, developed in Ruby with Sinatra. For storage it's includes files configuration to access a relational database in Postgresql and Sequel as ORM.

As any ride service you can request a ride and perform some additonal functions, like create monetary transaction to pay for a ride, add payment source via an external plattform [WOMPI](https://docs.wompi.co/docs/en-us/inicio-rapido).

let’s see more detail in next sections.

## Getting Started

According to general purpose you need to configure and follows next steps

### Configuration and Prerequisites

- Needs Ruby 2.7 version
- Postgres instalation --actual version 10
- Create an .env file that includes

   ```
   DATABASE_URL=postgres://host/database_name?user=user&password=password
   ```

### Instalation

  - Clone project from with ssh git@github.com:dianayf/ridesapp.git
  - Due, we use postgres adapter, you need to create first database before run project
  - Install bundler gem
  - Run bundle install
  - Run migrations bundle exec rake db:migrate
  - Populate database with seed task, run bundle exec rake db:seed
 

  - Locally you can set enviroment with dotenv gem in that case uses next command:
     ```
    dotenv -f ".env" rackup config.ru
     ```
### Run app
  You can specify port to run project in command, Sinatra uses by default by port 9292, so run next command and check your localhost: 
   ```
   bundle exec rackup -p 9292 config.ru
   ```
   Check localhost:9292 and server should be already up!

### WOMPI Configuration

The following endpoints require that you previous create a [WOMPI](https://docs.wompi.co/docs/en-us/inicio-rapido) account and add to your .env file next variables.

- Notes:

- Sandbox mode should be activate to avoid real money transactions, for current purpose this app uses WOMPI API in that mode. 
- Any money transaction by default uses credit card as payment method and ridesApp set installments number to 2.
- RidesApp don't storage any sensitive data as credit card information, so by default it's uses a tokenized card previouslly as you see in "TOKENIZE_CARD" variable.
   ```
   WOMPI_PUBLIC_KEY=public_key
   WOMPI_PRIVATE_KEY=priv_key
   WOMPI_BASE_URL=https://sandbox.wompi.co/v1
   TOKENIZE_CARD=tok_test_1430_A716Efe5D9DEDf2De6906212c08e73e0
   ```
   
### Available Endpoints

RidersApp know two types of entities, Rider entity and Driver. As one of them you can perfom next request:


#### As a Rider

**1. Create  payment methods**

- Path:  /riders/payment_sources/
- Method: POST
- Params: 
  ```
   {
	"rider_id": 1
   }
  ```
  
 - Response: 
   ```
   {
    "message": "payment source created sucessfully",
    "data": {
      "id": 5,
      "token": "cart_token",
      "reference": "371",
      "rider_id": 1
     }
    }
   ```
  
**2. Request a Ride**

  - Path:  /riders/rides/
  - Method: POST
  - Params: 
 
    ```
     {
 	     "rider_id": 1,
	     "current_location":
         {
           "latitude": "4.66888",
	         "longitude": "-74.092024"
         },
	     "target_location":
         { 
           "latitude": "4.625294",
	         "longitude": "-74.065400"
         }
     }
    ```
 - Response: 
   ```
   {
    "message": "payment source created sucessfully",
    "data": {
      "id": 5,
      "token": "cart_token",
      "reference": "371",
      "rider_id": 1
     }
   }
   ```
#### As a Driver

**1. Finish a Ride**

- Path:  /drivers/rides/:ride_id
- Method: PUT
- Params: 
  ```
  {
	"rider_id": 1,
	"current_location:
    {
      "latitude": "4.66888",
	    "longitude": "-74.092024"
    },
	"driver_id": 7
  }
  ```
  
 - Response: 
   ```
   {
     "message": "ride finished successfully",
      "data": {
        "id": 2,
        "status": "finished",
        "start_time": "2020-03-24 01:53:26 -0500",
        "ends_time": "2020-03-24 21:06:49 -0500",
        "current_latitude": "4.66888",
        "current_longitude": "-74.092024",
        "target_latitude": "4.625294",
        "target_longitude": "-74.065400",
        "amount": 23410000,
        "driver_id": 7,
        "rider_id": 1
      }
    }
    ```

### Run Test

Test are configurate with Rspec, please add your .env_test filet with database information. 

- First create database
- Run migrations dotenv -f ".env_test" rake db:migrate
- Run Test with:
  ```
    dotenv -f ".env_test" bundle exec rspect spec/
  ```
