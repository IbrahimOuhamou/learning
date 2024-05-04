-- in the name of Allah
CREATE DATABASE IF NOT EXISTS bismi_allah_db;
USE bismi_allah_db;

CREATE TABLE IF NOT EXISTS bismi_allah_table (id INT PRIMARY KEY NOT NULL UNIQUE, name VARCHAR(90), name2 VARCHAR(90));

CREATE TRIGGER bismi_allah_trigger BEFORE INSERT ON bismi_allah_table FOR EACH ROW SET NEW.name2 = NEW.name;

INSERT INTO bismi_allah_table (id, name) VALUES
(6, "in the name of Allah"),
(1, "la ilaha illa Allah"),
(2, "Allah Akbar"),
(3, "inna li Allah wa inna ilayhi raji3on"),
(4, "astaghfiro Allah"),
(5, "inna li Allah wa inna ilayhi raji3on");

SELECT * FROM bismi_allah_table;

DROP TRIGGER bismi_allah_trigger;
DROP TABLE bismi_allah_table;
