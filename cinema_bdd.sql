CREATE DATABASE IF NOT EXISTS bdd_cinema;

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

CREATE TABLE cinemas_admin (
    /*fusion between 'admin and cinemas'*/
    admin_id INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(30) NOT NULL,
    address VARCHAR(70) NOT NULL,
    opening_time TIME NOT NULL,
    closing_time TIME NOT NULL
);


CREATE TABLE users (
    id INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(30) NOT NULL,
    firstname VARCHAR(30),
    lastname VARCHAR(30) NOT NULL,
    age INT(2) NOT NULL,
    is_student BOOLEAN,
    watches INT(11) NOT NULL,
  /*One to Many between users and movies*/
    FOREIGN KEY (watches) REFERENCES movies(id)
);

CREATE TABLE tickets (
    id INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
    date DATE NOT NULL,
    movie_name VARCHAR(30),
    room INT(2) NOT NULL,
    price FLOAT NOT NULL,
    is_used BOOLEAN NOT NULL,
    pays_for INT(11) NOT NULL,
    FOREIGN KEY (pays_for) REFERENCES users(id),
    books_a INT(11) NOT NULL,
    FOREIGN KEY (books_a) REFERENCES sessions(id)
);

CREATE TABLE payments (
    /*associative table between users and tickets*/
    tickets_id INT(11) NOT NULL,
    users_id INT(11) NOT NULL,
    PRIMARY KEY (users_id, tickets_id),
    FOREIGN KEY (users_id) REFERENCES users(id),
    FOREIGN KEY (tickets_id) REFERENCES tickets(id),
    total FLOAT NOT NULL,
    is_onsite BOOLEAN NOT NULL
);