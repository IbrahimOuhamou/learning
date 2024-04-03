CREATE DATABASE IF NOT EXISTS bismi_allah_blog;
USE bismi_allah_blog;

CREATE TABLE bismi_allah_users( user_id INT PRIMARY KEY AUTO_INCREMENT,
								user_name VARCHAR(40),
                                blog_first_id INT,
                                blog_last_id INT);

INSERT INTO bismi_allah_users (user_name, blog_last_id) VALUES ('bismi_allah', 2),
												 ('la ilaha illa Allah', 2);

CREATE TABLE bismi_allah_blogs( blog_id INT PRIMARY KEY AUTO_INCREMENT,
								blog_text TEXT,
                                blog_next_id INT UNIQUE,
                                blog_previous_id INT UNIQUE,
                                user_id INT,
                                FOREIGN KEY(user_id) REFERENCES bismi_allah_users(user_id));

CREATE TRIGGER bismi_allah_trigger BEFORE INSERT ON bismi_allah_blogs FOR EACH ROW SET NEW.blog_previous_id = (SELECT blog_last_id FROM bismi_allah_users WHERE user_id = NEW.user_id);

INSERT INTO bismi_allah_blogs(blog_text, user_id) VALUES ("bismi_allah", 1),
														 ("la ilaha illa Allah", 2),
                                                         ('la ilaha illa Allah mohammed rassoul Allah', 1),
                                                         ('astaghfiro Allah wa atobo ilayhi', 1);

select * from bismi_allah_users;
select * from bismi_allah_blogs;

DROP TRIGGER bismi_allah_trigger;
DROP TABLE bismi_allah_blogs;
DROP TABLE bismi_allah_users;
DROP DATABASE bismi_allah_blog;