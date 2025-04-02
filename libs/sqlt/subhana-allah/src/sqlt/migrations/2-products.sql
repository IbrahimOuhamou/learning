create table if not exists products (
    id integer primary key,
    name text not null,
    price real not null,
    stock integer not null
);
