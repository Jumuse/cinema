CREATE DATABASE bdd_cinema;

CREATE TABLE users (
    id INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(30) NOT NULL,
    firstname VARCHAR(30),
    lastname VARCHAR(30),
    age INT(2),
    is_student BOOLEAN
);

CREATE TABLE admins (
    id INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY
);

CREATE TABLE cinemas (
    id INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(30),
    address VARCHAR(70),
    opening_time TIME,
    closing_time TIME
);

CREATE TABLE rooms (
    id INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(30),
    nber_seats INT(3),
    cinema_name VARCHAR(30)
);

CREATE TABLE sessions (
    id INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
    date DATE,
    movie_title VARCHAR(30)
);

CREATE TABLE movies (
    id INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(30),
    year DATE,
    duration TIME,
    director VARCHAR(30),
    main_actor VARCHAR(30),
    description TEXT(500),
    genre VARCHAR(20),
    current_week BOOLEAN
);

CREATE TABLE payments (
    id INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
    total FLOAT,
    is_onsite BOOLEAN
);

CREATE TABLE online_payments (
    id INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
    payment_method VARCHAR(10)
);

CREATE TABLE tickets (
    id INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
    date DATE,
    movie_name VARCHAR(30),
    room INT(2),
    price FLOAT,
    is_used BOOLEAN,
    pays_for INT(11) NOT NULL,
    FOREIGN KEY (pays_for) REFERENCES users(id)

);
