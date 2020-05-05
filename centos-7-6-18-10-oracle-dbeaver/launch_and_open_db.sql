set serveroutput on
set timing on
begin
    for i in 1..'&1' loop
        begin
            dbms_output.put_line('create pluggable database orclpdb'||lpad(i,2,0)||' admin user user'||lpad(1,2,0)||' identified by oracle_pwd roles = (dba)'||' file_name_convert = ('||''''||'/opt/oracle/oradata/ORCLCDB/pdbseed'||''''||','||''''||'/opt/oracle/oradata/ORCLCDB/pdb'||lpad(i,2,0)||''''||')');
            execute immediate 'create pluggable database orclpdb'||lpad(i,2,0)||' admin user user'||lpad(1,2,0)||' identified by oracle_pwd roles = (dba)'||' file_name_convert = ('||''''||'/opt/oracle/oradata/ORCLCDB/pdbseed'||''''||','||''''||'/opt/oracle/oradata/ORCLCDB/pdb'||lpad(i,2,0)||''''||')';
            dbms_output.put_line('alter pluggable database orclpdb'||lpad(i,2,0)||' open read write');
            execute immediate 'alter pluggable database orclpdb'||lpad(i,2,0)||' open read write';
            exception when others then dbms_output.put_line('[ '|| sqlcode||']'||sqlerrm);
        end;
    end loop;
end;
/
quit;
