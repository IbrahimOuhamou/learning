-- in the name of Allah
USE bismi_allah_db;
CREATE TABLE IF NOT EXISTS bismi_allah_users( user_id INT PRIMARY KEY AUTO_INCREMENT,
								user_name VARCHAR(50),
								register_time DATETIME DEFAULT NOW(),
								CONSTRAINT not_allah CHECK(user_name != "Allah" and user_name != "allah"));

INSERT INTO bismi_allah_users (user_name) VALUES
("bismi Allah"),
("la ilaha illa Allah"),
("astaghfiro Allah"),
("inna li Allah wa inna ilayhi raji3on");

CREATE TABLE IF NOT EXISTS bismi_allah_transactions(transaction_id INT PRIMARY KEY AUTO_INCREMENT,
							user_id INT,
                            amount DECIMAL(5,3),
                            register_time DATETIME DEFAULT NOW(),
							FOREIGN KEY(user_id) REFERENCES bismi_allah_users(user_id));

INSERT INTO bismi_allah_transactions(user_id, amount) VALUES
(2, 12.12),
(2, 12.12),
(1, 0.5),
(4, 8.0);

SELECT * FROM bismi_allah_users INNER JOIN bismi_allah_transactions ON bismi_allah_transactions.user_id = bismi_allah_users.user_id;
SELECT * FROM bismi_allah_users LEFT JOIN bismi_allah_transactions ON bismi_allah_transactions.user_id = bismi_allah_users.user_id;
SELECT * FROM bismi_allah_users RIGHT JOIN bismi_allah_transactions ON bismi_allah_transactions.user_id = bismi_allah_users.user_id;

DROP TABLE bismi_allah_transactions;
DROP TABLE bismi_allah_users;