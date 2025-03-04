use 극장;
insert into movie value(1,'쉰들러 리스트','스필버그','리암 니슨',load_file('/Users/orca/Ssg/database/movies/Schidler.txt'),load_file('/Users/orca/Ssg/database/movies/Schidler.mp4'));
insert into movie value(2,'쇼생크 탈출','프랭크 다라본트','팀 로빈슨/모건 프리먼',load_file('/Users/orca/Ssg/database/movies/Shawshank.txt'),load_file('/Users/orca/Ssg/database/movies/Shawshank.mp4'));
insert into movie value(3,'라스트 모히칸','마이클 만','다네일 에리 루이스',load_file('/Users/orca/Ssg/database/movies/Mohicans.txt'),load_file('/Users/orca/Ssg/database/movies/Mohicans.mp4'));
select * from movie;



show variables like 'max_allowed_packet';


show variables like 'secure_file_priv';



SELECT schema_name, default_character_set_name 
FROM information_schema.schemata ;

commit;

