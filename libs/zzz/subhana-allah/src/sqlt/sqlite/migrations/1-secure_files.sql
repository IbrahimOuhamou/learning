create table if not exists secure_files (
    id integer primary key,
    name text not null,
    mime integer
);
