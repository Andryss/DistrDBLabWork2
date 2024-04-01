create or replace function search_objects()
returns table(
    tablespace text,
    objects text
)
language plpgsql
as $$
    declare objects_str text; objects_arr text[];
    begin
        for tablespace in
            select spcname from pg_tablespace
        loop
            objects_str = '';
            if tablespace = 'pg_default' then
                select array_agg(relname::text) into objects_arr from pg_class where reltablespace = 0;
                if objects_arr is not null then
                    for i in 1 .. array_upper(objects_arr, 1)
                    loop
                        objects_str = objects_str || objects_arr[i] || E'\n';
                    end loop;
                end if;
            end if;
            select array_agg(c.relname::text) into objects_arr from pg_class as c join pg_tablespace as ts on c.reltablespace = ts.oid where ts.spcname = tablespace;
            if objects_arr is not null then
                for i in 1 .. array_upper(objects_arr, 1)
                loop
                    objects_str = objects_str || objects_arr[i] || E'\n';
                end loop;
            end if;
            return query select tablespace, objects_str;
        end loop;
    end;
$$;

select * from search_objects();