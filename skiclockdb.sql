CREATE TABLE IF NOT EXISTS SKIS (
  ski_id INT(30) NOT NULL,
  length INT(10) NOT NULL,
  serial_number INT(30) NOT NULL,
  manufacturer VARCHAR(30) NOT NULL,
  model VARCHAR(30) NOT NULL,
  binding VARCHAR(20) NOT NULL,
  skis_out BOOLEAN DEFAULT FALSE,
  PRIMARY KEY(ski_id)
);

CREATE TABLE IF NOT EXISTS TESTS (
  test_id INT(30) NOT NULL AUTO_INCREMENT,
  ski_id INT(30) NOT NULL,
  test_skier_code VARCHAR(10) NOT NULL,
  test_boot_sole_length Int(30) NOT NULL,
  min_toe INT(10) NOT NULL,
  max_toe INT(10) NOT NULL,
  min_heel INT(10) NOT NULL,
  max_hell INT(10) NOT NULL,
  left_toe BOOLEAN,
  left_heel BOOLEAN,
  right_toe BOOLEAN,
  right_heel BOOLEAN,
  PRIMARY KEY(test_id)
);

CREATE TABLE IF NOT EXISTS CUSTOMER (
  customer_id INT(30) NOT NULL AUTO_INCREMENT,
  first_name VARCHAR(30) NOT NULL,
  last_name VARCHAR(30) NOT NULL,
  address VARCHAR(60) NOT NULL,
  city VARCHAR(60) NOT NULL,
  state VARCHAR(30) NOT NULL,
  zip_code VARCHAR(15) NOT NULL,
  email VARCHAR(30) NOT NULL,
  phone VARCHAR(30) NOT NULL,
  passwor VARCHAR(30),
  drivers_license VARCHAR(60),
  credit_card VARCHAR(60),
  PRIMARY KEY(customer_id)
);

CREATE TABLE IF NOT EXISTS SKIER_INFO (
  skier_id INT(30) NOT NULL AUTO_INCREMENT,
  customer_id INT(30) NOT NULL,
  first_name VARCHAR(30) NOT NULL,
  last_name VARCHAR(30) NOT NULL,
  height INT(30) NOT NULL,
  weight INT(30) NOT NULL,
  age INT(15) NOT NULL,
  skier_type INT(15) NOT NULL,
  PRIMARY KEY(skier_id)
);

CREATE TABLE IF NOT EXISTS SKIER_SETTINGS (
  settings_id INT(30) NOT NULL AUTO_INCREMENT,
  skier_id INT(30) NOT NULL,
  boot_sole_length INT(30),
  skier_code VARCHAR(10),
  reccomended_din FLOAT(15),
  actual_din FLOAT(15),
  latest_settings BOOLEAN DEFAULT TRUE,
  PRIMARY KEY(settings_id)
);

CREATE TABLE IF NOT EXISTS SKIER_EQUIPMENT (
  skier_equipment_id INT(30) NOT NULL AUTO_INCREMENT,
  skier_id INT(30),
  ski_id INT(30),
  skis_returned VARCHAR(30),
  boot_id INT(30),
  boots_returned VARCHAR(30),
  helmet_id INT(30),
  helmet_returned VARCHAR(30),
  signature VARCHAR(60),
  current_equipment BOOLEAN DEFAULT TRUE,
  latest_equipment BOOLEAN DEAFAULT TRUE,
  PRIMARY KEY(skier_equipment_id)
);

CREATE TABLE IF NOT EXISTS BOOTS(
  boot_id INT(30) NOT NULL,
  manufacturer VARCHAR(30) NOT NULL,
  model VARCHAR(30) NOT NULL,
  size FLOAT(15) NOT NULL,
  sole_length INT(30) NOT NULL,
  boots_out BOOLEAN DEFAULT TRUE,
  PRIMARY KEY(boot_id)
);

CREATE TABLE IF NOT EXISTS HELMET(
  helmet_id INT(30) NOT NULL,
  size VARCHAR(15) NOT NULL,
  color VARCHAR(30) NOT NULL,
  helmet_out BOOLEAN DEFAULT FALSE,
  PRIMARY KEY(helmet_id)
);

CREATE TABLE IF NOT EXISTS RENTALS(
  rental_id INT(30) NOT NULL AUTO_INCREMENT,
  customer_id INT(30) NOT NULL,
  date_out VARCHAR(30),
  due_date VARCHAR(30),
  date_in VARCHAR(30),
  total_skiers INT(30) DEFAULT 0,
  skiers_picked_up INT(30) DEFAULT 0,
  skiers_returned INT(30) DEFAULT 0,
  current_rental BOOLEAN DEFAULT TRUE,
  overdue BOOLEAN DEFAULT FALSE,
  PRIMARY KEY(rental_id)
);

CREATE TABLE IF NOT EXISTS RENTALS_HAS_SKIERS(
  rentals_has_skiers_id INT(30) NOT NULL AUTO_INCREMENT,
  skier_id INT(30),
  rental_id INT(30),
  PRIMARY KEY(rentals_has_skiers_id)
);

CREATE TABLE IF NOT EXISTS EMPLOYEE(
  employee_id INT(30) NOT NULL AUTO_INCREMENT,
  first_name VARCHAR(30),
  last_name VARCHAR(30),
  email VARCHAR(30),
  password VARCHAR(30),
  PRIMARY KEY(employee_id)
);


ALTER TABLE TESTS ADD CONSTRAINT FOREIGN KEY(ski_id) REFERENCES SKIS(ski_id);
ALTER TABLE SKIER_INFO ADD CONSTRAINT FOREIGN KEY(customer_id) REFERENCES CUSTOMER(customer_id);
ALTER TABLE SKIER_SETTINGS ADD CONSTRAINT FOREIGN KEY(skier_id) REFERENCES SKIER_INFO(skier_id);
ALTER TABLE SKIER_EQUIPMENT ADD CONSTRAINT FOREIGN KEY(skier_id) REFERENCES SKIER_INFO(skier_id);
ALTER TABLE SKIER_EQUIPMENT ADD CONSTRAINT FOREIGN KEY(ski_id) REFERENCES SKIS(ski_id);
ALTER TABLE SKIER_EQUIPMENT ADD CONSTRAINT FOREIGN KEY(boot_id) REFERENCES BOOTS(boot_id);
ALTER TABLE SKIER_EQUIPMENT ADD CONSTRAINT FOREIGN KEY(helmet_id) REFERENCES HELMET(helmet_id);
ALTER TABLE RENTALS ADD CONSTRAINT FOREIGN KEY(customer_id) REFERENCES CUSTOMER(customer_id);
ALTER TABLE RENTALS_HAS_SKIERS ADD CONSTRAINT FOREIGN KEY(skier_id) REFERENCES SKIER_INFO(skier_id);
ALTER TABLE RENTALS_HAS_SKIERS ADD CONSTRAINT FOREIGN KEY(rental_id) REFERENCES RENTALS(rental_id);

INSERT INTO SKIS(ski_id, length, serial_number, manufacturer, model, binding, skis_out) VALUES (019001, 163, 012445678, "K2", "ikonic", "Z2", FALSE);
INSERT INTO SKIS(ski_id, length, serial_number, manufacturer, model, binding, skis_out) VALUES (019002, 170, 012445679, "K2", "ikonic", "Z2", FALSE);
INSERT INTO SKIS(ski_id, length, serial_number, manufacturer, model, binding, skis_out) VALUES (019003, 120, 012445680, "K2", "Rustler", "Marker 7.0", FALSE);
INSERT INTO SKIS(ski_id, length, serial_number, manufacturer, model, binding, skis_out) VALUES (019004, 172, 014445600, "Rossignol", "Soul7", "Z2", FALSE);
INSERT INTO SKIS(ski_id, length, serial_number, manufacturer, model, binding, skis_out) VALUES (019005, 177, 014445601, "Rossignol", "Soul7", "Z2", TRUE);
INSERT INTO SKIS(ski_id, length, serial_number, manufacturer, model, binding, skis_out) VALUES (019006, 188, 014445602, "Rossignol", "Soul7", "Z2", TRUE);



INSERT INTO TESTS(ski_id, left_toe, left_heel, right_toe, right_heel) VALUES (019001, TRUE, TRUE, TRUE, TRUE);
INSERT INTO TESTS(ski_id, left_toe, left_heel, right_toe, right_heel) VALUES (019004, TRUE, TRUE, TRUE, TRUE);
INSERT INTO TESTS(ski_id, left_toe, left_heel, right_toe, right_heel) VALUES (019002, TRUE, TRUE, TRUE, TRUE);


INSERT INTO CUSTOMER(first_name, last_name, address, city, state, zip_code, email, phone) VALUES ("Ian", "Sime", "848 E Bryan Ave", "Salt Lake City", "UT", "84105", "irs333@hotmail.com", "4357140728");
INSERT INTO CUSTOMER(first_name, last_name, address, city, state, zip_code, email, phone) VALUES ("Kolton", "Atkinson", "848 E Bryan Ave", "Salt Lake City", "UT", "84105", "atkinsonkolton8@gmail.com", "4356407432");
INSERT INTO CUSTOMER(first_name, last_name, address, city, state, zip_code, email, phone) VALUES ("Vicki", "Sime", "3890 Silver Spur Cir", "Park City", "84098", "UT", "v_sime@hotmail.com", "4359010192");


INSERT INTO SKIER_INFO(customer_id, first_name, height, weight, age, skier_type) VALUES (3, "Kolton", 70, 160, 22, 3);
INSERT INTO SKIER_INFO(customer_id, first_name, height, weight, age, skier_type) VALUES (1, "Ian", 72, 260, 21, 3);
INSERT INTO SKIER_INFO(customer_id, first_name, height, weight, age, skier_type) VALUES (1, "Daisy", 68, 130, 22, 1);
INSERT INTO SKIER_INFO(customer_id, first_name, height, weight, age, skier_type) VALUES (1, "Chase", 74, 180, 22, 2);
INSERT INTO SKIER_INFO(customer_id, first_name, height, weight, age, skier_type) VALUES (2, "David", 70, 200, 52, 2);
INSERT INTO SKIER_INFO(customer_id, first_name, height, weight, age, skier_type) VALUES (2, "Cole", 48, 90, 7, 2);


INSERT INTO SKIER_SETTINGS(skier_id, boot_sole_length, skier_code, reccomended_din, actual_din) VALUES (1, 276, "G", 6.0, 6.0);
INSERT INTO SKIER_SETTINGS(skier_id, boot_sole_length, skier_code, reccomended_din, actual_din) VALUES (2, 305, "M", 8.5, 8.5);
INSERT INTO SKIER_SETTINGS(skier_id, boot_sole_length, skier_code, reccomended_din, actual_din) VALUES (3, 256, "J", 5.0, 5.0);
INSERT INTO SKIER_SETTINGS(skier_id, boot_sole_length, skier_code, reccomended_din, actual_din) VALUES (4, 305, "L", 7.0, 7.0);
INSERT INTO SKIER_SETTINGS(skier_id, boot_sole_length, skier_code, reccomended_din, actual_din) VALUES (5, 276, "K", 6.5, 6.5);
INSERT INTO SKIER_SETTINGS(skier_id, boot_sole_length, skier_code, reccomended_din, actual_din) VALUES (6, 235, "C", 1.5, 1.5);


INSERT INTO BOOTS(boot_id, manufacturer, model, size, sole_length, boots_out) VALUES (019020, "Rossingnol", "ALL_Track", 27.5, 276, FALSE);
INSERT INTO BOOTS(boot_id, manufacturer, model, size, sole_length, boots_out) VALUES (019021, "Rossingnol", "ALL_Track", 26.5, 276, FALSE);
INSERT INTO BOOTS(boot_id, manufacturer, model, size, sole_length, boots_out) VALUES (019022, "Salomon", "All-Pro", 25.5, 256, FALSE);
INSERT INTO BOOTS(boot_id, manufacturer, model, size, sole_length, boots_out) VALUES (019023, "Salomon", "All-Pro", 28.5, 305, FALSE);
INSERT INTO BOOTS(boot_id, manufacturer, model, size, sole_length, boots_out) VALUES (019024, "Salomon", "T-3", 22.5, 235, FALSE);
INSERT INTO BOOTS(boot_id, manufacturer, model, size, sole_length, boots_out) VALUES (019025, "Dabello", "Vantage", 28.5, 305, FALSE);


INSERT INTO HELMET(helmet_id, size, color, helmet_out) VALUES (019050, "M", "Gray", FALSE);
INSERT INTO HELMET(helmet_id, size, color, helmet_out) VALUES (019051, "L", "Black", FALSE);
INSERT INTO HELMET(helmet_id, size, color, helmet_out) VALUES (019052, "S", "Green", FALSE);


INSERT INTO RENTALS(customer_id, signature, date_out, date_in) VALUES (1, "N/A", "N/A", "N/A");
INSERT INTO RENTALS(customer_id, signature, date_out, date_in) VALUES (2, "N/A", "N/A", "N/A");
INSERT INTO RENTALS(customer_id, signature, date_out, date_in) VALUES (3, "N/A", "N/A", "N/A");


INSERT INTO RENTALS_HAS_SKIERS(skier_id, rental_id) VALUES (2, 1);
INSERT INTO RENTALS_HAS_SKIERS(skier_id, rental_id) VALUES (3, 1);
INSERT INTO RENTALS_HAS_SKIERS(skier_id, rental_id) VALUES (4, 1);
INSERT INTO RENTALS_HAS_SKIERS(skier_id, rental_id) VALUES (5, 2);
INSERT INTO RENTALS_HAS_SKIERS(skier_id, rental_id) VALUES (6, 2);
INSERT INTO RENTALS_HAS_SKIERS(skier_id, rental_id) VALUES (1, 3);


INSERT INTO SKIER_EQUIPMENT(skier_id, ski_id, boot_id, helmet_id) VALUES (1, 019002, 019020, 019050);
INSERT INTO SKIER_EQUIPMENT(skier_id, ski_id, boot_id, helmet_id) VALUES (2, 019006, 019023, 019051);
INSERT INTO SKIER_EQUIPMENT(skier_id, ski_id, boot_id, helmet_id) VALUES (3, 019001, 019022, 019052);
INSERT INTO SKIER_EQUIPMENT(skier_id, ski_id, boot_id) VALUES (4, 019005, 019025);
INSERT INTO SKIER_EQUIPMENT(skier_id, ski_id, boot_id) VALUES (5, 019004, 019021);
INSERT INTO SKIER_EQUIPMENT(skier_id, ski_id, boot_id) VALUES (6, 019003, 019024);
INSERT INTO SKIER_EQUIPMENT(skier_id, ski_id, boot_id, current_equipment) VALUES (4, 019002, 019025, TRUE);

INSERT INTO SKIS(ski_id, length, serial_number, manufacturer, model, binding, skis_out) VALUES (190007, 165, 014447602, "Blizzard", "Black Pearl", "Z2", FALSE);
INSERT INTO SKIS(ski_id, length, serial_number, manufacturer, model, binding, skis_out) VALUES (190008, 165, 014447603, "Blizzard", "Black Pearl", "Z2", FALSE);
INSERT INTO SKIS(ski_id, length, serial_number, manufacturer, model, binding, skis_out) VALUES (190009, 165, 014447604, "Blizzard", "Black Pearl", "Z2", FALSE);
INSERT INTO SKIS(ski_id, length, serial_number, manufacturer, model, binding, skis_out) VALUES (190010, 159, 014447605, "Blizzard", "Black Pearl", "Z2", FALSE);
INSERT INTO SKIS(ski_id, length, serial_number, manufacturer, model, binding, skis_out) VALUES (190011, 159, 014447606, "Blizzard", "Black Pearl", "Z2", FALSE);
INSERT INTO SKIS(ski_id, length, serial_number, manufacturer, model, binding, skis_out) VALUES (190012, 159, 014447607, "Blizzard", "Black Pearl", "Z2", FALSE);
INSERT INTO SKIS(ski_id, length, serial_number, manufacturer, model, binding, skis_out) VALUES (190013, 163, 014447608, "Blizzard", "Black Pearl", "Z2", FALSE);
INSERT INTO SKIS(ski_id, length, serial_number, manufacturer, model, binding, skis_out) VALUES (190014, 163, 014447609, "Blizzard", "Black Pearl", "Z2", FALSE);
INSERT INTO SKIS(ski_id, length, serial_number, manufacturer, model, binding, skis_out) VALUES (190015, 163, 014447610, "Blizzard", "Black Pearl", "Z2", FALSE);
INSERT INTO SKIS(ski_id, length, serial_number, manufacturer, model, binding, skis_out) VALUES (190016, 163, 014447611, "Blizzard", "Brahma", "Z2", FALSE);
INSERT INTO SKIS(ski_id, length, serial_number, manufacturer, model, binding, skis_out) VALUES (190017, 163, 014447612, "Blizzard", "Brahma", "Z2", FALSE);
INSERT INTO SKIS(ski_id, length, serial_number, manufacturer, model, binding, skis_out) VALUES (190018, 170, 014447613, "Blizzard", "Brahma", "Z2", FALSE);
INSERT INTO SKIS(ski_id, length, serial_number, manufacturer, model, binding, skis_out) VALUES (190019, 170, 014447614, "Blizzard", "Brahma", "Z2", FALSE);
INSERT INTO SKIS(ski_id, length, serial_number, manufacturer, model, binding, skis_out) VALUES (190100, 170, 014447615, "Blizzard", "Brahma", "Z2", FALSE);
INSERT INTO SKIS(ski_id, length, serial_number, manufacturer, model, binding, skis_out) VALUES (190101, 177, 014447616, "Blizzard", "Brahma", "Z2", FALSE);
INSERT INTO SKIS(ski_id, length, serial_number, manufacturer, model, binding, skis_out) VALUES (190102, 177, 014447617, "Blizzard", "Brahma", "Z2", FALSE);
INSERT INTO SKIS(ski_id, length, serial_number, manufacturer, model, binding, skis_out) VALUES (190103, 177, 014447618, "Blizzard", "Brahma", "Z2", FALSE);
INSERT INTO SKIS(ski_id, length, serial_number, manufacturer, model, binding, skis_out) VALUES (190104, 180, 014447619, "Blizzard", "Brahma", "Z2", FALSE);
INSERT INTO SKIS(ski_id, length, serial_number, manufacturer, model, binding, skis_out) VALUES (190105, 180, 014447620, "Blizzard", "Brahma", "Z2", FALSE);
INSERT INTO SKIS(ski_id, length, serial_number, manufacturer, model, binding, skis_out) VALUES (190106, 180, 014447621, "Blizzard", "Brahma", "Z2", FALSE);
INSERT INTO SKIS(ski_id, length, serial_number, manufacturer, model, binding, skis_out) VALUES (190107, 185, 014447622, "Blizzard", "Brahma", "Z2", FALSE);
INSERT INTO SKIS(ski_id, length, serial_number, manufacturer, model, binding, skis_out) VALUES (190108, 185, 014447623, "Blizzard", "Brahma", "Z2", FALSE);
INSERT INTO SKIS(ski_id, length, serial_number, manufacturer, model, binding, skis_out) VALUES (190109, 185, 014447624, "Blizzard", "Brahma", "Z2", FALSE);
INSERT INTO SKIS(ski_id, length, serial_number, manufacturer, model, binding, skis_out) VALUES (190110, 163, 014447625, "Blizzard", "Bonafide", "Z2", FALSE);
INSERT INTO SKIS(ski_id, length, serial_number, manufacturer, model, binding, skis_out) VALUES (190111, 163, 014447626, "Blizzard", "Bonafide", "Z2", FALSE);
INSERT INTO SKIS(ski_id, length, serial_number, manufacturer, model, binding, skis_out) VALUES (190112, 163, 014447627, "Blizzard", "Bonafide", "Z2", FALSE);
INSERT INTO SKIS(ski_id, length, serial_number, manufacturer, model, binding, skis_out) VALUES (190113, 163, 014447628, "Blizzard", "Bonafide", "Z2", FALSE);
INSERT INTO SKIS(ski_id, length, serial_number, manufacturer, model, binding, skis_out) VALUES (190114, 170, 014447629, "Blizzard", "Bonafide", "Z2", FALSE);
INSERT INTO SKIS(ski_id, length, serial_number, manufacturer, model, binding, skis_out) VALUES (190115, 170, 014447630, "Blizzard", "Bonafide", "Z2", FALSE);
INSERT INTO SKIS(ski_id, length, serial_number, manufacturer, model, binding, skis_out) VALUES (190116, 170, 014447631, "Blizzard", "Bonafide", "Z2", FALSE);
INSERT INTO SKIS(ski_id, length, serial_number, manufacturer, model, binding, skis_out) VALUES (190117, 170, 014447631, "Blizzard", "Bonafide", "Z2", FALSE);
INSERT INTO SKIS(ski_id, length, serial_number, manufacturer, model, binding, skis_out) VALUES (190118, 177, 014447632, "Blizzard", "Bonafide", "Z2", FALSE);
INSERT INTO SKIS(ski_id, length, serial_number, manufacturer, model, binding, skis_out) VALUES (190119, 177, 014447633, "Blizzard", "Bonafide", "Z2", FALSE);
INSERT INTO SKIS(ski_id, length, serial_number, manufacturer, model, binding, skis_out) VALUES (190120, 177, 014447634, "Blizzard", "Bonafide", "Z2", FALSE);
INSERT INTO SKIS(ski_id, length, serial_number, manufacturer, model, binding, skis_out) VALUES (190121, 177, 014447635, "Blizzard", "Bonafide", "Z2", FALSE);
INSERT INTO SKIS(ski_id, length, serial_number, manufacturer, model, binding, skis_out) VALUES (190122, 183, 014447636, "Blizzard", "Bonafide", "Z2", FALSE);
INSERT INTO SKIS(ski_id, length, serial_number, manufacturer, model, binding, skis_out) VALUES (190124, 183, 014447637, "Blizzard", "Bonafide", "Z2", FALSE);
INSERT INTO SKIS(ski_id, length, serial_number, manufacturer, model, binding, skis_out) VALUES (190125, 183, 014447638, "Blizzard", "Bonafide", "Z2", FALSE);

INSERT INTO BOOTS(boot_id, manufacturer, model, size, sole_length, boots_out) VALUES (190021, "Rossingnol", "ALL_Track", 27.5, 276, FALSE);
INSERT INTO BOOTS(boot_id, manufacturer, model, size, sole_length, boots_out) VALUES (190022, "Rossingnol", "ALL_Track", 27.5, 276, FALSE);
INSERT INTO BOOTS(boot_id, manufacturer, model, size, sole_length, boots_out) VALUES (190023, "Rossingnol", "ALL_Track", 27.5, 276, FALSE);
INSERT INTO BOOTS(boot_id, manufacturer, model, size, sole_length, boots_out) VALUES (190024, "Rossingnol", "ALL_Track", 27.5, 276, FALSE);
INSERT INTO BOOTS(boot_id, manufacturer, model, size, sole_length, boots_out) VALUES (190025, "Rossingnol", "ALL_Track", 27.5, 276, FALSE);
INSERT INTO BOOTS(boot_id, manufacturer, model, size, sole_length, boots_out) VALUES (190026, "Rossingnol", "ALL_Track", 27.5, 276, FALSE);
INSERT INTO BOOTS(boot_id, manufacturer, model, size, sole_length, boots_out) VALUES (190027, "Rossingnol", "ALL_Track", 26.5, 276, FALSE);
INSERT INTO BOOTS(boot_id, manufacturer, model, size, sole_length, boots_out) VALUES (190028, "Rossingnol", "ALL_Track", 26.5, 276, FALSE);
INSERT INTO BOOTS(boot_id, manufacturer, model, size, sole_length, boots_out) VALUES (190029, "Rossingnol", "ALL_Track", 26.5, 276, FALSE);
INSERT INTO BOOTS(boot_id, manufacturer, model, size, sole_length, boots_out) VALUES (190030, "Rossingnol", "ALL_Track", 26.5, 276, FALSE);
INSERT INTO BOOTS(boot_id, manufacturer, model, size, sole_length, boots_out) VALUES (190031, "Rossingnol", "ALL_Track", 26.5, 276, FALSE);
INSERT INTO BOOTS(boot_id, manufacturer, model, size, sole_length, boots_out) VALUES (190032, "Rossingnol", "ALL_Track", 26.5, 276, FALSE);
INSERT INTO BOOTS(boot_id, manufacturer, model, size, sole_length, boots_out) VALUES (190033, "Rossingnol", "ALL_Track", 26.5, 276, FALSE);
INSERT INTO BOOTS(boot_id, manufacturer, model, size, sole_length, boots_out) VALUES (190034, "Rossingnol", "ALL_Track", 26.5, 276, FALSE);
INSERT INTO BOOTS(boot_id, manufacturer, model, size, sole_length, boots_out) VALUES (190035, "Rossingnol", "ALL_Track", 26.5, 276, FALSE);
INSERT INTO BOOTS(boot_id, manufacturer, model, size, sole_length, boots_out) VALUES (190036, "Rossingnol", "ALL_Track", 28.5, 285, FALSE);
INSERT INTO BOOTS(boot_id, manufacturer, model, size, sole_length, boots_out) VALUES (190037, "Rossingnol", "ALL_Track", 28.5, 285, FALSE);
INSERT INTO BOOTS(boot_id, manufacturer, model, size, sole_length, boots_out) VALUES (190038, "Rossingnol", "ALL_Track", 28.5, 285, FALSE);
INSERT INTO BOOTS(boot_id, manufacturer, model, size, sole_length, boots_out) VALUES (190039, "Rossingnol", "ALL_Track", 28.5, 285, FALSE);
INSERT INTO BOOTS(boot_id, manufacturer, model, size, sole_length, boots_out) VALUES (190040, "Rossingnol", "ALL_Track", 28.5, 285, FALSE);
INSERT INTO BOOTS(boot_id, manufacturer, model, size, sole_length, boots_out) VALUES (190041, "Rossingnol", "ALL_Track", 28.5, 285, FALSE);
INSERT INTO BOOTS(boot_id, manufacturer, model, size, sole_length, boots_out) VALUES (190042, "Rossingnol", "ALL_Track", 28.5, 285, FALSE);
INSERT INTO BOOTS(boot_id, manufacturer, model, size, sole_length, boots_out) VALUES (190043, "Rossingnol", "ALL_Track", 28.5, 285, FALSE);
INSERT INTO BOOTS(boot_id, manufacturer, model, size, sole_length, boots_out) VALUES (190044, "Rossingnol", "ALL_Track", 28.5, 285, FALSE);
INSERT INTO BOOTS(boot_id, manufacturer, model, size, sole_length, boots_out) VALUES (190045, "Rossingnol", "ALL_Track", 28.5, 285, FALSE);
INSERT INTO BOOTS(boot_id, manufacturer, model, size, sole_length, boots_out) VALUES (190046, "Rossingnol", "ALL_Track", 29.5, 305, FALSE);
INSERT INTO BOOTS(boot_id, manufacturer, model, size, sole_length, boots_out) VALUES (190047, "Rossingnol", "ALL_Track", 29.5, 305, FALSE);
INSERT INTO BOOTS(boot_id, manufacturer, model, size, sole_length, boots_out) VALUES (190048, "Rossingnol", "ALL_Track", 29.5, 305, FALSE);
INSERT INTO BOOTS(boot_id, manufacturer, model, size, sole_length, boots_out) VALUES (190049, "Rossingnol", "ALL_Track", 29.5, 305, FALSE);
INSERT INTO BOOTS(boot_id, manufacturer, model, size, sole_length, boots_out) VALUES (190050, "Rossingnol", "ALL_Track", 29.5, 305, FALSE);
INSERT INTO BOOTS(boot_id, manufacturer, model, size, sole_length, boots_out) VALUES (190051, "Solomon", "ALL_Pro", 29.5, 305, FALSE);
INSERT INTO BOOTS(boot_id, manufacturer, model, size, sole_length, boots_out) VALUES (190052, "Solomon", "ALL_Pro", 29.5, 305, FALSE);
INSERT INTO BOOTS(boot_id, manufacturer, model, size, sole_length, boots_out) VALUES (190053, "Solomon", "ALL_Pro", 29.5, 305, FALSE);
INSERT INTO BOOTS(boot_id, manufacturer, model, size, sole_length, boots_out) VALUES (190054, "Solomon", "ALL_Pro", 29.5, 305, FALSE);
INSERT INTO BOOTS(boot_id, manufacturer, model, size, sole_length, boots_out) VALUES (190055, "Solomon", "ALL_Pro", 29.5, 305, FALSE);
INSERT INTO BOOTS(boot_id, manufacturer, model, size, sole_length, boots_out) VALUES (190056, "Solomon", "ALL_Pro", 29.5, 305, FALSE);
INSERT INTO BOOTS(boot_id, manufacturer, model, size, sole_length, boots_out) VALUES (190057, "Solomon", "ALL_Pro", 29.5, 305, FALSE);
INSERT INTO BOOTS(boot_id, manufacturer, model, size, sole_length, boots_out) VALUES (190058, "Solomon", "ALL_Pro", 24.5, 245, FALSE);
INSERT INTO BOOTS(boot_id, manufacturer, model, size, sole_length, boots_out) VALUES (190059, "Solomon", "ALL_Pro", 24.5, 245, FALSE);
INSERT INTO BOOTS(boot_id, manufacturer, model, size, sole_length, boots_out) VALUES (190060, "Solomon", "ALL_Pro", 24.5, 245, FALSE);
INSERT INTO BOOTS(boot_id, manufacturer, model, size, sole_length, boots_out) VALUES (190061, "Solomon", "ALL_Pro", 24.5, 245, FALSE);
INSERT INTO BOOTS(boot_id, manufacturer, model, size, sole_length, boots_out) VALUES (190062, "Solomon", "ALL_Pro", 24.5, 245, FALSE);
INSERT INTO BOOTS(boot_id, manufacturer, model, size, sole_length, boots_out) VALUES (190063, "Solomon", "ALL_Pro", 24.5, 245, FALSE);
INSERT INTO BOOTS(boot_id, manufacturer, model, size, sole_length, boots_out) VALUES (190064, "Solomon", "ALL_Pro", 24.5, 245, FALSE);
INSERT INTO BOOTS(boot_id, manufacturer, model, size, sole_length, boots_out) VALUES (190065, "Solomon", "ALL_Pro", 24.5, 245, FALSE);
INSERT INTO BOOTS(boot_id, manufacturer, model, size, sole_length, boots_out) VALUES (190066, "Solomon", "ALL_Pro", 25.5, 253, FALSE);
INSERT INTO BOOTS(boot_id, manufacturer, model, size, sole_length, boots_out) VALUES (190067, "Solomon", "ALL_Pro", 25.5, 253, FALSE);
INSERT INTO BOOTS(boot_id, manufacturer, model, size, sole_length, boots_out) VALUES (190068, "Solomon", "ALL_Pro", 25.5, 253, FALSE);
INSERT INTO BOOTS(boot_id, manufacturer, model, size, sole_length, boots_out) VALUES (190069, "Solomon", "ALL_Pro", 25.5, 253, FALSE);
INSERT INTO BOOTS(boot_id, manufacturer, model, size, sole_length, boots_out) VALUES (190070, "Solomon", "ALL_Pro", 25.5, 253, FALSE);
INSERT INTO BOOTS(boot_id, manufacturer, model, size, sole_length, boots_out) VALUES (190071, "Solomon", "ALL_Pro", 25.5, 253, FALSE);
INSERT INTO BOOTS(boot_id, manufacturer, model, size, sole_length, boots_out) VALUES (190072, "Solomon", "ALL_Pro", 25.5, 253, FALSE);
INSERT INTO BOOTS(boot_id, manufacturer, model, size, sole_length, boots_out) VALUES (190073, "Solomon", "ALL_Pro", 25.5, 253, FALSE);
INSERT INTO BOOTS(boot_id, manufacturer, model, size, sole_length, boots_out) VALUES (190074, "Solomon", "ALL_Pro", 25.5, 253, FALSE);
INSERT INTO BOOTS(boot_id, manufacturer, model, size, sole_length, boots_out) VALUES (190075, "Solomon", "ALL_Pro", 25.5, 253, FALSE);
INSERT INTO BOOTS(boot_id, manufacturer, model, size, sole_length, boots_out) VALUES (190076, "Solomon", "ALL_Pro", 26.5, 265, FALSE);
INSERT INTO BOOTS(boot_id, manufacturer, model, size, sole_length, boots_out) VALUES (190077, "Solomon", "ALL_Pro", 26.5, 265, FALSE);
INSERT INTO BOOTS(boot_id, manufacturer, model, size, sole_length, boots_out) VALUES (190078, "Solomon", "ALL_Pro", 26.5, 265, FALSE);
INSERT INTO BOOTS(boot_id, manufacturer, model, size, sole_length, boots_out) VALUES (190079, "Solomon", "ALL_Pro", 26.5, 265, FALSE);
INSERT INTO BOOTS(boot_id, manufacturer, model, size, sole_length, boots_out) VALUES (190080, "Solomon", "ALL_Pro", 26.5, 265, FALSE);
INSERT INTO BOOTS(boot_id, manufacturer, model, size, sole_length, boots_out) VALUES (190081, "Solomon", "ALL_Pro", 26.5, 265, FALSE);

INSERT INTO HELMET(helmet_id, size, color, helmet_out) VALUES (190653, "S", "Green", FALSE);
INSERT INTO HELMET(helmet_id, size, color, helmet_out) VALUES (190654, "S", "Green", FALSE);
INSERT INTO HELMET(helmet_id, size, color, helmet_out) VALUES (190655, "S", "Green", FALSE);
INSERT INTO HELMET(helmet_id, size, color, helmet_out) VALUES (190656, "S", "Green", FALSE);
INSERT INTO HELMET(helmet_id, size, color, helmet_out) VALUES (190657, "S", "Green", FALSE);
INSERT INTO HELMET(helmet_id, size, color, helmet_out) VALUES (190658, "S", "Green", FALSE);
INSERT INTO HELMET(helmet_id, size, color, helmet_out) VALUES (190659, "S", "Green", FALSE);
INSERT INTO HELMET(helmet_id, size, color, helmet_out) VALUES (190660, "S", "Gray", FALSE);
INSERT INTO HELMET(helmet_id, size, color, helmet_out) VALUES (190661, "S", "Gray", FALSE);
INSERT INTO HELMET(helmet_id, size, color, helmet_out) VALUES (190662, "S", "Gray", FALSE);
INSERT INTO HELMET(helmet_id, size, color, helmet_out) VALUES (190663, "S", "Gray", FALSE);
INSERT INTO HELMET(helmet_id, size, color, helmet_out) VALUES (190664, "S", "Gray", FALSE);
INSERT INTO HELMET(helmet_id, size, color, helmet_out) VALUES (190665, "S", "Gray", FALSE);
INSERT INTO HELMET(helmet_id, size, color, helmet_out) VALUES (190666, "S", "Gray", FALSE);
INSERT INTO HELMET(helmet_id, size, color, helmet_out) VALUES (190667, "S", "Gray", FALSE);
INSERT INTO HELMET(helmet_id, size, color, helmet_out) VALUES (190668, "S", "Gray", FALSE);
INSERT INTO HELMET(helmet_id, size, color, helmet_out) VALUES (190669, "S", "Gray", FALSE);
INSERT INTO HELMET(helmet_id, size, color, helmet_out) VALUES (190670, "S", "Gray", FALSE);
INSERT INTO HELMET(helmet_id, size, color, helmet_out) VALUES (190671, "S", "Gray", FALSE);
INSERT INTO HELMET(helmet_id, size, color, helmet_out) VALUES (190672, "S", "Gray", FALSE);
INSERT INTO HELMET(helmet_id, size, color, helmet_out) VALUES (190672, "M", "Gray", FALSE);
INSERT INTO HELMET(helmet_id, size, color, helmet_out) VALUES (190674, "M", "Gray", FALSE);
INSERT INTO HELMET(helmet_id, size, color, helmet_out) VALUES (190675, "M", "Gray", FALSE);
INSERT INTO HELMET(helmet_id, size, color, helmet_out) VALUES (190676, "M", "Gray", FALSE);
INSERT INTO HELMET(helmet_id, size, color, helmet_out) VALUES (190677, "M", "Gray", FALSE);
INSERT INTO HELMET(helmet_id, size, color, helmet_out) VALUES (190678, "M", "Gray", FALSE);
INSERT INTO HELMET(helmet_id, size, color, helmet_out) VALUES (190679, "M", "Gray", FALSE);
INSERT INTO HELMET(helmet_id, size, color, helmet_out) VALUES (190680, "M", "Gray", FALSE);
INSERT INTO HELMET(helmet_id, size, color, helmet_out) VALUES (190681, "M", "Gray", FALSE);
INSERT INTO HELMET(helmet_id, size, color, helmet_out) VALUES (190682, "M", "Gray", FALSE);
INSERT INTO HELMET(helmet_id, size, color, helmet_out) VALUES (190683, "M", "Gray", FALSE);
INSERT INTO HELMET(helmet_id, size, color, helmet_out) VALUES (190684, "M", "Gray", FALSE);
INSERT INTO HELMET(helmet_id, size, color, helmet_out) VALUES (190685, "M", "Gray", FALSE);
INSERT INTO HELMET(helmet_id, size, color, helmet_out) VALUES (190686, "M", "Gray", FALSE);
INSERT INTO HELMET(helmet_id, size, color, helmet_out) VALUES (190687, "M", "Gray", FALSE);
INSERT INTO HELMET(helmet_id, size, color, helmet_out) VALUES (190688, "M", "Gray", FALSE);
INSERT INTO HELMET(helmet_id, size, color, helmet_out) VALUES (190689, "M", "Gray", FALSE);
INSERT INTO HELMET(helmet_id, size, color, helmet_out) VALUES (190690, "M", "Gray", FALSE);
INSERT INTO HELMET(helmet_id, size, color, helmet_out) VALUES (190691, "M", "Gray", FALSE);
INSERT INTO HELMET(helmet_id, size, color, helmet_out) VALUES (190682, "L", "Black", FALSE);
INSERT INTO HELMET(helmet_id, size, color, helmet_out) VALUES (190683, "L", "Black", FALSE);
INSERT INTO HELMET(helmet_id, size, color, helmet_out) VALUES (190684, "L", "Black", FALSE);
INSERT INTO HELMET(helmet_id, size, color, helmet_out) VALUES (190685, "L", "Black", FALSE);
INSERT INTO HELMET(helmet_id, size, color, helmet_out) VALUES (190686, "L", "Black", FALSE);
INSERT INTO HELMET(helmet_id, size, color, helmet_out) VALUES (190687, "L", "Black", FALSE);
INSERT INTO HELMET(helmet_id, size, color, helmet_out) VALUES (190688, "L", "Black", FALSE);
INSERT INTO HELMET(helmet_id, size, color, helmet_out) VALUES (190689, "L", "Black", FALSE);
INSERT INTO HELMET(helmet_id, size, color, helmet_out) VALUES (190690, "L", "Black", FALSE);
INSERT INTO HELMET(helmet_id, size, color, helmet_out) VALUES (190691, "L", "Black", FALSE);
INSERT INTO HELMET(helmet_id, size, color, helmet_out) VALUES (190692, "L", "Black", FALSE);
INSERT INTO HELMET(helmet_id, size, color, helmet_out) VALUES (190693, "L", "Black", FALSE);
INSERT INTO HELMET(helmet_id, size, color, helmet_out) VALUES (190694, "L", "Black", FALSE);
INSERT INTO HELMET(helmet_id, size, color, helmet_out) VALUES (190695, "L", "Black", FALSE);
INSERT INTO HELMET(helmet_id, size, color, helmet_out) VALUES (190696, "L", "Black", FALSE);
INSERT INTO HELMET(helmet_id, size, color, helmet_out) VALUES (190697, "L", "Black", FALSE);
INSERT INTO HELMET(helmet_id, size, color, helmet_out) VALUES (190698, "L", "Black", FALSE);
INSERT INTO HELMET(helmet_id, size, color, helmet_out) VALUES (190699, "L", "Black", FALSE);
INSERT INTO HELMET(helmet_id, size, color, helmet_out) VALUES (190700, "L", "Black", FALSE);
INSERT INTO HELMET(helmet_id, size, color, helmet_out) VALUES (190701, "XL", "Black", FALSE);
INSERT INTO HELMET(helmet_id, size, color, helmet_out) VALUES (190702, "XL", "Black", FALSE);
INSERT INTO HELMET(helmet_id, size, color, helmet_out) VALUES (190703, "XL", "Black", FALSE);
INSERT INTO HELMET(helmet_id, size, color, helmet_out) VALUES (190704, "XL", "Black", FALSE);
INSERT INTO HELMET(helmet_id, size, color, helmet_out) VALUES (190705, "XL", "Black", FALSE);
INSERT INTO HELMET(helmet_id, size, color, helmet_out) VALUES (190706, "XL", "Black", FALSE);
INSERT INTO HELMET(helmet_id, size, color, helmet_out) VALUES (190707, "XL", "Black", FALSE);
INSERT INTO HELMET(helmet_id, size, color, helmet_out) VALUES (190708, "XL", "Black", FALSE);
INSERT INTO HELMET(helmet_id, size, color, helmet_out) VALUES (190709, "XL", "Black", FALSE);
INSERT INTO HELMET(helmet_id, size, color, helmet_out) VALUES (190710, "XL", "Black", FALSE);
INSERT INTO HELMET(helmet_id, size, color, helmet_out) VALUES (190711, "XL", "Black", FALSE);
INSERT INTO HELMET(helmet_id, size, color, helmet_out) VALUES (190712, "XL", "Black", FALSE);
INSERT INTO HELMET(helmet_id, size, color, helmet_out) VALUES (190713, "XL", "Black", FALSE);
INSERT INTO HELMET(helmet_id, size, color, helmet_out) VALUES (190714, "XL", "Black", FALSE);
INSERT INTO HELMET(helmet_id, size, color, helmet_out) VALUES (190715, "XL", "Black", FALSE);

INSERT INTO CUSTOMER(first_name, last_name, address, city, state, zip_code, email, phone) VALUES ("Kathy", "Smith", "1300 E 1840 S", "Salt Lake City", "UT", "84105", "kathy@email.com", "8012345672");
INSERT INTO SKIER_INFO(customer_id, first_name, last_name, height, weight, age, skier_type) VALUES (10, "Kathy", "Smith", 65, 130, 23, 2);
INSERT INTO SKIER_SETTINGS(skier_id, boot_sole_length, skier_code, reccomended_din, actual_din) VALUES (14, 276, "L", 5.0, 5.0);
INSERT INTO SKIER_EQUIPMENT(skier_id, ski_id, boot_id, helmet_id) VALUES (14, 190014, 190060, 190674);
UPDATE SKIS SET skis_out = TRUE WHERE ski_id = 190014;
UPDATE BOOTS SET boots_out = TRUE WHERE boot_id = 190060;
UPDATE HELMET SET helmet_out = TRUE WHERE helmet_id = 190674;
INSERT INTO SKIER_INFO(customer_id, first_name, last_name, height, weight, age, skier_type) VALUES (10, "Scott", "Smith", 70, 180, 25, 2);
INSERT INTO SKIER_SETTINGS(skier_id, boot_sole_length, skier_code, reccomended_din, actual_din) VALUES (15, 285, "M", 7.5, 7.5);
INSERT INTO SKIER_EQUIPMENT(skier_id, ski_id, boot_id, helmet_id) VALUES (15, 190101, 190038, 190709);
UPDATE SKIS SET skis_out = TRUE WHERE ski_id = 190101;
UPDATE BOOTS SET boots_out = TRUE WHERE boot_id = 190038;
UPDATE HELMET SET helmet_out = TRUE WHERE helmet_id = 190709;
INSERT INTO RENTALS(customer_id, date_out, due_date, total_skiers) VALUES (10, "04/17/2019", "04/20/2019", 2);
INSERT INTO RENTALS_HAS_SKIERS(skier_id, rental_id) VALUES (14, 7);
INSERT INTO RENTALS_HAS_SKIERS(skier_id, rental_id) VALUES (15, 7);

INSERT INTO CUSTOMER(first_name, last_name, address, city, state, zip_code, email, phone) VALUES ("Cole", "Smith", "1300 E 1840 S", "Salt Lake City", "UT", "84105", "colesmith@email.com", "8012245672");
INSERT INTO SKIER_INFO(customer_id, first_name, last_name, height, weight, age, skier_type) VALUES (11, "Cole", "Smith", 72, 190, 40, 2);
INSERT INTO SKIER_SETTINGS(skier_id, boot_sole_length, skier_code, reccomended_din, actual_din) VALUES (16, 305, "M", 7.0, 7.0);
INSERT INTO SKIER_EQUIPMENT(skier_id, ski_id, boot_id, helmet_id) VALUES (16, 190120, 190049, 190713);
UPDATE SKIS SET skis_out = TRUE WHERE ski_id = 190120;
UPDATE BOOTS SET boots_out = TRUE WHERE boot_id = 190049;
UPDATE HELMET SET helmet_out = TRUE WHERE helmet_id = 190713;
INSERT INTO SKIER_INFO(customer_id, first_name, last_name, height, weight, age, skier_type) VALUES (11, "Zach", "Smith", 69, 160, 24, 2);
INSERT INTO SKIER_SETTINGS(skier_id, boot_sole_length, skier_code, reccomended_din, actual_din) VALUES (17, 285, "M", 6.5, 6.5);
INSERT INTO SKIER_EQUIPMENT(skier_id, ski_id, boot_id, helmet_id) VALUES (17, 190115, 190040, 190675);
UPDATE SKIS SET skis_out = TRUE WHERE ski_id = 190115;
UPDATE BOOTS SET boots_out = TRUE WHERE boot_id = 190040;
UPDATE HELMET SET helmet_out = TRUE WHERE helmet_id = 190675;
INSERT INTO SKIER_INFO(customer_id, first_name, last_name, height, weight, age, skier_type) VALUES (11, "Claire", "Smith", 69, 160, 18, 2);
INSERT INTO SKIER_SETTINGS(skier_id, boot_sole_length, skier_code, reccomended_din, actual_din) VALUES (18, 276, "K", 5.5, 5.5);
INSERT INTO SKIER_EQUIPMENT(skier_id, ski_id, boot_id) VALUES (18, 190007, 190024);
UPDATE SKIS SET skis_out = TRUE WHERE ski_id = 190007;
UPDATE BOOTS SET boots_out = TRUE WHERE boot_id = 190024;
INSERT INTO RENTALS(customer_id, date_out, due_date, total_skiers) VALUES (11, "04/18/2019", "04/23/2019", 3);
INSERT INTO RENTALS_HAS_SKIERS(skier_id, rental_id) VALUES (16, 8);
INSERT INTO RENTALS_HAS_SKIERS(skier_id, rental_id) VALUES (17, 8);
INSERT INTO RENTALS_HAS_SKIERS(skier_id, rental_id) VALUES (18, 8);

INSERT INTO CUSTOMER(first_name, last_name, address, city, state, zip_code, email, phone) VALUES ("Andoni", "Odencrantz", "1300 E 1840 S", "Salt Lake City", "UT", "84105", "colesmith@email.com", "8012215672");
INSERT INTO SKIER_INFO(customer_id, first_name, last_name, height, weight, age, skier_type) VALUES (12, "Andoni", "Odencrantz", 71, 185, 33, 3);
INSERT INTO SKIER_SETTINGS(skier_id, boot_sole_length, skier_code, reccomended_din, actual_din) VALUES (19, 285, "M", 8.0, 8.0);
INSERT INTO SKIER_EQUIPMENT(skier_id, ski_id, boot_id, helmet_id) VALUES (19, 190118, 190042, 190681);
UPDATE SKIS SET skis_out = TRUE WHERE ski_id = 190118;
UPDATE BOOTS SET boots_out = TRUE WHERE boot_id = 190049;
UPDATE HELMET SET helmet_out = TRUE WHERE helmet_id = 190681;
INSERT INTO RENTALS(customer_id, date_out, due_date, total_skiers) VALUES (12, "04/16/2019", "04/23/2019", 1);
INSERT INTO RENTALS_HAS_SKIERS(skier_id, rental_id) VALUES (19, 9);

INSERT INTO CUSTOMER(first_name, last_name, address, city, state, zip_code, email, phone) VALUES ("Noah", "Robinson", "1300 E 1840 S", "Salt Lake City", "UT", "84105", "noharobinson@email.com", "8012115672");
INSERT INTO SKIER_INFO(customer_id, first_name, last_name, height, weight, age, skier_type) VALUES (12, "Noah", "Robinson", 71, 215, 32, 2);
INSERT INTO RENTALS(customer_id, date_out, due_date, total_skiers) VALUES (13, "04/20/2019", "04/22/2019", 1);
INSERT INTO RENTALS_HAS_SKIERS(skier_id, rental_id) VALUES (20, 10);

INSERT INTO CUSTOMER(first_name, last_name, address, city, state, zip_code, email, phone) VALUES ("Chance", "Taylor", "1300 E 1840 S", "Salt Lake City", "UT", "84105", "chancetaylor@email.com", "8012112672");
INSERT INTO SKIER_INFO(customer_id, first_name, last_name, height, weight, age, skier_type) VALUES (14, "Chance", "Taylor", 65, 180, 30, 3);
INSERT INTO SKIER_INFO(customer_id, first_name, last_name, height, weight, age, skier_type) VALUES (14, "Kyle", "Taylor", 68, 190, 30, 2);
INSERT INTO RENTALS(customer_id, date_out, due_date, total_skiers) VALUES (14, "04/17/2019", "04/22/2019", 2);
INSERT INTO RENTALS_HAS_SKIERS(skier_id, rental_id) VALUES (21, 11);
INSERT INTO RENTALS_HAS_SKIERS(skier_id, rental_id) VALUES (22, 11);

INSERT INTO CUSTOMER(first_name, last_name, address, city, state, zip_code, email, phone) VALUES ("Nick", "Tour", "1300 E 1840 S", "Salt Lake City", "UT", "84105", "nicktour@email.com", "8011112672");
INSERT INTO SKIER_INFO(customer_id, first_name, last_name, height, weight, age, skier_type) VALUES (15, "Nick", "Tour", 65, 170, 25, 3);
INSERT INTO SKIER_INFO(customer_id, first_name, last_name, height, weight, age, skier_type) VALUES (15, "Jack", "Williams", 65, 160, 30, 3);
INSERT INTO RENTALS(customer_id, date_out, due_date, total_skiers) VALUES (15, "04/17/2019", "04/22/2019", 2);
INSERT INTO RENTALS_HAS_SKIERS(skier_id, rental_id) VALUES (23, 12);
INSERT INTO RENTALS_HAS_SKIERS(skier_id, rental_id) VALUES (24, 12);

INSERT INTO CUSTOMER(first_name, last_name, address, city, state, zip_code, email, phone) VALUES ("Jordan", "Phillips", "1300 E 1840 S", "Salt Lake City", "UT", "84105", "nicktour@email.com", "8011412672");
INSERT INTO SKIER_INFO(customer_id, first_name, last_name, height, weight, age, skier_type) VALUES (16, "Jordan", "Phillips", 64, 155, 23, 1);
INSERT INTO SKIER_INFO(customer_id, first_name, last_name, height, weight, age, skier_type) VALUES (16, "Peter", "Nye", 65, 190, 24, 1);
INSERT INTO RENTALS(customer_id, date_out, due_date, total_skiers) VALUES (16, "04/17/2019", "04/20/2019", 2);
INSERT INTO RENTALS_HAS_SKIERS(skier_id, rental_id) VALUES (25, 15);
INSERT INTO RENTALS_HAS_SKIERS(skier_id, rental_id) VALUES (26, 15);

INSERT INTO CUSTOMER(first_name, last_name, address, city, state, zip_code, email, phone) VALUES ("Will", "Beutler", "1300 E 1840 S", "Salt Lake City", "UT", "84105", "nicktour@email.com", "8011482672");
INSERT INTO SKIER_INFO(customer_id, first_name, last_name, height, weight, age, skier_type) VALUES (17, "Will", "Beutler", 65, 160, 37, 3);
INSERT INTO SKIER_INFO(customer_id, first_name, last_name, height, weight, age, skier_type) VALUES (17, "Amanda", "Beutler", 62, 130, 36, 2);
INSERT INTO RENTALS(customer_id, date_out, due_date, total_skiers) VALUES (17, "04/18/2019", "04/22/2019", 2);
INSERT INTO RENTALS_HAS_SKIERS(skier_id, rental_id) VALUES (29, 16);
INSERT INTO RENTALS_HAS_SKIERS(skier_id, rental_id) VALUES (30, 16);

INSERT INTO CUSTOMER(first_name, last_name, address, city, state, zip_code, email, phone) VALUES ("Harrison", "Edwards", "1300 E 1840 S", "Salt Lake City", "UT", "84105", "nicktour@email.com", "8011482672");
INSERT INTO SKIER_INFO(customer_id, first_name, last_name, height, weight, age, skier_type) VALUES (18, "Harrison", "Edwards", 65, 160, 37, 3);
INSERT INTO SKIER_INFO(customer_id, first_name, last_name, height, weight, age, skier_type) VALUES (18, "Amanda", "Beutler", 62, 130, 36, 2);
INSERT INTO RENTALS(customer_id, date_out, due_date, total_skiers) VALUES (18, "04/18/2019", "04/22/2019", 2);
INSERT INTO RENTALS_HAS_SKIERS(skier_id, rental_id) VALUES (31, 17);
INSERT INTO RENTALS_HAS_SKIERS(skier_id, rental_id) VALUES (32, 17);

INSERT INTO CUSTOMER(first_name, last_name, address, city, state, zip_code, email, phone) VALUES ("Daniel", "Gladden", "1300 E 1840 S", "Salt Lake City", "UT", "84105", "placeholder@email.com", "8015472672");
INSERT INTO SKIER_INFO(customer_id, first_name, last_name, height, weight, age, skier_type) VALUES (19, "Daniel", "Gladden", 77, 225, 30, 1);
INSERT INTO SKIER_INFO(customer_id, first_name, last_name, height, weight, age, skier_type) VALUES (19, "Hayley", "Murdock", 66, 145, 30, 2);
INSERT INTO SKIER_INFO(customer_id, first_name, last_name, height, weight, age, skier_type) VALUES (19, "Lane", "Lier", 69, 190, 30, 3);
INSERT INTO RENTALS(customer_id, date_out, due_date, total_skiers) VALUES (19, "04/19/2019", "04/21/2019", 3);
INSERT INTO RENTALS_HAS_SKIERS(skier_id, rental_id) VALUES (37, 19);
INSERT INTO RENTALS_HAS_SKIERS(skier_id, rental_id) VALUES (38, 19);
INSERT INTO RENTALS_HAS_SKIERS(skier_id, rental_id) VALUES (39, 19);

INSERT INTO CUSTOMER(first_name, last_name, address, city, state, zip_code, email, phone) VALUES ("Greg", "Gagne", "1300 E 1840 S", "Salt Lake City", "UT", "84105", "placeholder@email.com", "8016472672");
INSERT INTO SKIER_INFO(customer_id, first_name, last_name, height, weight, age, skier_type) VALUES (20, "Greg", "Gagne", 70, 170, 45, 3);
INSERT INTO SKIER_INFO(customer_id, first_name, last_name, height, weight, age, skier_type) VALUES (20, "Hayley", "Gagne", 63, 135, 22, 3);
INSERT INTO SKIER_INFO(customer_id, first_name, last_name, height, weight, age, skier_type) VALUES (20, "Tim", "Gagne", 72, 200, 25, 3);
INSERT INTO RENTALS(customer_id, date_out, due_date, total_skiers) VALUES (21, "04/19/2019", "04/21/2019", 3);
INSERT INTO RENTALS_HAS_SKIERS(skier_id, rental_id) VALUES (40, 20);
INSERT INTO RENTALS_HAS_SKIERS(skier_id, rental_id) VALUES (41, 20);
INSERT INTO RENTALS_HAS_SKIERS(skier_id, rental_id) VALUES (42, 20);

INSERT INTO CUSTOMER(first_name, last_name, address, city, state, zip_code, email, phone) VALUES ("Braden", "Atkinson", "1300 E 1840 S", "Salt Lake City", "UT", "84105", "nicktour@email.com", "8015482672");
INSERT INTO SKIER_INFO(customer_id, first_name, last_name, height, weight, age, skier_type) VALUES (22, "Braden", "Atkinson", 70, 205, 37, 3);
INSERT INTO SKIER_INFO(customer_id, first_name, last_name, height, weight, age, skier_type) VALUES (22, "Lindsay", "Beutler", 62, 130, 36, 2);
INSERT INTO RENTALS(customer_id, date_out, due_date, total_skiers) VALUES (22, "04/18/2019", "04/22/2019", 2);
INSERT INTO RENTALS_HAS_SKIERS(skier_id, rental_id) VALUES (43, 21);
INSERT INTO RENTALS_HAS_SKIERS(skier_id, rental_id) VALUES (44, 21);

INSERT INTO CUSTOMER(first_name, last_name, address, city, state, zip_code, email, phone) VALUES ("James", "Castigla", "1300 E 1840 S", "Salt Lake City", "UT", "84105", "placeholder@email.com", "8013472672");
INSERT INTO SKIER_INFO(customer_id, first_name, last_name, height, weight, age, skier_type) VALUES (23, "James", "Castigla", 70, 210, 50, 2);
INSERT INTO RENTALS(customer_id, date_out, due_date, total_skiers) VALUES (23, "04/20/2019", "04/23/2019", 1);
INSERT INTO RENTALS_HAS_SKIERS(skier_id, rental_id) VALUES (45, 22);

INSERT INTO CUSTOMER(first_name, last_name, address, city, state, zip_code, email, phone) VALUES ("Chris", "Bielman", "1300 E 1840 S", "Salt Lake City", "UT", "84105", "placeholder@email.com", "8013472372");
INSERT INTO SKIER_INFO(customer_id, first_name, last_name, height, weight, age, skier_type) VALUES (24, "Chris", "Bielman", 64, 135, 28, 3);
INSERT INTO RENTALS(customer_id, date_out, due_date, total_skiers) VALUES (24, "04/20/2019", "04/23/2019", 1);
INSERT INTO RENTALS_HAS_SKIERS(skier_id, rental_id) VALUES (46, 23);

INSERT INTO CUSTOMER(first_name, last_name, address, city, state, zip_code, email, phone) VALUES ("Gavin", "Dutton", "1300 E 1840 S", "Salt Lake City", "UT", "84105", "placeholder@email.com", "8019872372");
INSERT INTO SKIER_INFO(customer_id, first_name, last_name, height, weight, age, skier_type) VALUES (25, "Gavin", "Dutton", 71, 215, 25, 2);
INSERT INTO RENTALS(customer_id, date_out, due_date, total_skiers) VALUES (25, "04/21/2019", "04/24/2019", 1);
INSERT INTO RENTALS_HAS_SKIERS(skier_id, rental_id) VALUES (47, 24);

INSERT INTO CUSTOMER(first_name, last_name, address, city, state, zip_code, email, phone) VALUES ("Grant", "Wade", "1300 E 1840 S", "Salt Lake City", "UT", "84105", "placeholder@email.com", "8019875372");
INSERT INTO SKIER_INFO(customer_id, first_name, last_name, height, weight, age, skier_type) VALUES (26, "Grant", "Wade", 77, 230, 35, 2);
INSERT INTO RENTALS(customer_id, date_out, due_date, total_skiers) VALUES (26, "04/22/2019", "04/24/2019", 1);
INSERT INTO RENTALS_HAS_SKIERS(skier_id, rental_id) VALUES (48, 25);

INSERT INTO CUSTOMER(first_name, last_name, address, city, state, zip_code, email, phone) VALUES ("Todd", "Phillips", "1300 E 1840 S", "Salt Lake City", "UT", "84105", "placeholder@email.com", "8019876372");
INSERT INTO SKIER_INFO(customer_id, first_name, last_name, height, weight, age, skier_type) VALUES (27, "Grant", "Wade", 70, 175, 52, 3);
INSERT INTO SKIER_INFO(customer_id, first_name, last_name, height, weight, age, skier_type) VALUES (27, "Theo", "Wade", 70, 170, 23, 2);
INSERT INTO RENTALS(customer_id, date_out, due_date, total_skiers) VALUES (27, "04/22/2019", "04/25/2019", 2);
INSERT INTO RENTALS_HAS_SKIERS(skier_id, rental_id) VALUES (49, 26);
INSERT INTO RENTALS_HAS_SKIERS(skier_id, rental_id) VALUES (50, 26);


INSERT INTO CUSTOMER(first_name, last_name, address, city, state, zip_code, email, phone) VALUES ("Tim", "Nye", "1300 E 1840 S", "Salt Lake City", "UT", "84105", "placeholder@email.com", "8019876672");
INSERT INTO SKIER_INFO(customer_id, first_name, last_name, height, weight, age, skier_type) VALUES (28, "Tim", "Nye", 74, 205, 36, 3);
INSERT INTO SKIER_INFO(customer_id, first_name, last_name, height, weight, age, skier_type) VALUES (28, "Alma", "Nye", 64, 130, 33, 2);
INSERT INTO RENTALS(customer_id, date_out, due_date, total_skiers) VALUES (28, "04/23/2019", "04/25/2019", 2);
INSERT INTO RENTALS_HAS_SKIERS(skier_id, rental_id) VALUES (51, 27);
INSERT INTO RENTALS_HAS_SKIERS(skier_id, rental_id) VALUES (52, 27);


INSERT INTO CUSTOMER(first_name, last_name, address, city, state, zip_code, email, phone) VALUES ("Cole", "Belasco", "1300 E 1840 S", "Salt Lake City", "UT", "84105", "placeholder@email.com", "8019826672");
INSERT INTO SKIER_INFO(customer_id, first_name, last_name, height, weight, age, skier_type) VALUES (29, "Cole", "Belasco", 64, 140, 30, 2);
INSERT INTO SKIER_INFO(customer_id, first_name, last_name, height, weight, age, skier_type) VALUES (29, "Melissa", "Hauser", 62, 110, 30, 2);
INSERT INTO RENTALS(customer_id, date_out, due_date, total_skiers) VALUES (29, "04/23/2019", "04/25/2019", 2);
INSERT INTO RENTALS_HAS_SKIERS(skier_id, rental_id) VALUES (53, 28);
INSERT INTO RENTALS_HAS_SKIERS(skier_id, rental_id) VALUES (54, 28);

INSERT INTO CUSTOMER(first_name, last_name, address, city, state, zip_code, email, phone) VALUES ("Brad", "Lilihaug", "1300 E 1840 S", "Salt Lake City", "UT", "84105", "placeholder@email.com", "8019826272");
INSERT INTO SKIER_INFO(customer_id, first_name, last_name, height, weight, age, skier_type) VALUES (30, "Brad", "Brad", 70, 205, 24, 1);
INSERT INTO RENTALS(customer_id, date_out, due_date, total_skiers) VALUES (30, "04/24/2019", "04/25/2019", 1);
INSERT INTO RENTALS_HAS_SKIERS(skier_id, rental_id) VALUES (55, 29);

INSERT INTO CUSTOMER(first_name, last_name, address, city, state, zip_code, email, phone) VALUES ("Amy", "Parker", "1300 E 1840 S", "Salt Lake City", "UT", "84105", "colesmith@email.com", "8012243572");
INSERT INTO SKIER_INFO(customer_id, first_name, last_name, height, weight, age, skier_type) VALUES (31, "Amy", "Amy", 64, 140, 40, 2);
INSERT INTO SKIER_SETTINGS(skier_id, boot_sole_length, skier_code, reccomended_din, actual_din) VALUES (56, 245, "J", 4.5, 4.5);
INSERT INTO SKIER_EQUIPMENT(skier_id, ski_id, boot_id, helmet_id) VALUES (56, 190010, 190062, 190677);
UPDATE SKIS SET skis_out = TRUE WHERE ski_id = 190010;
UPDATE BOOTS SET boots_out = TRUE WHERE boot_id = 190062;
UPDATE HELMET SET helmet_out = TRUE WHERE helmet_id = 190677;
INSERT INTO SKIER_INFO(customer_id, first_name, last_name, height, weight, age, skier_type) VALUES (31, "Kelsey", "Parker", 63, 135, 20, 2);
INSERT INTO SKIER_SETTINGS(skier_id, boot_sole_length, skier_code, reccomended_din, actual_din) VALUES (57, 245, "K", 5.0, 5.0);
INSERT INTO SKIER_EQUIPMENT(skier_id, ski_id, boot_id, helmet_id) VALUES (57, 190010, 190061, 190664);
UPDATE SKIS SET skis_out = TRUE WHERE ski_id = 190010;
UPDATE BOOTS SET boots_out = TRUE WHERE boot_id = 190061;
UPDATE HELMET SET helmet_out = TRUE WHERE helmet_id = 190664;
INSERT INTO SKIER_INFO(customer_id, first_name, last_name, height, weight, age, skier_type) VALUES (31, "Claire", "Parker", 63, 130, 18, 2);
INSERT INTO SKIER_SETTINGS(skier_id, boot_sole_length, skier_code, reccomended_din, actual_din) VALUES (58, 245, "K", 5.5, 5.5);
INSERT INTO SKIER_EQUIPMENT(skier_id, ski_id, boot_id) VALUES (58, 190017, 190063);
UPDATE SKIS SET skis_out = TRUE WHERE ski_id = 190017;
UPDATE BOOTS SET boots_out = TRUE WHERE boot_id = 190063;
INSERT INTO RENTALS(customer_id, date_out, due_date, total_skiers, skiers_picked_up) VALUES (31, "04/17/2019", "04/19/2019", 3, 3);
INSERT INTO RENTALS_HAS_SKIERS(skier_id, rental_id) VALUES (56, 30);
INSERT INTO RENTALS_HAS_SKIERS(skier_id, rental_id) VALUES (57, 30);
INSERT INTO RENTALS_HAS_SKIERS(skier_id, rental_id) VALUES (58, 30);


INSERT INTO CUSTOMER(first_name, last_name, address, city, state, zip_code, email, phone) VALUES ("Mark", "Mooney", "1300 E 1840 S", "Salt Lake City", "UT", "84105", "colesmith@email.com", "8012243272");
INSERT INTO SKIER_INFO(customer_id, first_name, last_name, height, weight, age, skier_type) VALUES (32, "Mark", "Mooney", 77, 240, 50, 3);
INSERT INTO SKIER_SETTINGS(skier_id, boot_sole_length, skier_code, reccomended_din, actual_din) VALUES (59, 305, "M", 8.5, 8.5);
INSERT INTO SKIER_EQUIPMENT(skier_id, ski_id, boot_id) VALUES (59, 190108, 190048);
UPDATE SKIS SET skis_out = TRUE WHERE ski_id = 190010;
UPDATE BOOTS SET boots_out = TRUE WHERE boot_id = 190048;
INSERT INTO RENTALS(customer_id, date_out, due_date, total_skiers, skiers_picked_up) VALUES (32, "04/17/2019", "04/19/2019", 1, 1);
INSERT INTO RENTALS_HAS_SKIERS(skier_id, rental_id) VALUES (59, 31);

INSERT INTO CUSTOMER(first_name, last_name, address, city, state, zip_code, email, phone) VALUES ("Myer", "Schofield", "1300 E 1840 S", "Salt Lake City", "UT", "84105", "colesmith@email.com", "8012943272");
INSERT INTO SKIER_INFO(customer_id, first_name, last_name, height, weight, age, skier_type) VALUES (33, "Myer", "Schofield", 77, 220, 22, 2);
INSERT INTO SKIER_SETTINGS(skier_id, boot_sole_length, skier_code, reccomended_din, actual_din) VALUES (60, 305, "M", 7.5, 7.5);
INSERT INTO SKIER_EQUIPMENT(skier_id, ski_id, boot_id) VALUES (60, 190106, 190050);
UPDATE SKIS SET skis_out = TRUE WHERE ski_id = 190106;
UPDATE BOOTS SET boots_out = TRUE WHERE boot_id = 190050;
INSERT INTO RENTALS(customer_id, date_out, due_date, total_skiers, skiers_picked_up) VALUES (33, "04/17/2019", "04/18/2019", 1, 1);
INSERT INTO RENTALS_HAS_SKIERS(skier_id, rental_id) VALUES (60, 32);

INSERT INTO CUSTOMER(first_name, last_name, address, city, state, zip_code, email, phone) VALUES ("David", "Merril", "1300 E 1840 S", "Salt Lake City", "UT", "84105", "colesmith@email.com", "8012943272");
INSERT INTO SKIER_INFO(customer_id, first_name, last_name, height, weight, age, skier_type) VALUES (34, "David", "Merril", 70, 200, 28, 3);
INSERT INTO SKIER_SETTINGS(skier_id, boot_sole_length, skier_code, reccomended_din, actual_din) VALUES (61, 285, "M", 8.0, 8.0);
INSERT INTO SKIER_EQUIPMENT(skier_id, ski_id, boot_id, helmet_id) VALUES (61, 190114, 190036, 190715);
UPDATE SKIS SET skis_out = TRUE WHERE ski_id = 190114;
UPDATE BOOTS SET boots_out = TRUE WHERE boot_id = 190036;
UPDATE HELMET SET helmet_out = TRUE WHERE helmet_id = 190715;
INSERT INTO RENTALS(customer_id, date_out, due_date, total_skiers, skiers_picked_up) VALUES (34, "04/18/2019", "04/20/2019", 1, 1);
INSERT INTO RENTALS_HAS_SKIERS(skier_id, rental_id) VALUES (61, 33);


INSERT INTO CUSTOMER(first_name, last_name, address, city, state, zip_code, email, phone) VALUES ("Bert", "LePrey", "1300 E 1840 S", "Salt Lake City", "UT", "84105", "colesmith@email.com", "8012943202");
INSERT INTO SKIER_INFO(customer_id, first_name, last_name, height, weight, age, skier_type) VALUES (35, "Bert", "LePrey", 65, 150, 38, 2);
INSERT INTO SKIER_SETTINGS(skier_id, boot_sole_length, skier_code, reccomended_din, actual_din) VALUES (62, 276, "K", 6.0, 6.0);
INSERT INTO SKIER_EQUIPMENT(skier_id, ski_id, boot_id, helmet_id) VALUES (62, 190017, 190021, 190665);
UPDATE SKIS SET skis_out = TRUE WHERE ski_id = 190017;
UPDATE BOOTS SET boots_out = TRUE WHERE boot_id = 190021;
UPDATE HELMET SET helmet_out = TRUE WHERE helmet_id = 190665;
INSERT INTO RENTALS(customer_id, date_out, due_date, total_skiers, skiers_picked_up) VALUES (35, "04/18/2019", "04/20/2019", 1, 1);
INSERT INTO RENTALS_HAS_SKIERS(skier_id, rental_id) VALUES (62, 34);

INSERT INTO CUSTOMER(first_name, last_name, address, city, state, zip_code, email, phone) VALUES ("Christian", "Fisher", "1300 E 1840 S", "Salt Lake City", "UT", "84105", "colesmith@email.com", "8012943002");
INSERT INTO SKIER_INFO(customer_id, first_name, last_name, height, weight, age, skier_type) VALUES (36, "Christian", "Fisher", 66, 160, 33, 3);
INSERT INTO SKIER_SETTINGS(skier_id, boot_sole_length, skier_code, reccomended_din, actual_din) VALUES (63, 276, "L", 6.5, 6.5);
INSERT INTO SKIER_EQUIPMENT(skier_id, ski_id, boot_id, helmet_id) VALUES (62, 190121, 190029, 190683);
UPDATE SKIS SET skis_out = TRUE WHERE ski_id = 190121;
UPDATE BOOTS SET boots_out = TRUE WHERE boot_id = 190029;
UPDATE HELMET SET helmet_out = TRUE WHERE helmet_id = 190683;
INSERT INTO RENTALS(customer_id, date_out, due_date, total_skiers, skiers_picked_up) VALUES (36, "04/18/2019", "04/20/2019", 1, 1);
INSERT INTO RENTALS_HAS_SKIERS(skier_id, rental_id) VALUES (63, 35);

INSERT INTO CUSTOMER(first_name, last_name, address, city, state, zip_code, email, phone) VALUES ("Gage", "Pompocco", "1300 E 1840 S", "Salt Lake City", "UT", "84105", "colesmith@email.com", "8012943002");
INSERT INTO SKIER_INFO(customer_id, first_name, last_name, height, weight, age, skier_type) VALUES (37, "Christian", "Fisher", 66, 160, 33, 3);
INSERT INTO SKIER_SETTINGS(skier_id, boot_sole_length, skier_code, reccomended_din, actual_din) VALUES (64, 265, "L", 5.5, 5.5);
INSERT INTO SKIER_EQUIPMENT(skier_id, ski_id, boot_id, helmet_id, signature) VALUES (64, 190103, 190076, 190679, "Gage Pompocco");
UPDATE SKIS SET skis_out = TRUE WHERE ski_id = 190103;
UPDATE BOOTS SET boots_out = TRUE WHERE boot_id = 190076;
UPDATE HELMET SET helmet_out = TRUE WHERE helmet_id = 190679;
INSERT INTO RENTALS(customer_id, date_out, due_date, total_skiers, skiers_picked_up) VALUES (37, "04/19/2019", "04/21/2019", 1, 1);
INSERT INTO RENTALS_HAS_SKIERS(skier_id, rental_id) VALUES (64, 36);

INSERT INTO CUSTOMER(first_name, last_name, address, city, state, zip_code, email, phone) VALUES ("Bridger", "Tesch", "1300 E 1840 S", "Salt Lake City", "UT", "84105", "colesmith@email.com", "8010943002");
INSERT INTO SKIER_INFO(customer_id, first_name, last_name, height, weight, age, skier_type) VALUES (38, "Bridger", "Tesch", 74, 190, 30, 3);
INSERT INTO SKIER_SETTINGS(skier_id, boot_sole_length, skier_code, reccomended_din, actual_din) VALUES (65, 305, "L", 5.5, 5.5);
INSERT INTO SKIER_EQUIPMENT(skier_id, ski_id, boot_id, helmet_id, signature) VALUES (65, 190124, 190052, 190711, "Gage Pompocco");
UPDATE SKIS SET skis_out = TRUE WHERE ski_id = 190124;
UPDATE BOOTS SET boots_out = TRUE WHERE boot_id = 190052;
UPDATE HELMET SET helmet_out = TRUE WHERE helmet_id = 190711;
INSERT INTO RENTALS(customer_id, date_out, due_date, total_skiers, skiers_picked_up) VALUES (38, "04/19/2019", "04/21/2019", 1, 1);
INSERT INTO RENTALS_HAS_SKIERS(skier_id, rental_id) VALUES (65, 37);

INSERT INTO CUSTOMER(first_name, last_name, address, city, state, zip_code, email, phone) VALUES ("Dylan", "Jacobson", "1300 E 1840 S", "Salt Lake City", "UT", "84105", "colesmith@email.com", "8010943502");
INSERT INTO SKIER_INFO(customer_id, first_name, last_name, height, weight, age, skier_type) VALUES (39, "Dylan", "Jacobson", 70, 175, 25, 2);
INSERT INTO SKIER_SETTINGS(skier_id, boot_sole_length, skier_code, reccomended_din, actual_din) VALUES (66, 285, "K", 6.0, 6.0);
INSERT INTO SKIER_EQUIPMENT(skier_id, ski_id, boot_id, signature) VALUES (66, 190104, 190037, "Dylan Jacobson");
UPDATE SKIS SET skis_out = TRUE WHERE ski_id = 190104;
UPDATE BOOTS SET boots_out = TRUE WHERE boot_id = 190037;
INSERT INTO RENTALS(customer_id, date_out, due_date, total_skiers, skiers_picked_up) VALUES (39, "04/18/2019", "04/22/2019", 1, 1);
INSERT INTO RENTALS_HAS_SKIERS(skier_id, rental_id) VALUES (66, 38);

INSERT INTO CUSTOMER(first_name, last_name, address, city, state, zip_code, email, phone) VALUES ("Hunter", "Cole", "1300 E 1840 S", "Salt Lake City", "UT", "84105", "colesmith@email.com", "8010946502");
INSERT INTO SKIER_INFO(customer_id, first_name, last_name, height, weight, age, skier_type) VALUES (40, "Hunter", "Cole", 67, 165, 24, 3);
INSERT INTO SKIER_SETTINGS(skier_id, boot_sole_length, skier_code, reccomended_din, actual_din) VALUES (67, 285, "K", 6.0, 6.0);
INSERT INTO SKIER_EQUIPMENT(skier_id, ski_id, boot_id, signature) VALUES (67, 190104, 190041, "Hunter Cole");
UPDATE SKIS SET skis_out = TRUE WHERE ski_id = 190104;
UPDATE BOOTS SET boots_out = TRUE WHERE boot_id = 190041;
INSERT INTO RENTALS(customer_id, date_out, due_date, total_skiers, skiers_picked_up) VALUES (40, "04/18/2019", "04/22/2019", 1, 1);
INSERT INTO RENTALS_HAS_SKIERS(skier_id, rental_id) VALUES (67, 39);

INSERT INTO CUSTOMER(first_name, last_name, address, city, state, zip_code, email, phone) VALUES ("Max", "Axtel", "1300 E 1840 S", "Salt Lake City", "UT", "84105", "colesmith@email.com", "8015946502");
INSERT INTO SKIER_INFO(customer_id, first_name, last_name, height, weight, age, skier_type) VALUES (41, "Max", "Axtel", 69, 170, 58, 3);
INSERT INTO SKIER_SETTINGS(skier_id, boot_sole_length, skier_code, reccomended_din, actual_din) VALUES (68, 276, "L", 7.0, 7.0);
INSERT INTO SKIER_EQUIPMENT(skier_id, ski_id, boot_id, signature) VALUES (68, 190125, 190022, "Max Axtel");
UPDATE SKIS SET skis_out = TRUE WHERE ski_id = 190125;
UPDATE BOOTS SET boots_out = TRUE WHERE boot_id = 190022;
INSERT INTO RENTALS(customer_id, date_out, due_date, total_skiers, skiers_picked_up) VALUES (41, "04/18/2019", "04/23/2019", 1, 1);
INSERT INTO RENTALS_HAS_SKIERS(skier_id, rental_id) VALUES (68, 40);

INSERT INTO CUSTOMER(first_name, last_name, address, city, state, zip_code, email, phone) VALUES ("Sam", "Zilvitis", "1300 E 1840 S", "Salt Lake City", "UT", "84105", "colesmith@email.com", "8015346502");
INSERT INTO SKIER_INFO(customer_id, first_name, last_name, height, weight, age, skier_type) VALUES (42, "Sam", "Zilvitis", 65, 150, 49, 3);
INSERT INTO SKIER_SETTINGS(skier_id, boot_sole_length, skier_code, reccomended_din, actual_din) VALUES (69, 253, "L", 6.0, 6.0);
INSERT INTO SKIER_EQUIPMENT(skier_id, ski_id, boot_id, signature) VALUES (69, 190012, 190073, "Sam Zilvitis");
UPDATE SKIS SET skis_out = TRUE WHERE ski_id = 190012;
UPDATE BOOTS SET boots_out = TRUE WHERE boot_id = 190073;
INSERT INTO RENTALS(customer_id, date_out, due_date, total_skiers, skiers_picked_up) VALUES (42, "04/18/2019", "04/23/2019", 1, 1);
INSERT INTO RENTALS_HAS_SKIERS(skier_id, rental_id) VALUES (69, 41);

INSERT INTO CUSTOMER(first_name, last_name, address, city, state, zip_code, email, phone) VALUES ("Trent", "Maschoff", "1300 E 1840 S", "Salt Lake City", "UT", "84105", "colesmith@email.com", "8017346502");
INSERT INTO SKIER_INFO(customer_id, first_name, last_name, height, weight, age, skier_type) VALUES (43, "Trent", "Maschoff", 69, 185, 31, 3);
INSERT INTO SKIER_SETTINGS(skier_id, boot_sole_length, skier_code, reccomended_din, actual_din) VALUES (70, 276, "M", 8.0, 8.0);
INSERT INTO SKIER_EQUIPMENT(skier_id, ski_id, boot_id, signature) VALUES (70, 190119, 190033, "Trent Maschoff");
UPDATE SKIS SET skis_out = TRUE WHERE ski_id = 190119;
UPDATE BOOTS SET boots_out = TRUE WHERE boot_id = 190033;
INSERT INTO RENTALS(customer_id, date_out, due_date, total_skiers, skiers_picked_up) VALUES (43, "04/18/2019", "04/24/2019", 1, 1);
INSERT INTO RENTALS_HAS_SKIERS(skier_id, rental_id) VALUES (70, 42);

INSERT INTO CUSTOMER(first_name, last_name, address, city, state, zip_code, email, phone) VALUES ("Jake", "Clifford", "1300 E 1840 S", "Salt Lake City", "UT", "84105", "colesmith@email.com", "8017336502");
INSERT INTO SKIER_INFO(customer_id, first_name, last_name, height, weight, age, skier_type) VALUES (44, "Jake", "Clifford", 69, 175, 30, 3);
INSERT INTO SKIER_SETTINGS(skier_id, boot_sole_length, skier_code, reccomended_din, actual_din) VALUES (71, 276, "M", 8.0, 8.0);
INSERT INTO SKIER_EQUIPMENT(skier_id, ski_id, boot_id, signature) VALUES (71, 190100, 190028, "Jake Clifford");
UPDATE SKIS SET skis_out = TRUE WHERE ski_id = 190100;
UPDATE BOOTS SET boots_out = TRUE WHERE boot_id = 190028;
INSERT INTO RENTALS(customer_id, date_out, due_date, total_skiers, skiers_picked_up) VALUES (44, "04/18/2019", "04/24/2019", 1, 1);
INSERT INTO RENTALS_HAS_SKIERS(skier_id, rental_id) VALUES (71, 43);

INSERT INTO CUSTOMER(first_name, last_name, address, city, state, zip_code, email, phone) VALUES ("Levi", "Frost", "1300 E 1840 S", "Salt Lake City", "UT", "84105", "colesmith@email.com", "8017536502");
INSERT INTO SKIER_INFO(customer_id, first_name, last_name, height, weight, age, skier_type) VALUES (45, "Levi", "Frost", 64, 140, 23, 3);
INSERT INTO SKIER_SETTINGS(skier_id, boot_sole_length, skier_code, reccomended_din, actual_din) VALUES (72, 253, "K", 7.0, 7.0);
INSERT INTO SKIER_EQUIPMENT(skier_id, ski_id, boot_id, signature) VALUES (72, 190016, 190067, "Levi Frost");
UPDATE SKIS SET skis_out = TRUE WHERE ski_id = 190016;
UPDATE BOOTS SET boots_out = TRUE WHERE boot_id = 190067;
INSERT INTO RENTALS(customer_id, date_out, due_date, total_skiers, skiers_picked_up) VALUES (45, "04/18/2019", "04/25/2019", 1, 1);
INSERT INTO RENTALS_HAS_SKIERS(skier_id, rental_id) VALUES (72, 44);
