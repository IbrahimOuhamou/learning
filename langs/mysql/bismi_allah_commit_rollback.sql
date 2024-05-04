USE bismi_allah_db;

SET AUTOCOMMIT = OFF;
COMMIT;

CREATE TABLE IF NOT EXISTS bismi_allah_table (id INT PRIMARY KEY NOT NULL UNIQUE, name VARCHAR(90));
INSERT INTO bismi_allah_table (id, name) VALUES
(0, "in the name of Allah"),
(1, "la ilaha illa Allah"),
(2, "Allah Akbar"),
(3, "inna li Allah wa inna ilayhi raji3on"),
(4, "astaghfiro Allah"),
(5, "inna li Allah wa inna ilayhi raji3on");
COMMIT;

DELETE FROM bismi_allah_table WHERE id>=0;
SELECT * FROM bismi_allah_table;

ROLLBACK;
SELECT * FROM bismi_allah_table;

SET AUTOCOMMIT = ON;

DROP TABLE bismi_allah_table;
