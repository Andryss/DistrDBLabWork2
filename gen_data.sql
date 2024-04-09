set role bigblueuser;

create table if not exists orders(
    id uuid,
    client_id uuid,
    created_at timestamp,
    staff_id uuid
);

create table if not exists staff(
    id uuid,
    name text,
    surname text,
    phone text
);

create table if not exists clients(
    id uuid,
    name text,
    surname text,
    phone text
);

create table if not exists storages(
    num int,
    address text,
    phone text,
    staff_id uuid
);

create table if not exists facts(
    order_id uuid,
    storage_num int,
    article text,
    client_id uuid,
    staff_id uuid,
    cost double precision,
    count int
);

do $$
    declare staff_id uuid; storage_num int; client_id uuid; order_id uuid;
    begin
        for i in 1..10000 loop
            select gen_random_uuid() into staff_id;
            insert into staff values (staff_id, md5(random()::text), md5(random()::text), md5(random()::text));
            select round(random() * 100000)::int into storage_num;
            insert into storages values (storage_num, md5(random()::text), md5(random()::text), staff_id);
            for j in 1..20 loop
                select gen_random_uuid() into client_id;
                insert into clients values (client_id, md5(random()::text), md5(random()::text), md5(random()::text));
                for k in 1..2 loop
                    select gen_random_uuid() into order_id;
                    insert into orders values (order_id, client_id, now(), staff_id);
                    insert into facts values (order_id, storage_num, md5(random()::text), client_id, staff_id, random() * 1000, round(random() * 100)::int);
                end loop;
            end loop;
        end loop;
    end;
$$;