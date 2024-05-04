USE bismi_allah_db;
CREATE TABLE IF NOT EXISTS bismi_allah_table (id INT PRIMARY KEY NOT NULL UNIQUE, name VARCHAR(90), CONSTRAINT la_ilaha_illa_allah CHECK(id > 0), bismi_allah_time DATETIME DEFAULT NOW());
INSERT INTO bismi_allah_table (id, name) VALUES
(6, "in the name of Allah"),
(1, "la ilaha illa Allah"),
(2, "Allah Akbar"),
(3, "inna li Allah wa inna ilayhi raji3on"),
(4, "astaghfiro Allah"),
(5, "inna li Allah wa inna ilayhi raji3on");

RENAME TABLE bismi_allah_table TO bismi_allah_tabla;
RENAME TABLE bismi_allah_tabla TO bismi_allah_table;

ALTER TABLE bismi_allah_table ADD second_name VARCHAR(90);

ALTER TABLE bismi_allah_table RENAME COLUMN second_name TO smya_tania;
ALTER TABLE bismi_allah_table MODIFY COLUMN smya_tania VARCHAR(90) AFTER name;
ALTER TABLE bismi_allah_table MODIFY COLUMN smya_tania VARCHAR(90) FIRST;

UPDATE bismi_allah_table SET smya_tania = "la ilaha illa Allah" WHERE (smya_tania IS NULL AND id >= 0);

DELETE FROM bismi_allah_table WHERE id IS NULL;
SELECT * FROM bismi_allah_table;

ALTER TABLE bismi_allah_table RENAME COLUMN smya_tania TO second_name;

ALTER TABLE bismi_allah_table DROP COLUMN second_name;

-- SELECT name FROM bismi_allah_table WHERE id = 0 OR id IS NULL;

ALTER TABLE bismi_allah_table DROP CONSTRAINT la_ilaha_illa_allah;

DROP TABLE bismi_allah_table;
