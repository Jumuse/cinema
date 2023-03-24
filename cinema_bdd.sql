CREATE DATABASE bdd_cinema;

CREATE TABLE users (
    id INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(30) NOT NULL,
    firstname VARCHAR(30),
    lastname VARCHAR(30),
    age INT(2),
    is_student BOOL
);

CREATE TABLE admins (
    id INT(11)
);

CREATE TABLE cinemas (
    id INT(11),
    name VARCHAR(30),
    address VARCHAR(70),
    opening_time TIME,
    closing_time TIME
);

CREATE TABLE rooms (
    id INT(11),
    name VARCHAR(30),
    nber_seats INT(3),
    cinema_name VARCHAR(30)
);

CREATE TABLE sessions (
    id INT(11),
    date DATE,
    movie_title VARCHAR(30)
);

CREATE TABLE movies (
    id INT(11),
    title VARCHAR(30),
    year DATE,
    duration TIME,
    director VARCHAR(30),
    main_actor VARCHAR(30),
    description TEXT(500),
    genre VARCHAR(20),
    current_week BOOL
);

CREATE TABLE payments (
    id INT(11),
    total FLOAT,
    is_onsite BOOL
);

CREATE TABLE online_payments (
    id INT(11),
    payment_method VARCHAR(10)
);

CREATE TABLE tickets (
    id INT(11),
    date DATE,
    movie_name VARCHAR(30),
    room INT(2),
    price FLOAT,
    is_used BOOL
);
