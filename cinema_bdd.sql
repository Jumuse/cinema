CREATE DATABASE IF NOT EXISTS bdd_cinema;

CREATE TABLE users (
    id CHAR(36) NOT NULL PRIMARY KEY,
    email VARCHAR(40) NOT NULL,
    firstname VARCHAR(30),
    lastname VARCHAR(30) NOT NULL,
    age INT(2) NOT NULL,
    is_student BOOLEAN
);

CREATE TABLE sessions (
    id INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
    date_time DATE NOT NULL
);


CREATE TABLE movies (
    id INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(60) NOT NULL,
    date DATE NOT NULL,
    duration INT(2) NOT NULL,
    director VARCHAR(30) NOT NULL,
    main_actor VARCHAR(30) NOT NULL,
    description TEXT(100) NOT NULL,
    genre VARCHAR(50) NOT NULL,
    current_week BOOLEAN NOT NULL
);

CREATE TABLE customers (
    users_id CHAR(36) NOT NULL PRIMARY KEY,
    /*One to Many between customers and movies*/
    watches INT(11) NOT NULL,
    FOREIGN KEY (watches) REFERENCES movies(id),
    /*inheritance between users and customers*/
    FOREIGN KEY(users_id) REFERENCES users(id)
);

CREATE TABLE cinemas_admin (
    /*fusion between admin and cinemas + inheritance between users and admin*/
    admin_id CHAR(36) NOT NULL  PRIMARY KEY,
    FOREIGN KEY(admin_id) REFERENCES users(id),
    name VARCHAR(50) NOT NULL,
    address VARCHAR(70) NOT NULL,
    opening_time TIME NOT NULL,
    closing_time TIME NOT NULL
);

CREATE TABLE rooms (
    id INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(30) NOT NULL,
    nber_seats INT(3) NOT NULL,
    /*One to many association between cinemas_admin and rooms*/
    possesses CHAR(36) NOT NULL,
    FOREIGN KEY(possesses) REFERENCES cinemas_admin(admin_id)
);

CREATE TABLE tickets (
    id INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
    date DATE NOT NULL,
    price FLOAT NOT NULL,
    is_used BOOLEAN NOT NULL,
    /*One to Many association between customers and tickets*/
    pays_for CHAR(36) NOT NULL,
    FOREIGN KEY (pays_for) REFERENCES customers(users_id),
    /*One to Many association between tickets and sessions*/
    books_a INT(11) NOT NULL,
    FOREIGN KEY (books_a) REFERENCES sessions(id)
);

/*associative table between customers and tickets*/
CREATE TABLE payments (
    tickets_id INT(11) NOT NULL,
    customers_id CHAR(36) NOT NULL,
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
   admin_id CHAR(36) NOT NULL,
   PRIMARY KEY (movies_id, admin_id),
   FOREIGN KEY (movies_id) REFERENCES movies(id),
   FOREIGN KEY (admin_id) REFERENCES cinemas_admin(admin_id)
);

/*Index on movies*/
 CREATE INDEX index_movies ON movies (
    title, 
    director,
  	main_actor,
  	date,
  	genre
);

/*Index on users*/
CREATE INDEX index_users ON users (
  email,
  firstname,
  lastname,
  age,
  is_student
);


/*data insertion for users*/
insert into users (id, email, firstname, lastname, age, is_student) values ('25551c9c-4554-4bd6-8437-fe941d93f982', 'ibrandrick0@yellowbook.com', 'Irita', 'Brandrick', 13, false);
insert into users (id, email, firstname, lastname, age, is_student) values ('15f81aa4-0d84-434a-ad5d-3b7ecee5bda8', 'colivier1@reuters.com', 'Cullie', 'Olivier', 56, false);
insert into users (id, email, firstname, lastname, age, is_student) values ('0c50a75e-0df7-40af-a1c9-dd6d2c487eb6', 'dhobbema2@about.me', 'Dolly', 'Hobbema', 97, true);
insert into users (id, email, firstname, lastname, age, is_student) values ('86eb682a-6b4a-42d0-bf50-37557e018c56', 'ffranzschoninger3@yellowpages.com', 'Forest', 'Franz-Schoninger', 65, true);
insert into users (id, email, firstname, lastname, age, is_student) values ('3484230a-f7d7-4f48-8a6c-6b802fc19343', 'mberendsen4@pen.io', 'Michelina', 'Berendsen', 19, false);
insert into users (id, email, firstname, lastname, age, is_student) values ('cda13f42-29d5-49ae-8be3-0864952379a0', 'rstefi5@sfgate.com', 'Ronni', 'Stefi', 67, false);


/*              -----------------------------------------------------------             */
/*data insertion for sessions*/
insert into sessions (id, date_time) values (1, '2022-06-27 17:07:44');
insert into sessions (id, date_time) values (2, '2022-09-30 07:44:09');
insert into sessions (id, date_time) values (3, '2022-10-22 05:53:06');
insert into sessions (id, date_time) values (4, '2023-03-14 16:53:48');
insert into sessions (id, date_time) values (5, '2022-06-24 18:43:03');
insert into sessions (id, date_time) values (6, '2022-04-10 10:22:05');

/*data insertion for movies*/
insert into movies (id, title, date, duration, director, main_actor, description, genre, current_week) values (16, '2 + 2 (Dos más dos)', '2023-01-20', 86, 'Eilis Sprigg', 'Maje Briant', 'Nam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla. Sed vel enim sit amet nunc viverra dapibus. Nulla suscipit ligula in lacus.', 'Comedy', true);
insert into movies (id, title, date, duration, director, main_actor, description, genre, current_week) values (17, 'Secret Admirer', '2022-12-20', 83, 'Rabi Puttock', 'Artemas Barles', 'Cras non velit nec nisi vulputate nonummy. Maecenas tincidunt lacus at velit. Vivamus vel nulla eget eros elementum pellentesque.
Quisque porta volutpat erat. Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla. Nunc purus.
Phasellus in felis. Donec semper sapien a libero. Nam dui.', 'Comedy|Romance', true);
insert into movies (id, title, date, duration, director, main_actor, description, genre, current_week) values (18, 'Headfirst', '2022-11-14', 90, 'Swen Bambery', 'Judah Jurisch', 'Aenean fermentum. Donec ut mauris eget massa tempor convallis. Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh.
Quisque id justo sit amet sapien dignissim vestibulum. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est. Donec odio justo, sollicitudin ut, suscipit a, feugiat et, eros.', 'Drama', true);
insert into movies (id, title, date, duration, director, main_actor, description, genre, current_week) values (19, 'Charming Mass Suicide, A (Hurmaava joukkoitsemurha)', '2022-06-18', 70, 'Lilyan Fosten', 'Nell Dwane', 'Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis. Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci. Mauris lacinia sapien quis libero.
Nullam sit amet turpis elementum ligula vehicula consequat. Morbi a ipsum. Integer a nibh.', 'Comedy', false);
insert into movies (id, title, date, duration, director, main_actor, description, genre, current_week) values (20, 'When in Rome', '2023-01-19', 69, 'Dacey Danslow', 'Garnette Guttridge', 'In sagittis dui vel nisl. Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus.
Suspendisse potenti. In eleifend quam a odio. In hac habitasse platea dictumst.', 'Comedy|Romance', true);
insert into movies (id, title, date, duration, director, main_actor, description, genre, current_week) values (21, 'Things We Do For Love (Kaikella rakkaudella)', '2022-04-06', 80, 'Sonia Deverill', 'Boyce Over', 'In congue. Etiam justo. Etiam pretium iaculis justo.
In hac habitasse platea dictumst. Etiam faucibus cursus urna. Ut tellus.
Nulla ut erat id mauris vulputate elementum. Nullam varius. Nulla facilisi.', 'Drama', false);
insert into movies (id, title, date, duration, director, main_actor, description, genre, current_week) values (22, 'Spaghetti West, The', '2023-01-28', 78, 'Collin Doey', 'Kerwinn Beney', 'Vestibulum ac est lacinia nisi venenatis tristique. Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue. Aliquam erat volutpat.
In congue. Etiam justo. Etiam pretium iaculis justo.', 'Documentary', false);

/*data insertion for cinemas_admin*/
insert into cinemas_admin (admin_id, name, address, opening_time, closing_time) values (1, 'Cruickshank-Runolfsson', '76 Lakeland Drive', '1:52', '12:58');
insert into cinemas_admin (admin_id, name, address, opening_time, closing_time) values (2, 'Littel-Towne', '72665 Bonner Center', '5:42', '16:51');
insert into cinemas_admin (admin_id, name, address, opening_time, closing_time) values (3, 'Runolfsdottir-Graham', '6 Mcguire Terrace', '23:55', '1:53');
insert into cinemas_admin (admin_id, name, address, opening_time, closing_time) values (4, 'Steuber LLC', '897 Anniversary Court', '22:04', '7:49');
insert into cinemas_admin (admin_id, name, address, opening_time, closing_time) values (5, 'Pouros, Cormier and Medhurst', '22 Duke Point', '7:49', '2:29');
insert into cinemas_admin (admin_id, name, address, opening_time, closing_time) values (6, 'Champlin Inc', '1492 Pepper Wood Junction', '20:06', '6:46');

/*data insertion for customers*/
INSERT INTO customers(users_id, watches) VALUES (1, 11);
INSERT INTO customers(users_id, watches) VALUES (2, 20);
INSERT INTO customers(users_id, watches) VALUES (3, 5);
INSERT INTO customers(users_id, watches) VALUES (4, 6);
INSERT INTO customers(users_id, watches) VALUES (5, 20);
INSERT INTO customers(users_id, watches) VALUES (6, 2);

/*data insertion for rooms*/
insert into rooms (id, name, nber_seats, possesses) values (1, 'Jay', 22, 1);
insert into rooms (id, name, nber_seats, possesses) values (2, 'Dunning', 48, 1);
insert into rooms (id, name, nber_seats, possesses) values (3, 'Rowland', 74, 2);
insert into rooms (id, name, nber_seats, possesses) values (4, '5th', 40, 2);
insert into rooms (id, name, nber_seats, possesses) values (5, 'Milwaukee', 14, 3);
insert into rooms (id, name, nber_seats, possesses) values (6, 'Melby', 30, 4);
insert into rooms (id, name, nber_seats, possesses) values (7, 'Vera', 45, 4);
insert into rooms (id, name, nber_seats, possesses) values (8, 'Kingsford', 19, 4);
insert into rooms (id, name, nber_seats, possesses) values (9, '2nd', 93, 5);
insert into rooms (id, name, nber_seats, possesses) values (10, 'Elmside', 32, 5);
insert into rooms (id, name, nber_seats, possesses) values (11, 'Old Shore', 57, 6);
insert into rooms (id, name, nber_seats, possesses) values (12, 'Graceland', 49, 6);

/*data insertion for tickets*/
insert into tickets (id, date, price, is_used, pays_for, books_a) values (1, '2022-05-26 17:14:09', 8.74, true, 1, 1);
insert into tickets (id, date, price, is_used, pays_for, books_a) values (2, '2022-06-28 09:16:38', 8.37, true, 2, 2);
insert into tickets (id, date, price, is_used, pays_for, books_a) values (3, '2023-02-11 22:25:10', 3.27, false, 3, 3);
insert into tickets (id, date, price, is_used, pays_for, books_a) values (4, '2022-10-21 12:07:18', 12.88, true, 4, 4);
insert into tickets (id, date, price, is_used, pays_for, books_a) values (5, '2022-06-08 04:11:34', 15.79, false, 5, 5);
insert into tickets (id, date, price, is_used, pays_for, books_a) values (6, '2022-10-19 08:01:00', 4.42, false, 6, 6);

/*data insertion for payments*/
insert into payments (tickets_id, customers_id, total, is_onsite) values (1, 1, 18.37, false);
insert into payments (tickets_id, customers_id, total, is_onsite) values (2, 2, 7.24, true);
insert into payments (tickets_id, customers_id, total, is_onsite) values (3, 3, 19.48, true);
insert into payments (tickets_id, customers_id, total, is_onsite) values (4, 4, 12.33, true);
insert into payments (tickets_id, customers_id, total, is_onsite) values (5, 5, 2.64, true);

/*data insertion for is_displayed*/
insert into is_displayed (rooms_id, sessions_id) values (1, 1);
insert into is_displayed (rooms_id, sessions_id) values (2, 2);
insert into is_displayed (rooms_id, sessions_id) values (3, 3);
insert into is_displayed (rooms_id, sessions_id) values (4, 4);
insert into is_displayed (rooms_id, sessions_id) values (5, 5);
insert into is_displayed (rooms_id, sessions_id) values (6, 6);
insert into is_displayed (rooms_id, sessions_id) values (7, 7);
insert into is_displayed (rooms_id, sessions_id) values (8, 8);
insert into is_displayed (rooms_id, sessions_id) values (9, 9);
insert into is_displayed (rooms_id, sessions_id) values (10, 10);
insert into is_displayed (rooms_id, sessions_id) values (11, 11);
insert into is_displayed (rooms_id, sessions_id) values (12, 12);

/*data insertion for programmed*/
insert into programmed (movies_id, sessions_id) values (1, 1);
insert into programmed (movies_id, sessions_id) values (2, 2);
insert into programmed (movies_id, sessions_id) values (3, 3);
insert into programmed (movies_id, sessions_id) values (4, 4);
insert into programmed (movies_id, sessions_id) values (5, 5);
insert into programmed (movies_id, sessions_id) values (6, 6);

/*data insertion for changes_to_movies*/
insert into changes_to_movies (movies_id, admin_id) values (1, 1);
insert into changes_to_movies (movies_id, admin_id) values (2, 2);
insert into changes_to_movies (movies_id, admin_id) values (3, 3);
insert into changes_to_movies (movies_id, admin_id) values (4, 4);
insert into changes_to_movies (movies_id, admin_id) values (5, 5);
insert into changes_to_movies (movies_id, admin_id) values (6, 6);

