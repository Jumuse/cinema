CREATE DATABASE IF NOT EXISTS bdd_cinema SET utf8mb4 COLLATE utf8mb4_general_ci;

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
    date_time DATE NOT NULL
);

CREATE TABLE movies (
    id INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(30) NOT NULL,
    date DATE NOT NULL,
    duration INT(2) NOT NULL,
    director VARCHAR(30) NOT NULL,
    main_actor VARCHAR(30) NOT NULL,
    description TEXT(100) NOT NULL,
    genre VARCHAR(20) NOT NULL,
    current_week BOOLEAN NOT NULL
);

CREATE TABLE customers (
    users_id INT(11) NOT NULL PRIMARY KEY,
    /*One to Many between customers and movies*/
    watches INT(11) NOT NULL,
    FOREIGN KEY (watches) REFERENCES movies(id),
    /*inheritance between users and customers*/
    FOREIGN KEY(users_id) REFERENCES users(id)
);

CREATE TABLE cinemas_admin (
    /*fusion between admin and cinemas + inheritance between users and admin*/
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
    /*One to many association between cinemas_admin and rooms*/
    possesses INT(11) NOT NULL,
    FOREIGN KEY(possesses) REFERENCES cinemas_admin(admin_id)
);

CREATE TABLE tickets (
    id INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
    date DATE NOT NULL,
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
insert into users (id, email, firstname, lastname, age, is_student) values (1, 'ibrandrick0@yellowbook.com', 'Irita', 'Brandrick', 13, false);
insert into users (id, email, firstname, lastname, age, is_student) values (2, 'colivier1@reuters.com', 'Cullie', 'Olivier', 56, false);
insert into users (id, email, firstname, lastname, age, is_student) values (3, 'dhobbema2@about.me', 'Dolly', 'Hobbema', 97, true);
insert into users (id, email, firstname, lastname, age, is_student) values (4, 'ffranzschoninger3@yellowpages.com', 'Forest', 'Franz-Schoninger', 65, true);
insert into users (id, email, firstname, lastname, age, is_student) values (5, 'mberendsen4@pen.io', 'Michelina', 'Berendsen', 19, false);
insert into users (id, email, firstname, lastname, age, is_student) values (6, 'rstefi5@sfgate.com', 'Ronni', 'Stefi', 67, false);
insert into users (id, email, firstname, lastname, age, is_student) values (7, 'atassell6@jalbum.net', 'Arabelle', 'Tassell', 82, false);
insert into users (id, email, firstname, lastname, age, is_student) values (8, 'fwaye7@sphinn.com', 'Fancie', 'Waye', 33, true);
insert into users (id, email, firstname, lastname, age, is_student) values (9, 'ljelley8@adobe.com', 'Leda', 'Jelley', 87, true);
insert into users (id, email, firstname, lastname, age, is_student) values (10, 'jthurnham9@sogou.com', 'Josie', 'Thurnham', 57, true);
insert into users (id, email, firstname, lastname, age, is_student) values (11, 'jmacdaida@merriam-webster.com', 'Jerrie', 'MacDaid', 18, false);
insert into users (id, email, firstname, lastname, age, is_student) values (12, 'tsilverwoodb@chicagotribune.com', 'Tallie', 'Silverwood', 39, true);
insert into users (id, email, firstname, lastname, age, is_student) values (13, 'umeddowsc@1688.com', 'Umberto', 'Meddows', 46, true);
insert into users (id, email, firstname, lastname, age, is_student) values (14, 'nschachd@jalbum.net', 'Natala', 'Schach', 35, true);
insert into users (id, email, firstname, lastname, age, is_student) values (15, 'dwhapplese@loc.gov', 'Daria', 'Whapples', 41, true);
insert into users (id, email, firstname, lastname, age, is_student) values (16, 'dchalfantf@discovery.com', 'Deedee', 'Chalfant', 53, true);
insert into users (id, email, firstname, lastname, age, is_student) values (17, 'tcoverdillg@zdnet.com', 'Tommy', 'Coverdill', 79, true);
insert into users (id, email, firstname, lastname, age, is_student) values (18, 'rarcherh@tuttocitta.it', 'Reeba', 'Archer', 72, true);
insert into users (id, email, firstname, lastname, age, is_student) values (19, 'framirezi@1688.com', 'Fremont', 'Ramirez', 89, false);
insert into users (id, email, firstname, lastname, age, is_student) values (20, 'tjorioj@quantcast.com', 'Teddy', 'Jorio', 37, false);
insert into users (id, email, firstname, lastname, age, is_student) values (21, 'mlemoucheuxk@yahoo.com', 'Mag', 'Le Moucheux', 79, false);
insert into users (id, email, firstname, lastname, age, is_student) values (22, 'thempell@vistaprint.com', 'Thomasa', 'Hempel', 96, false);
insert into users (id, email, firstname, lastname, age, is_student) values (23, 'ltortism@china.com.cn', 'Lars', 'Tortis', 29, true);
insert into users (id, email, firstname, lastname, age, is_student) values (24, 'cbrazurn@amazon.de', 'Cordell', 'Brazur', 65, true);
insert into users (id, email, firstname, lastname, age, is_student) values (25, 'fadeneto@ted.com', 'Fina', 'Adenet', 33, true);
insert into users (id, email, firstname, lastname, age, is_student) values (26, 'gkarolyp@bbc.co.uk', 'Guillermo', 'Karoly', 23, false);
insert into users (id, email, firstname, lastname, age, is_student) values (27, 'brustadgeq@bloglovin.com', 'Blake', 'Rustadge', 92, true);
insert into users (id, email, firstname, lastname, age, is_student) values (28, 'frofer@imgur.com', 'Florence', 'Rofe', 23, true);
insert into users (id, email, firstname, lastname, age, is_student) values (29, 'dbrentnalls@house.gov', 'Deb', 'Brentnall', 83, false);
insert into users (id, email, firstname, lastname, age, is_student) values (30, 'yarnaudt@google.nl', 'Yorgos', 'Arnaud', 93, false);
insert into users (id, email, firstname, lastname, age, is_student) values (31, 'babilowitzu@reverbnation.com', 'Belva', 'Abilowitz', 81, false);
insert into users (id, email, firstname, lastname, age, is_student) values (32, 'dscoulerv@answers.com', 'Dianna', 'Scouler', 56, false);
insert into users (id, email, firstname, lastname, age, is_student) values (33, 'lkiftw@seattletimes.com', 'Lindie', 'Kift', 69, false);
insert into users (id, email, firstname, lastname, age, is_student) values (34, 'skassmanx@webnode.com', 'Sansone', 'Kassman', 20, true);
insert into users (id, email, firstname, lastname, age, is_student) values (35, 'astummeyery@etsy.com', 'Asa', 'Stummeyer', 52, true);
insert into users (id, email, firstname, lastname, age, is_student) values (36, 'ddearlovez@php.net', 'Dwain', 'Dearlove', 13, false);
insert into users (id, email, firstname, lastname, age, is_student) values (37, 'bdovinson10@theglobeandmail.com', 'Britteny', 'Dovinson', 20, false);
insert into users (id, email, firstname, lastname, age, is_student) values (38, 'cwheelwright11@telegraph.co.uk', 'Cullie', 'Wheelwright', 91, false);
insert into users (id, email, firstname, lastname, age, is_student) values (39, 'acoonan12@google.fr', 'Allegra', 'Coonan', 48, true);
insert into users (id, email, firstname, lastname, age, is_student) values (40, 'nblackmuir13@alibaba.com', 'Nissy', 'Blackmuir', 93, true);
insert into users (id, email, firstname, lastname, age, is_student) values (41, 'wkift14@wp.com', 'Waly', 'Kift', 63, false);
insert into users (id, email, firstname, lastname, age, is_student) values (42, 'gjewar15@ted.com', 'Gareth', 'Jewar', 13, false);
insert into users (id, email, firstname, lastname, age, is_student) values (43, 'omccook16@cbsnews.com', 'Oby', 'McCook', 85, false);
insert into users (id, email, firstname, lastname, age, is_student) values (44, 'avitler17@wisc.edu', 'Atlante', 'Vitler', 56, true);
insert into users (id, email, firstname, lastname, age, is_student) values (45, 'rdumbrell18@godaddy.com', 'Rosalind', 'Dumbrell', 71, false);
insert into users (id, email, firstname, lastname, age, is_student) values (46, 'sgrieger19@hexun.com', 'Sybil', 'Grieger', 99, false);
insert into users (id, email, firstname, lastname, age, is_student) values (47, 'dzollner1a@spiegel.de', 'Domenico', 'Zollner', 82, true);
insert into users (id, email, firstname, lastname, age, is_student) values (48, 'pfranke1b@ox.ac.uk', 'Pascal', 'Franke', 94, true);
insert into users (id, email, firstname, lastname, age, is_student) values (49, 'afossitt1c@cornell.edu', 'Audry', 'Fossitt', 71, false);
insert into users (id, email, firstname, lastname, age, is_student) values (50, 'ataffrey1d@bbc.co.uk', 'Amelita', 'Taffrey', 43, true);

/*data insertion for sessions*/
insert into sessions (id, date_time) values (1, '2022-06-27 17:07:44');
insert into sessions (id, date_time) values (2, '2022-09-30 07:44:09');
insert into sessions (id, date_time) values (3, '2022-10-22 05:53:06');
insert into sessions (id, date_time) values (4, '2023-03-14 16:53:48');
insert into sessions (id, date_time) values (5, '2022-06-24 18:43:03');
insert into sessions (id, date_time) values (6, '2022-04-10 10:22:05');
insert into sessions (id, date_time) values (7, '2022-07-17 00:54:13');
insert into sessions (id, date_time) values (8, '2022-06-08 15:43:12');
insert into sessions (id, date_time) values (9, '2022-11-03 18:46:03');
insert into sessions (id, date_time) values (10, '2022-12-13 06:26:14');
insert into sessions (id, date_time) values (11, '2022-07-17 07:06:33');
insert into sessions (id, date_time) values (12, '2023-03-22 14:27:52');
insert into sessions (id, date_time) values (13, '2022-11-27 01:13:09');
insert into sessions (id, date_time) values (14, '2023-03-11 11:22:21');
insert into sessions (id, date_time) values (15, '2022-09-03 02:50:15');
insert into sessions (id, date_time) values (16, '2023-03-15 17:29:01');
insert into sessions (id, date_time) values (17, '2022-11-03 13:49:38');
insert into sessions (id, date_time) values (18, '2022-12-01 09:32:57');
insert into sessions (id, date_time) values (19, '2022-06-23 05:03:54');
insert into sessions (id, date_time) values (20, '2022-08-22 04:26:08');

/*data insertion for movies*/
insert into movies (id, title, date, duration, director, main_actor, description, genre, current_week) values (1, 'True Story of Jesse James, The', '2022-11-19', 85, 'Ynes Capaldo', 'Frances Haydn', 'Duis aliquam convallis nunc. Proin at turpis a pede posuere nonummy. Integer non velit.

Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi. Integer ac neque.

Duis bibendum. Morbi non quam nec dui luctus rutrum. Nulla tellus.', 'Action|Crime|Western', true);
insert into movies (id, title, date, duration, director, main_actor, description, genre, current_week) values (2, 'Easy Come, Easy Go', '2022-09-09', 75, 'Anastassia Skilling', 'Matias Gabrieli', 'Nullam porttitor lacus at turpis. Donec posuere metus vitae ipsum. Aliquam non mauris.

Morbi non lectus. Aliquam sit amet diam in magna bibendum imperdiet. Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis.', 'Adventure|Musical', true);
insert into movies (id, title, date, duration, director, main_actor, description, genre, current_week) values (3, 'Confessional, The (Confessionnal, Le)', '2023-01-03', 65, 'Aleen Cantero', 'Niles Falcus', 'In quis justo. Maecenas rhoncus aliquam lacus. Morbi quis tortor id nulla ultrices aliquet.', 'Drama|Mystery', false);
insert into movies (id, title, date, duration, director, main_actor, description, genre, current_week) values (4, 'Pandora''s Box (Büchse der Pandora, Die)', '2023-01-24', 70, 'Claus Duval', 'Shelley Mattiazzo', 'Aenean lectus. Pellentesque eget nunc. Donec quis orci eget orci vehicula condimentum.', 'Drama', false);
insert into movies (id, title, date, duration, director, main_actor, description, genre, current_week) values (5, 'Marihuana', '2022-12-14', 87, 'Byran Ashfield', 'Yul Alessandretti', 'In quis justo. Maecenas rhoncus aliquam lacus. Morbi quis tortor id nulla ultrices aliquet.

Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo. Pellentesque viverra pede ac diam. Cras pellentesque volutpat dui.

Maecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam. Suspendisse potenti.', 'Documentary|Drama', false);
insert into movies (id, title, date, duration, director, main_actor, description, genre, current_week) values (6, 'Land of Milk and Honey (Pays de cocagne)', '2023-01-20', 74, 'Bondie McGrotty', 'Gordon O''Fairy', 'Etiam vel augue. Vestibulum rutrum rutrum neque. Aenean auctor gravida sem.

Praesent id massa id nisl venenatis lacinia. Aenean sit amet justo. Morbi ut odio.', 'Documentary', false);
insert into movies (id, title, date, duration, director, main_actor, description, genre, current_week) values (7, 'Polytechnique', '2022-06-15', 84, 'Calida Mazdon', 'Tanya Brougham', 'Proin interdum mauris non ligula pellentesque ultrices. Phasellus id sapien in sapien iaculis congue. Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl.

Aenean lectus. Pellentesque eget nunc. Donec quis orci eget orci vehicula condimentum.', 'Crime|Drama', false);
insert into movies (id, title, date, duration, director, main_actor, description, genre, current_week) values (8, 'Mr. Jones', '2022-10-16', 70, 'Farley Ellingworth', 'Lorrayne Passmore', 'Morbi non lectus. Aliquam sit amet diam in magna bibendum imperdiet. Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis.

Fusce posuere felis sed lacus. Morbi sem mauris, laoreet ut, rhoncus aliquet, pulvinar sed, nisl. Nunc rhoncus dui vel sem.

Sed sagittis. Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci. Nullam molestie nibh in lectus.', 'Drama|Horror|Thriller', true);
insert into movies (id, title, date, duration, director, main_actor, description, genre, current_week) values (9, 'The Humanoid', '2022-11-16', 84, 'Davy Jovey', 'Fan Mullarkey', 'Duis bibendum. Morbi non quam nec dui luctus rutrum. Nulla tellus.

In sagittis dui vel nisl. Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus.', 'Fantasy|Sci-Fi', true);
insert into movies (id, title, date, duration, director, main_actor, description, genre, current_week) values (10, 'Confidential Agent', '2022-09-05', 85, 'Emelita Greenleaf', 'Neddie Maggiori', 'Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vivamus vestibulum sagittis sapien. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.', 'Drama|Thriller', true);
insert into movies (id, title, date, duration, director, main_actor, description, genre, current_week) values (11, 'Bolt', '2022-07-02', 77, 'Jaymie Casseldine', 'Evey Colvine', 'Phasellus in felis. Donec semper sapien a libero. Nam dui.

Proin leo odio, porttitor id, consequat in, consequat ut, nulla. Sed accumsan felis. Ut at dolor quis odio consequat varius.

Integer ac leo. Pellentesque ultrices mattis odio. Donec vitae nisi.', 'Action|Adventure|Animation|Children|Comedy', true);
insert into movies (id, title, date, duration, director, main_actor, description, genre, current_week) values (12, 'Lost, The', '2022-06-16', 76, 'Shannen Denniston', 'Goran Crumpton', 'Integer ac leo. Pellentesque ultrices mattis odio. Donec vitae nisi.

Nam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla. Sed vel enim sit amet nunc viverra dapibus. Nulla suscipit ligula in lacus.', 'Thriller', false);
insert into movies (id, title, date, duration, director, main_actor, description, genre, current_week) values (13, 'Human Condition II, The (Ningen no joken II)', '2022-09-05', 69, 'Glynn Kleine', 'Brewster Riping', 'Integer ac leo. Pellentesque ultrices mattis odio. Donec vitae nisi.', 'Drama|War', true);
insert into movies (id, title, date, duration, director, main_actor, description, genre, current_week) values (14, 'I Spy', '2022-12-25', 87, 'Ethelind Lamond', 'Tabby Hammerberger', 'Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vivamus vestibulum sagittis sapien. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.

Etiam vel augue. Vestibulum rutrum rutrum neque. Aenean auctor gravida sem.

Praesent id massa id nisl venenatis lacinia. Aenean sit amet justo. Morbi ut odio.', 'Action|Adventure|Comedy|Crime', true);
insert into movies (id, title, date, duration, director, main_actor, description, genre, current_week) values (15, 'Late Night Shopping', '2022-12-13', 77, 'Julius Spon', 'Maureen Rizon', 'Vestibulum quam sapien, varius ut, blandit non, interdum in, ante. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Duis faucibus accumsan odio. Curabitur convallis.

Duis consequat dui nec nisi volutpat eleifend. Donec ut dolor. Morbi vel lectus in quam fringilla rhoncus.', 'Comedy', false);
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
insert into movies (id, title, date, duration, director, main_actor, description, genre, current_week) values (23, 'Quick Change', '2023-02-08', 85, 'Chad Danielis', 'Maurits Aleksandrov', 'Nullam porttitor lacus at turpis. Donec posuere metus vitae ipsum. Aliquam non mauris.

Morbi non lectus. Aliquam sit amet diam in magna bibendum imperdiet. Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis.

Fusce posuere felis sed lacus. Morbi sem mauris, laoreet ut, rhoncus aliquet, pulvinar sed, nisl. Nunc rhoncus dui vel sem.', 'Comedy|Crime', true);
insert into movies (id, title, date, duration, director, main_actor, description, genre, current_week) values (24, 'Silent Night, Deadly Night III: Better Watch Out!', '2022-12-06', 81, 'Eli Holgan', 'Arlen Scourfield', 'Duis bibendum. Morbi non quam nec dui luctus rutrum. Nulla tellus.

In sagittis dui vel nisl. Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus.

Suspendisse potenti. In eleifend quam a odio. In hac habitasse platea dictumst.', 'Horror', false);
insert into movies (id, title, date, duration, director, main_actor, description, genre, current_week) values (25, 'Slim Carter', '2022-07-16', 66, 'Hephzibah Berick', 'Marrissa Yanele', 'Fusce consequat. Nulla nisl. Nunc nisl.', 'Comedy|Western', true);
insert into movies (id, title, date, duration, director, main_actor, description, genre, current_week) values (26, 'Gladiator', '2022-08-18', 86, 'Hedvige McSkin', 'Micah Crisall', 'Phasellus sit amet erat. Nulla tempus. Vivamus in felis eu sapien cursus vestibulum.

Proin eu mi. Nulla ac enim. In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem.', 'Action|Adventure|Drama', true);
insert into movies (id, title, date, duration, director, main_actor, description, genre, current_week) values (27, 'Raven, The', '2022-04-04', 75, 'Ewart Ableson', 'Gratiana Gayle', 'Vestibulum ac est lacinia nisi venenatis tristique. Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue. Aliquam erat volutpat.', 'Mystery|Thriller', true);
insert into movies (id, title, date, duration, director, main_actor, description, genre, current_week) values (28, 'Some Like It Hot', '2022-12-23', 81, 'Zechariah Robertsen', 'Ced Speirs', 'Curabitur gravida nisi at nibh. In hac habitasse platea dictumst. Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem.', 'Comedy|Crime', false);
insert into movies (id, title, date, duration, director, main_actor, description, genre, current_week) values (29, 'Hulk', '2022-06-12', 88, 'Reinhold Mourant', 'Lavinia Surgener', 'Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa. Donec dapibus. Duis at velit eu est congue elementum.

In hac habitasse platea dictumst. Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante. Nulla justo.', 'Action|Adventure|Sci-Fi', false);
insert into movies (id, title, date, duration, director, main_actor, description, genre, current_week) values (30, 'I Live in Fear (Ikimono no kiroku)', '2022-08-07', 88, 'Pandora Matschoss', 'Ellsworth Chstney', 'Suspendisse potenti. In eleifend quam a odio. In hac habitasse platea dictumst.

Maecenas ut massa quis augue luctus tincidunt. Nulla mollis molestie lorem. Quisque ut erat.

Curabitur gravida nisi at nibh. In hac habitasse platea dictumst. Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem.', 'Drama', false);
insert into movies (id, title, date, duration, director, main_actor, description, genre, current_week) values (31, 'Half Past Dead', '2022-05-10', 87, 'Candice Muncer', 'Ritchie MacFall', 'Pellentesque at nulla. Suspendisse potenti. Cras in purus eu magna vulputate luctus.

Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vivamus vestibulum sagittis sapien. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.', 'Action|Crime|Thriller', true);
insert into movies (id, title, date, duration, director, main_actor, description, genre, current_week) values (32, 'All Over Me', '2023-01-25', 67, 'Cherice Stockoe', 'Maxim Raymond', 'Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo. Pellentesque viverra pede ac diam. Cras pellentesque volutpat dui.', 'Drama', false);
insert into movies (id, title, date, duration, director, main_actor, description, genre, current_week) values (33, 'Planet Terror', '2023-01-21', 84, 'Curr Danit', 'Carey Barbour', 'Phasellus sit amet erat. Nulla tempus. Vivamus in felis eu sapien cursus vestibulum.

Proin eu mi. Nulla ac enim. In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem.

Duis aliquam convallis nunc. Proin at turpis a pede posuere nonummy. Integer non velit.', 'Action|Horror|Sci-Fi', true);
insert into movies (id, title, date, duration, director, main_actor, description, genre, current_week) values (34, 'Help! I''m A Fish', '2022-10-28', 75, 'Irene Georgeau', 'Kelsy Littlekit', 'Duis consequat dui nec nisi volutpat eleifend. Donec ut dolor. Morbi vel lectus in quam fringilla rhoncus.

Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis. Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci. Mauris lacinia sapien quis libero.

Nullam sit amet turpis elementum ligula vehicula consequat. Morbi a ipsum. Integer a nibh.', 'Adventure|Animation|Comedy', false);
insert into movies (id, title, date, duration, director, main_actor, description, genre, current_week) values (35, 'Thieves, The (Dodookdeul)', '2022-05-07', 84, 'Sherye Dibson', 'Genovera Creyke', 'Pellentesque at nulla. Suspendisse potenti. Cras in purus eu magna vulputate luctus.

Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vivamus vestibulum sagittis sapien. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.

Etiam vel augue. Vestibulum rutrum rutrum neque. Aenean auctor gravida sem.', 'Action|Crime', true);
insert into movies (id, title, date, duration, director, main_actor, description, genre, current_week) values (36, 'Knight of Cups', '2022-07-22', 90, 'Emanuele Ambrogiotti', 'Wadsworth Hasslocher', 'In sagittis dui vel nisl. Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus.

Suspendisse potenti. In eleifend quam a odio. In hac habitasse platea dictumst.

Maecenas ut massa quis augue luctus tincidunt. Nulla mollis molestie lorem. Quisque ut erat.', 'Drama', false);
insert into movies (id, title, date, duration, director, main_actor, description, genre, current_week) values (37, 'Amandla! A Revolution in Four Part Harmony', '2022-05-23', 80, 'Margy Garratty', 'Gussie Ronisch', 'Nullam porttitor lacus at turpis. Donec posuere metus vitae ipsum. Aliquam non mauris.

Morbi non lectus. Aliquam sit amet diam in magna bibendum imperdiet. Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis.', 'Documentary|Musical', true);
insert into movies (id, title, date, duration, director, main_actor, description, genre, current_week) values (38, 'Fallen', '2023-01-31', 79, 'Shannen Brock', 'Jade Fenge', 'Integer ac leo. Pellentesque ultrices mattis odio. Donec vitae nisi.

Nam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla. Sed vel enim sit amet nunc viverra dapibus. Nulla suscipit ligula in lacus.

Curabitur at ipsum ac tellus semper interdum. Mauris ullamcorper purus sit amet nulla. Quisque arcu libero, rutrum ac, lobortis vel, dapibus at, diam.', 'Crime|Drama|Fantasy|Thriller', false);
insert into movies (id, title, date, duration, director, main_actor, description, genre, current_week) values (39, 'In My Father''s Den', '2022-06-11', 73, 'Malory Kleinerman', 'Lorettalorna Gonnelly', 'Suspendisse potenti. In eleifend quam a odio. In hac habitasse platea dictumst.', 'Drama', false);
insert into movies (id, title, date, duration, director, main_actor, description, genre, current_week) values (40, 'Tokyo-Ga', '2022-08-23', 81, 'Sorcha Scardefield', 'Lezley Spinney', 'In sagittis dui vel nisl. Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus.', 'Documentary', false);

/*data insertion for cinemas_admin*/
insert into cinemas_admin (admin_id, name, address, opening_time, closing_time) values (1, 'Cruickshank-Runolfsson', '76 Lakeland Drive', '1:52', '12:58');
insert into cinemas_admin (admin_id, name, address, opening_time, closing_time) values (2, 'Littel-Towne', '72665 Bonner Center', '5:42', '16:51');
insert into cinemas_admin (admin_id, name, address, opening_time, closing_time) values (3, 'Runolfsdottir-Graham', '6 Mcguire Terrace', '23:55', '1:53');
insert into cinemas_admin (admin_id, name, address, opening_time, closing_time) values (4, 'Steuber LLC', '897 Anniversary Court', '22:04', '7:49');
insert into cinemas_admin (admin_id, name, address, opening_time, closing_time) values (5, 'Pouros, Cormier and Medhurst', '22 Duke Point', '7:49', '2:29');
insert into cinemas_admin (admin_id, name, address, opening_time, closing_time) values (6, 'Champlin Inc', '1492 Pepper Wood Junction', '20:06', '6:46');
insert into cinemas_admin (admin_id, name, address, opening_time, closing_time) values (7, 'Reilly, Schimmel and Kulas', '7 Brentwood Circle', '13:59', '12:50');
insert into cinemas_admin (admin_id, name, address, opening_time, closing_time) values (8, 'Boyer-Greenholt', '29 Hollow Ridge Point', '0:47', '22:28');
insert into cinemas_admin (admin_id, name, address, opening_time, closing_time) values (9, 'Dickinson, Blanda and Marquardt', '18 Kipling Street', '22:55', '12:39');
insert into cinemas_admin (admin_id, name, address, opening_time, closing_time) values (10, 'Harvey and Sons', '65358 Buena Vista Hill', '16:26', '21:20');

/*data insertion for customers*/
INSERT INTO customers(users_id, watches) VALUES (1, 11);
INSERT INTO customers(users_id, watches) VALUES (2, 20);
INSERT INTO customers(users_id, watches) VALUES (3, 5);
INSERT INTO customers(users_id, watches) VALUES (4, 6);
INSERT INTO customers(users_id, watches) VALUES (5, 20);
INSERT INTO customers(users_id, watches) VALUES (6, 2);
INSERT INTO customers(users_id, watches) VALUES (9, 11);
INSERT INTO customers(users_id, watches) VALUES (10, 3);
INSERT INTO customers(users_id, watches) VALUES (11, 25);
INSERT INTO customers(users_id, watches) VALUES (12, 25);
INSERT INTO customers(users_id, watches) VALUES (13, 31);
INSERT INTO customers(users_id, watches) VALUES (14, 2);
INSERT INTO customers(users_id, watches) VALUES (15, 21);

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
insert into rooms (id, name, nber_seats, possesses) values (13, 'Heffernan', 28, 7);
insert into rooms (id, name, nber_seats, possesses) values (14, 'Riverside', 10, 7);
insert into rooms (id, name, nber_seats, possesses) values (15, 'Cottonwood', 89, 7);
insert into rooms (id, name, nber_seats, possesses) values (16, 'Algoma', 49, 8);
insert into rooms (id, name, nber_seats, possesses) values (17, 'Everett', 31, 8);
insert into rooms (id, name, nber_seats, possesses) values (18, 'Loomis', 93, 9);
insert into rooms (id, name, nber_seats, possesses) values (19, 'Menomonie', 67, 10);
insert into rooms (id, name, nber_seats, possesses) values (20, 'Ridge Oak', 17, 10);

/*data insertion for tickets*/
insert into tickets (id, date, price, is_used, pays_for, books_a) values (1, '2022-05-26 17:14:09', 8.74, true, 1, 1);
insert into tickets (id, date, price, is_used, pays_for, books_a) values (2, '2022-06-28 09:16:38', 8.37, true, 2, 2);
insert into tickets (id, date, price, is_used, pays_for, books_a) values (3, '2023-02-11 22:25:10', 3.27, false, 3, 3);
insert into tickets (id, date, price, is_used, pays_for, books_a) values (4, '2022-10-21 12:07:18', 12.88, true, 4, 4);
insert into tickets (id, date, price, is_used, pays_for, books_a) values (5, '2022-06-08 04:11:34', 15.79, false, 5, 5);
insert into tickets (id, date, price, is_used, pays_for, books_a) values (6, '2022-10-19 08:01:00', 4.42, false, 6, 6);
insert into tickets (id, date, price, is_used, pays_for, books_a) values (7, '2022-09-01 19:38:12', 4.16, true, 7, 7);
insert into tickets (id, date, price, is_used, pays_for, books_a) values (8, '2022-07-01 12:19:56', 14.77, false, 8, 8);
insert into tickets (id, date, price, is_used, pays_for, books_a) values (9, '2022-10-12 16:21:56', 9.96, false, 9, 9);
insert into tickets (id, date, price, is_used, pays_for, books_a) values (10, '2023-01-05 16:05:40', 9.96, false, 10, 10);
insert into tickets (id, date, price, is_used, pays_for, books_a) values (11, '2023-01-29 23:25:27', 11.88, true, 11, 11);
insert into tickets (id, date, price, is_used, pays_for, books_a) values (12, '2022-04-20 22:13:14', 1.4, true, 12, 12);
insert into tickets (id, date, price, is_used, pays_for, books_a) values (13, '2022-10-02 08:13:04', 5.92, true, 13, 13);
insert into tickets (id, date, price, is_used, pays_for, books_a) values (14, '2022-11-27 04:56:23', 17.62, false, 14, 14);
insert into tickets (id, date, price, is_used, pays_for, books_a) values (15, '2023-01-31 20:56:41', 12.42, false, 15, 15);
insert into tickets (id, date, price, is_used, pays_for, books_a) values (16, '2022-12-07 02:50:47', 10.15, true, 16, 16);
insert into tickets (id, date, price, is_used, pays_for, books_a) values (17, '2023-03-24 03:17:16', 19.7, false, 17, 17);
insert into tickets (id, date, price, is_used, pays_for, books_a) values (18, '2022-07-09 22:49:21', 18.1, false, 18, 18);
insert into tickets (id, date, price, is_used, pays_for, books_a) values (19, '2022-12-22 22:59:52', 9.57, true, 19, 19);
insert into tickets (id, date, price, is_used, pays_for, books_a) values (20, '2022-08-10 08:15:26', 19.56, false, 20, 20);

/*data insertion for payments*/
insert into payments (tickets_id, customers_id, total, is_onsite) values (1, 1, 18.37, false);
insert into payments (tickets_id, customers_id, total, is_onsite) values (2, 2, 7.24, true);
insert into payments (tickets_id, customers_id, total, is_onsite) values (3, 3, 19.48, true);
insert into payments (tickets_id, customers_id, total, is_onsite) values (4, 4, 12.33, true);
insert into payments (tickets_id, customers_id, total, is_onsite) values (5, 5, 2.64, true);
insert into payments (tickets_id, customers_id, total, is_onsite) values (6, 6, 17.98, false);
insert into payments (tickets_id, customers_id, total, is_onsite) values (7, 7, 4.44, true);

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
insert into is_displayed (rooms_id, sessions_id) values (13, 13);
insert into is_displayed (rooms_id, sessions_id) values (14, 14);
insert into is_displayed (rooms_id, sessions_id) values (15, 15);
insert into is_displayed (rooms_id, sessions_id) values (16, 16);
insert into is_displayed (rooms_id, sessions_id) values (17, 17);
insert into is_displayed (rooms_id, sessions_id) values (18, 18);
insert into is_displayed (rooms_id, sessions_id) values (19, 19);
insert into is_displayed (rooms_id, sessions_id) values (20, 20);

/*data insertion for programmed*/
insert into programmed (movies_id, sessions_id) values (1, 1);
insert into programmed (movies_id, sessions_id) values (2, 2);
insert into programmed (movies_id, sessions_id) values (3, 3);
insert into programmed (movies_id, sessions_id) values (4, 4);
insert into programmed (movies_id, sessions_id) values (5, 5);
insert into programmed (movies_id, sessions_id) values (6, 6);
insert into programmed (movies_id, sessions_id) values (7, 7);
insert into programmed (movies_id, sessions_id) values (8, 8);
insert into programmed (movies_id, sessions_id) values (9, 9);
insert into programmed (movies_id, sessions_id) values (10, 10);

/*data insertion for changes_to_movies*/
insert into changes_to_movies (movies_id, admin_id) values (1, 1);
insert into changes_to_movies (movies_id, admin_id) values (2, 2);
insert into changes_to_movies (movies_id, admin_id) values (3, 3);
insert into changes_to_movies (movies_id, admin_id) values (4, 4);
insert into changes_to_movies (movies_id, admin_id) values (5, 5);
insert into changes_to_movies (movies_id, admin_id) values (6, 6);
insert into changes_to_movies (movies_id, admin_id) values (7, 7);
insert into changes_to_movies (movies_id, admin_id) values (8, 8);
insert into changes_to_movies (movies_id, admin_id) values (9, 9);
insert into changes_to_movies (movies_id, admin_id) values (10, 10);
insert into changes_to_movies (movies_id, admin_id) values (11, 11);
insert into changes_to_movies (movies_id, admin_id) values (12, 12);
insert into changes_to_movies (movies_id, admin_id) values (13, 13);
insert into changes_to_movies (movies_id, admin_id) values (14, 14);
insert into changes_to_movies (movies_id, admin_id) values (15, 15);