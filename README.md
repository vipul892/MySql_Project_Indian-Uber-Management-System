🚖 **Indian Uber Management System (Database Project)** <br>
📌 **Project Overview** <br>

The Indian Uber Management System is a relational database project designed to manage ride-booking operations similar to Uber in India. The system handles users, drivers, vehicles, trips, payments, reviews, and emergency contacts.

**This project focuses on:**

Database design (ER Model)

Table relationships (Primary & Foreign Keys)

Real-world ride booking workflow

Payment tracking & transaction status

Driver rating & trip feedback system

🏗️ **Database Architecture**

The system consists of the following main entities:

1️⃣ **Users**

Stores passenger information.

user_id (Primary Key)

full_name

email

phone

wallet_balance

city

created_at

2️⃣ **Drivers**

Stores driver details.

driver_id (Primary Key)

full_name

aadhar_no

license_no

rating

is_active

joined_at

3️⃣ **Vehicles**

Each driver is assigned a vehicle.

vehicle_id (Primary Key)

driver_id (Foreign Key)

model_name

plate_no

category (Mini, Sedan, SUV, etc.)

4️⃣ **Trips**

Core table that manages ride bookings.

trip_id (Primary Key)

user_id (Foreign Key)

driver_id (Foreign Key)

pickup_loc

dropoff_loc

distance_km

fare_amount

status (Booked, Ongoing, Completed, Cancelled)

booking_time

5️⃣ **Payments**

Stores trip payment details.

payment_id (Primary Key)

trip_id (Foreign Key)

payment_method (UPI, Card, Cash, Wallet)

transaction_status (Success, Failed, Pending)

transaction_id

amount_paid

6️⃣ **Reviews**

Users can rate completed trips.

review_id (Primary Key)

trip_id (Foreign Key)

rating

feedback

7️⃣ Emergency Contacts

Stores emergency contact information for users.

contact_id (Primary Key)

user_id (Foreign Key)

contact_name

contact_phone

🔗 Entity Relationships

One User → Many Trips

One Driver → Many Trips

One Driver → One Vehicle

One Trip → One Payment

One Trip → One Review

One User → Many Emergency Contacts

⚙️ Key Features

✔ User registration & wallet balance management
✔ Driver onboarding with license & Aadhar verification
✔ Trip booking with pickup & drop locations
✔ Distance-based fare calculation
✔ Multiple payment methods (UPI, Card, Wallet, Cash)
✔ Driver rating system
✔ Trip status tracking
✔ Emergency contact support
✔ Transaction status monitoring

📊 Business Logic Implemented

Drivers must be active to accept trips

Fare calculated based on distance_km

Review allowed only after trip completion

Payment linked strictly to completed trips

Wallet balance deducted automatically (if wallet used)

🛠️ Technologies Used

MySQL

SQL (DDL & DML)

ER Modeling

Relational Database Concepts

🧠 Sample Use Case Flow

User registers in system

Driver registers and gets vehicle assigned

User books a trip

Driver accepts trip

Trip completes

Payment processed

User gives rating & review

📈 Future Enhancements

Surge pricing implementation

Real-time driver tracking

Ride scheduling feature

Admin dashboard

Driver incentive system

Fraud detection module

📷 ER Diagram

(Attach your ER diagram image here)

🎯 Project Objective

To design a scalable and normalized relational database for a ride-booking platform in India that efficiently manages users, drivers, trips, and payments while maintaining data integrity and relationships.

📌 Author

Vipul Alsundkar
Software Testing Engineer | Data & BI Enthusiast
