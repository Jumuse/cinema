CREATE DATABASE IF NOT EXISTS bdd_cinema;

CREATE TABLE users (
    id INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(30) NOT NULL,
    firstname VARCHAR(30),
    lastname VARCHAR(30) NOT NULL,
    age INT(2) NOT NULL,
    is_student BOOLEAN
);

CREATE TABLE rooms (
    id INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(30) NOT NULL,
    nber_seats INT(3) NOT NULL,
    cinema_name VARCHAR(30) NOT NULL
);

CREATE TABLE sessions (
    id INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
    date_time DATE NOT NULL,
    movie_title VARCHAR(30) NOT NULL
);

CREATE TABLE movies (
    id INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(30) NOT NULL,
    year DATE NOT NULL,
    duration TIME NOT NULL,
    director VARCHAR(30) NOT NULL,
    main_actor VARCHAR(30) NOT NULL,
    description TEXT(500) NOT NULL,
    genre VARCHAR(20) NOT NULL,
    current_week BOOLEAN NOT NULL
);

CREATE TABLE customers (
    users_id INT(11) NOT NULL PRIMARY KEY,
    /*One to Many between customers and movies*/
    watches INT(11) NOT NULL,
    FOREIGN KEY (watches) REFERENCES movies(id),
    /*heritance between users and customers*/
    FOREIGN KEY(users_id) REFERENCES users(id)
);

CREATE TABLE cinemas_admin (
    /*fusion between 'admin and cinemas'*/
    admin_id INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(30) NOT NULL,
    address VARCHAR(70) NOT NULL,
    opening_time TIME NOT NULL,
    closing_time TIME NOT NULL
);

CREATE TABLE tickets (
    id INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
    date DATE NOT NULL,
    movie_name VARCHAR(30),
    room INT(2) NOT NULL,
    price FLOAT NOT NULL,
    is_used BOOLEAN NOT NULL,
    /*One to Many association between customers and tickets*/
    pays_for INT(11) NOT NULL,
    FOREIGN KEY (pays_for) REFERENCES customers(users_id),
    /*One to Many association between tickets and sessions*/
    books_a INT(11) NOT NULL,
    FOREIGN KEY (books_a) REFERENCES sessions(id)
);

CREATE TABLE payments (
    /*associative table between customers and tickets*/
    tickets_id INT(11) NOT NULL,
    customers_id INT(11) NOT NULL,
    PRIMARY KEY (customers_id, tickets_id),
    FOREIGN KEY (customers_id) REFERENCES customers(users_id),
    FOREIGN KEY (tickets_id) REFERENCES tickets(id),
    total FLOAT NOT NULL,
    is_onsite BOOLEAN NOT NULL
);
