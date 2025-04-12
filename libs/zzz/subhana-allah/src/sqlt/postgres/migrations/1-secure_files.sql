create table if not exists secure_files (
    id bigserial primary key,
    name text not null,
    extension text
)
