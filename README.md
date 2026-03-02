Indian Uber Management System
Relational Database Project (MySQL)
📌 Project Overview

The Indian Uber Management System is a relational database project designed to simulate a real-world ride-booking platform like Uber in India.

This system efficiently manages:

👤 Users (Passengers)

🚗 Drivers

🚙 Vehicles

🛣️ Trips

💳 Payments

⭐ Reviews

🚨 Emergency Contacts

The project focuses on database normalization, entity relationships, and real-world ride-booking workflow implementation.

🏗️ Database Architecture

The system consists of 7 main tables with properly defined Primary Keys and Foreign Key relationships.

1️⃣ #**Users Table**#

Stores passenger details.

<h2>Users Table</h2>

<table border="1" cellpadding="10" cellspacing="0">
    <tr>
        <th>Column Name</th>
        <th>Data Type</th>
        <th>Description</th>
    </tr>
    <tr>
        <td>user_id</td>
        <td>INT (PK)</td>
        <td>Unique User ID</td>
    </tr>
    <tr>
        <td>full_name</td>
        <td>VARCHAR(100)</td>
        <td>User Full Name</td>
    </tr>
    <tr>
        <td>email</td>
        <td>VARCHAR(100)</td>
        <td>User Email Address</td>
    </tr>
    <tr>
        <td>phone</td>
        <td>VARCHAR(15)</td>
        <td>User Mobile Number</td>
    </tr>
    <tr>
        <td>wallet_balance</td>
        <td>DECIMAL(10,2)</td>
        <td>Available Wallet Balance</td>
    </tr>
    <tr>
        <td>city</td>
        <td>ENUM</td>
        <td>User City</td>
    </tr>
    <tr>
        <td>created_at</td>
        <td>TIMESTAMP</td>
        <td>Account Creation Time</td>
    </tr>
</table>
2️⃣ Drivers Table

Stores driver registration and verification details.

Column Name	Data Type	Description
driver_id	INT (PK)	Unique driver ID
full_name	VARCHAR	Driver name
aadhar_no	VARCHAR	Aadhaar number
license_no	VARCHAR	Driving license
rating	DECIMAL(3,2)	Driver rating
is_active	TINYINT(1)	Active status
joined_at	DATE	Joining date
3️⃣ Vehicles Table

Each driver is assigned one vehicle.

Column Name	Data Type	Description
vehicle_id	INT (PK)	Unique vehicle ID
driver_id	INT (FK)	Linked driver
model_name	VARCHAR	Vehicle model
plate_no	VARCHAR	Registration number
category	ENUM	Mini / Sedan / SUV
4️⃣ Trips Table (Core Table)

Manages ride bookings.

Column Name	Data Type	Description
trip_id	INT (PK)	Unique trip ID
user_id	INT (FK)	Passenger
driver_id	INT (FK)	Assigned driver
pickup_loc	VARCHAR	Pickup location
dropoff_loc	VARCHAR	Drop location
distance_km	DECIMAL(5,2)	Distance
fare_amount	DECIMAL(10,2)	Total fare
status	ENUM	Booked / Ongoing / Completed / Cancelled
booking_time	DATETIME	Trip booking time
5️⃣ Payments Table

Stores transaction details.

Column Name	Data Type	Description
payment_id	INT (PK)	Payment ID
trip_id	INT (FK)	Linked trip
payment_method	ENUM	UPI / Card / Cash / Wallet
transaction_status	ENUM	Success / Failed / Pending
transaction_id	VARCHAR	Payment reference
amount_paid	DECIMAL(10,2)	Paid amount
6️⃣ Reviews Table

Stores user ratings and feedback.

Column Name	Data Type	Description
review_id	INT (PK)	Review ID
trip_id	INT (FK)	Linked trip
rating	INT	Rating (1–5)
feedback	TEXT	User feedback
7️⃣ Emergency Contacts Table

Stores emergency contact details for users.

Column Name	Data Type	Description
contact_id	INT (PK)	Contact ID
user_id	INT (FK)	Linked user
contact_name	VARCHAR	Emergency contact name
contact_phone	VARCHAR	Contact number
🔗 Entity Relationships

One User ➝ Many Trips

One Driver ➝ Many Trips

One Driver ➝ One Vehicle

One Trip ➝ One Payment

One Trip ➝ One Review

One User ➝ Many Emergency Contacts

⚙️ Key Features

✔ User registration & wallet management
✔ Driver onboarding with Aadhaar & License verification
✔ Vehicle assignment to drivers
✔ Ride booking system
✔ Distance-based fare calculation
✔ Multiple payment options (UPI, Card, Wallet, Cash)
✔ Trip status tracking
✔ Driver rating & feedback system
✔ Emergency contact support
✔ Transaction monitoring

📊 Business Rules Implemented

Only active drivers can accept trips

Payment allowed only for completed trips

Reviews can be submitted only after trip completion

Wallet balance auto-deducted when wallet payment selected

One driver is assigned only one vehicle

🛠️ Technologies Used

MySQL

SQL (DDL & DML)

ER Modeling

Database Normalization

Relational Database Concepts

🧠 System Workflow

User registers

Driver registers & vehicle assigned

User books a ride

Driver accepts trip

Trip gets completed

Payment processed

User submits rating & review

📈 Future Enhancements

Surge pricing algorithm

Real-time GPS tracking

Ride scheduling system

Admin dashboard

Driver incentive module

Fraud detection system

📷 ER Diagram

(Add your ER diagram image here)

🎯 Project Objective

To design and implement a normalized and scalable relational database system for a ride-booking platform in India that ensures data integrity, efficient relationships, and smooth ride lifecycle management.

👨‍💻 Author

Vipul Alsundkar
Software Testing Engineer | Data & BI Enthusiast
