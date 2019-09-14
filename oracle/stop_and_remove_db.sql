set serveroutput on
set timing on
begin
    for i in 1..2 loop
        begin
            dbms_output.put_line('alter pluggable database orclpdb'||lpad(i,2,0)||' close immediate');
            execute immediate 'alter pluggable database orclpdb'||lpad(i,2,0)||' close immediate';
            dbms_output.put_line('drop pluggable database orclpdb'||lpad(i,2,0)||' including datafiles');
            execute immediate 'drop pluggable database orclpdb'||lpad(i,2,0)||' including datafiles';
            exception when others then dbms_output.put_line('[ '|| sqlcode||']'||sqlerrm);
        end;
    end loop;
end;
/
