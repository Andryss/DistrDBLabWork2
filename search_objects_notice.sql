do $$
    declare tablespace text; objects text[];
    begin
        for tablespace in
            select spcname from pg_tablespace
        loop
            raise notice '### %:', tablespace;
            if tablespace = 'pg_default' then
                select array_agg(relname::text) into objects from pg_class where reltablespace = 0;
                if objects is not null then
                    for i in 1 .. array_upper(objects, 1)
                    loop
                        raise notice '%) %', i, objects[i];
                    end loop;
                end if;
            end if;
            select array_agg(c.relname::text) into objects from pg_class as c join pg_tablespace as ts on c.reltablespace = ts.oid where ts.spcname = tablespace;
            if objects is not null then
                for i in 1 .. array_upper(objects, 1)
                loop
                    raise notice '%) %', i, objects[i];
                end loop;
            end if;
        end loop;
    end;
$$;