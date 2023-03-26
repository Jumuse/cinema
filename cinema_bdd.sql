CREATE DATABASE IF NOT EXISTS theater SET utf8mb4 COLLATE utf8mb4_general_ci;

CREATE TABLE users (
    id CHAR(36) NOT NULL PRIMARY KEY,
    email VARCHAR(40) NOT NULL,
    password BINARY(60) NOT NULL,
    firstname VARCHAR(30),
    lastname VARCHAR(30) NOT NULL,
    age INT(2) NOT NULL,
  	is_admin BOOLEAN,
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
insert into users (id, email, password, firstname, lastname, age, is_admin, is_student) values ('25551c9c-4554-4bd6-8437-fe941d93f982', 'ibrandrick0@yellowbook.com', '$2y$10$cevT3qzIRNWKPTWTOeemteuLeCTdz6IdlodI3cCUnd18zASF.jKRq', 'Irita', 'Brandrick', 13, true, false);
insert into users (id, email, password, firstname, lastname, age, is_admin, is_student) values ('15f81aa4-0d84-434a-ad5d-3b7ecee5bda8', 'colivier1@reuters.com', '$2y$10$TUyXV7ss4TxCQjoLHv8sZOLjc8PHYd8d4MsgT56jEOkvm5UOeF3VS', 'Cullie', 'Olivier', 56, true, false);
insert into users (id, email, password, firstname, lastname, age, is_admin, is_student) values ('0c50a75e-0df7-40af-a1c9-dd6d2c487eb6', 'dhobbema2@about.me', '$2y$10$9I7KficnaWXNA1.RW6MKPOWUNX5XJ7AfZ6OzGQZQvZMOf37ezdANe', 'Dolly', 'Hobbema', 97, true, true);
insert into users (id, email, password, firstname, lastname, age, is_admin, is_student) values ('86eb682a-6b4a-42d0-bf50-37557e018c56', 'ffranzschoninger3@yellowpages.com', '$2y$10$r4oDcK.2zj6M5yH6vl2tDemeJnnx8mjBUGdCn71pDZz8KloLDReye', 'Forest', 'Franz-Schoninger', 65, true, true);
insert into users (id, email, password, firstname, lastname, age, is_admin, is_student) values ('3484230a-f7d7-4f48-8a6c-6b802fc19343', 'mberendsen4@pen.io', '$2y$10$JcYzKRVzoIo/eXm/wZtXhu.5piUcp96g8.gb96jHAKM11F8YjX84W', 'Michelina', 'Berendsen', 19, true, false);
insert into users (id, email, password, firstname, lastname, age, is_admin, is_student) values ('cda13f42-29d5-49ae-8be3-0864952379a0', 'rstefi5@sfgate.com', '$2y$10$dnxt7thcDAEeVBEouvG6fO58xbErQRqOApX5aorst0SCVwuhXRtlK', 'Ronni', 'Stefi', 67, true, false);
insert into users (id, email, password, firstname, lastname, age, is_admin, is_student) values ('1b96980c-048e-406f-a573-45fd15d9066a ', 'kdory0@alibaba.com', '$2y$10$hE6OWmLlQtI1KH10Qzgr2O8cOYmF90LmZDFCgsbFZrhpbNeqRzeOu', 'Kenneth', 'Dory', 75, false, false);
insert into users (id, email, password, firstname, lastname, age, is_admin, is_student) values ('f57402b8-acb7-4976-af9c-93ee6e33184f', 'ccattermoul1@geocities.com', '$2y$10$IWlPZYIZO0PzPw2u8wQtB.2S46kdhTSXJzzau.WjUHXZxS1wSGVGK', 'Christopher', 'Cattermoul', 62, false, false);
insert into users (id, email, password, firstname, lastname, age, is_admin, is_student) values ('33356763-db48-4426-b51f-eba4003ad847', 'psedgemore2@e-recht24.de', '$2y$10$1BwbmZOvG.rl2Gii76G8zuohuBTqeSrClaNm3nQAL4GQRK1hYldo6', 'Parker', 'Sedgemore', 55, false, false);
insert into users (id, email, password, firstname, lastname, age, is_admin, is_student) values ('9488f60c-4138-4cba-8fa6-39c443eefbab', 'jrotge3@rediff.com', '$2y$10$EQAbSgGXmEl1EUL.Q3hKsO8eyhnrLkK.D9eHKahYrWPXGWHATW1rC', 'Janelle', 'Rotge', 30, false, true);
insert into users (id, email, password, firstname, lastname, age, is_admin, is_student) values ('56d7e6a2-29ca-400e-a345-c00c07ac8f0c', 'rsavill4@apache.org', '$2y$10$o/wm9jDoR2rshyVBXJzxeedaIiYY/ST5ZueUjxOxMDnX7I3Vx9bCm', 'Rolph', 'Savill', 70, false, false);


/*data insertion for sessions*/
insert into sessions (id, date_time) values (0030040321, '2022-06-27 17:07:44');
insert into sessions (id, date_time) values (0030040322, '2022-09-30 07:44:09');
insert into sessions (id, date_time) values (0030040323, '2022-10-22 05:53:06');
insert into sessions (id, date_time) values (0030040324, '2023-03-14 16:53:48');
insert into sessions (id, date_time) values (0030040325, '2022-06-24 18:43:03');
insert into sessions (id, date_time) values (0030040326, '2022-04-10 10:22:05');

/*data insertion for movies*/
insert into movies (id, title, date, duration, director, main_actor, description, genre, current_week) values (625874916, '2 + 2 (Dos más dos)', '2023-01-20', 86, 'Eilis Sprigg', 'Maje Briant', 'Nam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla. Sed vel enim sit amet nunc viverra dapibus. Nulla suscipit ligula in lacus.', 'Comedy', true);
insert into movies (id, title, date, duration, director, main_actor, description, genre, current_week) values (158733117, 'Secret Admirer', '2022-12-20', 83, 'Rabi Puttock', 'Artemas Barles', 'Cras non velit nec nisi vulputate nonummy. Maecenas tincidunt lacus at velit. Vivamus vel nulla eget eros elementum pellentesque.
Quisque porta volutpat erat. Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla. Nunc purus.
Phasellus in felis. Donec semper sapien a libero. Nam dui.', 'Comedy|Romance', true);
insert into movies (id, title, date, duration, director, main_actor, description, genre, current_week) values (354816918, 'Headfirst', '2022-11-14', 90, 'Swen Bambery', 'Judah Jurisch', 'Aenean fermentum. Donec ut mauris eget massa tempor convallis. Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh.
Quisque id justo sit amet sapien dignissim vestibulum. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est. Donec odio justo, sollicitudin ut, suscipit a, feugiat et, eros.', 'Drama', true);
insert into movies (id, title, date, duration, director, main_actor, description, genre, current_week) values (135498419, 'Charming Mass Suicide, A (Hurmaava joukkoitsemurha)', '2022-06-18', 70, 'Lilyan Fosten', 'Nell Dwane', 'Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis. Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci. Mauris lacinia sapien quis libero.
Nullam sit amet turpis elementum ligula vehicula consequat. Morbi a ipsum. Integer a nibh.', 'Comedy', false);
insert into movies (id, title, date, duration, director, main_actor, description, genre, current_week) values (135468420, 'When in Rome', '2023-01-19', 69, 'Dacey Danslow', 'Garnette Guttridge', 'In sagittis dui vel nisl. Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus.
Suspendisse potenti. In eleifend quam a odio. In hac habitasse platea dictumst.', 'Comedy|Romance', true);
insert into movies (id, title, date, duration, director, main_actor, description, genre, current_week) values (351684321, 'Things We Do For Love (Kaikella rakkaudella)', '2022-04-06', 80, 'Sonia Deverill', 'Boyce Over', 'In congue. Etiam justo. Etiam pretium iaculis justo.
In hac habitasse platea dictumst. Etiam faucibus cursus urna. Ut tellus.
Nulla ut erat id mauris vulputate elementum. Nullam varius. Nulla facilisi.', 'Drama', false);
insert into movies (id, title, date, duration, director, main_actor, description, genre, current_week) values (216489822, 'Spaghetti West, The', '2023-01-28', 78, 'Collin Doey', 'Kerwinn Beney', 'Vestibulum ac est lacinia nisi venenatis tristique. Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue. Aliquam erat volutpat.
In congue. Etiam justo. Etiam pretium iaculis justo.', 'Documentary', false);

/*data insertion for cinemas_admin*/
insert into cinemas_admin (admin_id, name, address, opening_time, closing_time) values ('25551c9c-4554-4bd6-8437-fe941d93f982', 'Cruickshank-Runolfsson', '76 Lakeland Drive', '1:52', '12:58');
insert into cinemas_admin (admin_id, name, address, opening_time, closing_time) values ('15f81aa4-0d84-434a-ad5d-3b7ecee5bda8', 'Littel-Towne', '72665 Bonner Center', '5:42', '16:51');
insert into cinemas_admin (admin_id, name, address, opening_time, closing_time) values ('0c50a75e-0df7-40af-a1c9-dd6d2c487eb6', 'Runolfsdottir-Graham', '6 Mcguire Terrace', '23:55', '1:53');
insert into cinemas_admin (admin_id, name, address, opening_time, closing_time) values ('86eb682a-6b4a-42d0-bf50-37557e018c56', 'Steuber LLC', '897 Anniversary Court', '22:04', '7:49');
insert into cinemas_admin (admin_id, name, address, opening_time, closing_time) values ('3484230a-f7d7-4f48-8a6c-6b802fc19343', 'Pouros, Cormier and Medhurst', '22 Duke Point', '7:49', '2:29');
insert into cinemas_admin (admin_id, name, address, opening_time, closing_time) values ('cda13f42-29d5-49ae-8be3-0864952379a0', 'Champlin Inc', '1492 Pepper Wood Junction', '20:06', '6:46');

/*data insertion for customers*/
INSERT INTO customers(users_id, watches) VALUES ('1b96980c-048e-406f-a573-45fd15d9066a', 625874916);
INSERT INTO customers(users_id, watches) VALUES ('f57402b8-acb7-4976-af9c-93ee6e33184f', 135498419);
INSERT INTO customers(users_id, watches) VALUES ('33356763-db48-4426-b51f-eba4003ad847', 354816918);
INSERT INTO customers(users_id, watches) VALUES ('9488f60c-4138-4cba-8fa6-39c443eefbab', 354816918);
INSERT INTO customers(users_id, watches) VALUES ('56d7e6a2-29ca-400e-a345-c00c07ac8f0c', 625874916);

/*data insertion for rooms*/
insert into rooms (id, name, nber_seats, possesses) values (1, 'Jay', 22, '15f81aa4-0d84-434a-ad5d-3b7ecee5bda8');
insert into rooms (id, name, nber_seats, possesses) values (2, 'Dunning', 48, '25551c9c-4554-4bd6-8437-fe941d93f982');
insert into rooms (id, name, nber_seats, possesses) values (3, 'Rowland', 74, '15f81aa4-0d84-434a-ad5d-3b7ecee5bda8');
insert into rooms (id, name, nber_seats, possesses) values (4, '5th', 40, '0c50a75e-0df7-40af-a1c9-dd6d2c487eb6');
insert into rooms (id, name, nber_seats, possesses) values (5, 'Milwaukee', 14, '25551c9c-4554-4bd6-8437-fe941d93f982');
insert into rooms (id, name, nber_seats, possesses) values (6, 'Melby', 30, '86eb682a-6b4a-42d0-bf50-37557e018c56');
insert into rooms (id, name, nber_seats, possesses) values (7, 'Vera', 45, '86eb682a-6b4a-42d0-bf50-37557e018c56');
insert into rooms (id, name, nber_seats, possesses) values (8, 'Kingsford', 19, '25551c9c-4554-4bd6-8437-fe941d93f982');
insert into rooms (id, name, nber_seats, possesses) values (9, '2nd', 93, '3484230a-f7d7-4f48-8a6c-6b802fc19343');
insert into rooms (id, name, nber_seats, possesses) values (10, 'Elmside', 32, 'cda13f42-29d5-49ae-8be3-0864952379a0');
insert into rooms (id, name, nber_seats, possesses) values (11, 'Old Shore', 57, '3484230a-f7d7-4f48-8a6c-6b802fc19343');
insert into rooms (id, name, nber_seats, possesses) values (12, 'Graceland', 49, '86eb682a-6b4a-42d0-bf50-37557e018c56');

/*data insertion for tickets*/
insert into tickets (id, date, price, is_used, pays_for, books_a) values (202205261, '2022-05-26 17:14:09', 8.74, true, '56d7e6a2-29ca-400e-a345-c00c07ac8f0c', 0030040321);
insert into tickets (id, date, price, is_used, pays_for, books_a) values (202206282, '2022-06-28 09:16:38', 8.37, true, '9488f60c-4138-4cba-8fa6-39c443eefbab', 0030040322);
insert into tickets (id, date, price, is_used, pays_for, books_a) values (202302113, '2023-02-11 22:25:10', 3.27, false, '33356763-db48-4426-b51f-eba4003ad847', 0030040323);
insert into tickets (id, date, price, is_used, pays_for, books_a) values (202210214, '2022-10-21 12:07:18', 12.88, true, 'f57402b8-acb7-4976-af9c-93ee6e33184f', 0030040324);
insert into tickets (id, date, price, is_used, pays_for, books_a) values (202206085, '2022-06-08 04:11:34', 15.79, false, 'f57402b8-acb7-4976-af9c-93ee6e33184f', 0030040325);
insert into tickets (id, date, price, is_used, pays_for, books_a) values (202210196, '2022-10-19 08:01:00', 4.42, false, '1b96980c-048e-406f-a573-45fd15d9066a', 0030040326);

/*data insertion for payments*/
insert into payments (tickets_id, customers_id, total, is_onsite) values (202205261, '56d7e6a2-29ca-400e-a345-c00c07ac8f0c', 18.37, false);
insert into payments (tickets_id, customers_id, total, is_onsite) values (202210214, '9488f60c-4138-4cba-8fa6-39c443eefbab', 7.24, true);
insert into payments (tickets_id, customers_id, total, is_onsite) values (202210196, '33356763-db48-4426-b51f-eba4003ad847', 19.48, true);
insert into payments (tickets_id, customers_id, total, is_onsite) values (202206282, 'f57402b8-acb7-4976-af9c-93ee6e33184f', 12.33, true);
insert into payments (tickets_id, customers_id, total, is_onsite) values (202206085, '1b96980c-048e-406f-a573-45fd15d9066a', 2.64, true);

/*data insertion for is_displayed*/
insert into is_displayed (rooms_id, sessions_id) values (1, 0030040321);
insert into is_displayed (rooms_id, sessions_id) values (2, 0030040321);
insert into is_displayed (rooms_id, sessions_id) values (3, 0030040322);
insert into is_displayed (rooms_id, sessions_id) values (4, 0030040322);
insert into is_displayed (rooms_id, sessions_id) values (5, 0030040323);
insert into is_displayed (rooms_id, sessions_id) values (6, 0030040323);
insert into is_displayed (rooms_id, sessions_id) values (7, 0030040324);
insert into is_displayed (rooms_id, sessions_id) values (8, 0030040324);
insert into is_displayed (rooms_id, sessions_id) values (9, 0030040325);
insert into is_displayed (rooms_id, sessions_id) values (10, 0030040325);
insert into is_displayed (rooms_id, sessions_id) values (11, 0030040326);
insert into is_displayed (rooms_id, sessions_id) values (12, 0030040326);

/*data insertion for programmed*/
insert into programmed (movies_id, sessions_id) values (625874916, 0030040321);
insert into programmed (movies_id, sessions_id) values (135498419, 0030040322);
insert into programmed (movies_id, sessions_id) values (158733117, 0030040323);
insert into programmed (movies_id, sessions_id) values (135468420, 0030040324);
insert into programmed (movies_id, sessions_id) values (135498419, 0030040325);
insert into programmed (movies_id, sessions_id) values (158733117, 0030040326);

/*data insertion for changes_to_movies*/
insert into changes_to_movies (movies_id, admin_id) values (625874916, '25551c9c-4554-4bd6-8437-fe941d93f982');
insert into changes_to_movies (movies_id, admin_id) values (135498419, '15f81aa4-0d84-434a-ad5d-3b7ecee5bda8');
insert into changes_to_movies (movies_id, admin_id) values (158733117, '0c50a75e-0df7-40af-a1c9-dd6d2c487eb6');
insert into changes_to_movies (movies_id, admin_id) values (216489822, '86eb682a-6b4a-42d0-bf50-37557e018c56');
insert into changes_to_movies (movies_id, admin_id) values (351684321, '3484230a-f7d7-4f48-8a6c-6b802fc19343');
insert into changes_to_movies (movies_id, admin_id) values (354816918, 'cda13f42-29d5-49ae-8be3-0864952379a0');