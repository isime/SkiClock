CREATE TABLE IF NOT EXISTS SKIS (
  ski_id INT(30) NOT NULL,
  length INT(10) NOT NULL,
  serial_number INT(30) NOT NULL,
  manufacturer VARCHAR(30) NOT NULL,
  model VARCHAR(30) NOT NULL,
  binding VARCHAR(20) NOT NULL,
  skis_out BOOLEAN,
  PRIMARY KEY(ski_id)
);

CREATE TABLE IF NOT EXISTS TESTS (
  test_id INT(30) NOT NULL AUTO_INCREMENT,
  ski_id INT(30) NOT NULL,
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
  drivers_license VARCHAR(60),
  credit_card VARCHAR(60),
  PRIMARY KEY(customer_id)
);

CREATE TABLE IF NOT EXISTS SKIER_INFO (
  skier_id INT(30) NOT NULL AUTO_INCREMENT,
  customer_id INT(30) NOT NULL,
  first_name VARCHAR(30) NOT NULL,
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
  PRIMARY KEY(settings_id)
);

CREATE TABLE IF NOT EXISTS SKIER_EQUIPMENT (
  skier_equipment_id INT(30) NOT NULL AUTO_INCREMENT,
  skier_id INT(30),
  ski_id INT(30),
  boot_id INT(30),
  helmet_id INT(30),
  current_equipment BOOLEAN,
  PRIMARY KEY(skier_equipment_id)
);

CREATE TABLE IF NOT EXISTS BOOTS(
  boot_id INT(30) NOT NULL,
  manufacturer VARCHAR(30) NOT NULL,
  model VARCHAR(30) NOT NULL,
  size FLOAT(15) NOT NULL,
  sole_length INT(30) NOT NULL,
  boots_out BOOLEAN,
  PRIMARY KEY(boot_id)
);

CREATE TABLE IF NOT EXISTS HELMET(
  helmet_id INT(30) NOT NULL,
  size VARCHAR(15) NOT NULL,
  color VARCHAR(30) NOT NULL,
  helmet_out BOOLEAN,
  PRIMARY KEY(helmet_id)
);

CREATE TABLE IF NOT EXISTS RENTALS(
  rental_id INT(30) NOT NULL AUTO_INCREMENT,
  customer_id INT(30) NOT NULL,
  signature VARCHAR(60),
  date_out VARCHAR(30),
  date_in VARCHAR(30),
  PRIMARY KEY(rental_id)
);

CREATE TABLE IF NOT EXISTS RENTALS_HAS_SKIERS(
  rentals_has_skiers_id INT(30) NOT NULL AUTO_INCREMENT,
  skier_id INT(30),
  rental_id INT(30),
  PRIMARY KEY(rentals_has_skiers_id)
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

SELECT * FROM SKIS;
SELECT * FROM SKIS WHERE manufacturer = "K2";

SELECT * FROM SKIER_EQUIPMENT WHERE boot_id = 019020;


SELECT * FROM SKIER_INFO WHERE skier_id = (SELECT skier_id FROM SKIER_EQUIPMENT WHERE ski_id = 019001);
