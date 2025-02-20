use database_ssg;
CREATE TABLE test(
id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(20) NOT NULL
);

INSERT INTO test (name) VALUES
('aaa'),
('bbb'),
('ccc');

select * from test;
