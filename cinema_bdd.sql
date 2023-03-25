CREATE DATABASE IF NOT EXISTS bdd_cinema;

CREATE TABLE users (
    id INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(30) NOT NULL,
    firstname VARCHAR(30),
    lastname VARCHAR(30) NOT NULL,
    age INT(2) NOT NULL,
    is_student BOOLEAN
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
    /*fusion between admin and cinemas + inheritence between users and admin*/
    admin_id INT(11) NOT NULL  PRIMARY KEY,
    FOREIGN KEY(admin_id) REFERENCES users(id),
    name VARCHAR(30) NOT NULL,
    address VARCHAR(70) NOT NULL,
    opening_time TIME NOT NULL,
    closing_time TIME NOT NULL
);

CREATE TABLE rooms (
    id INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(30) NOT NULL,
    nber_seats INT(3) NOT NULL,
    cinema_name VARCHAR(30) NOT NULL,
    /*One to many association between cinemas_admin and rooms*/
    possesses INT(11) NOT NULL,
    FOREIGN KEY(possesses) REFERENCES cinemas_admin(admin_id)
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

/*associative table between customers and tickets*/
CREATE TABLE payments (
    tickets_id INT(11) NOT NULL,
    customers_id INT(11) NOT NULL,
    PRIMARY KEY (customers_id, tickets_id),
    FOREIGN KEY (customers_id) REFERENCES customers(users_id),
    FOREIGN KEY (tickets_id) REFERENCES tickets(id),
    total FLOAT NOT NULL,
    is_onsite BOOLEAN NOT NULL
);

/*associative table between rooms and sessions*/
CREATE TABLE is_displayed (
    rooms_id INT(11) NOT NULL,
    sessions_id INT(11) NOT NULL,
    PRIMARY KEY (sessions_id, rooms_id),
    FOREIGN KEY (rooms_id) REFERENCES rooms(id),
    FOREIGN KEY (sessions_id) REFERENCES sessions(id)
);

/*associative table between movies and sessions*/
CREATE TABLE programmed (
  movies_id INT(11) NOT NULL,
  sessions_id INT(11) NOT NULL,
  PRIMARY KEY (sessions_id, movies_id),
  FOREIGN KEY (movies_id) REFERENCES movies(id),
  FOREIGN KEY (sessions_id) REFERENCES sessions(id)
  );

/*associative table between movies and admin*/
CREATE TABLE changes_to_movies (
   movies_id INT(11) NOT NULL,
   admin_id INT(11) NOT NULL,
   PRIMARY KEY (movies_id, admin_id),
   FOREIGN KEY (movies_id) REFERENCES movies(id),
   FOREIGN KEY (admin_id) REFERENCES cinemas_admin(admin_id)
);