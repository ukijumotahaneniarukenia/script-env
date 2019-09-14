set serveroutput on
set timing on
begin
    for i in 1..'&2' loop
        begin
            dbms_output.put_line('drop user pdb'||lpad(i,2,0)); 
            execute immediate 'drop user pdb'||lpad(i,2,0);
            exception when others then dbms_output.put_line('[ '|| sqlcode||']'||sqlerrm);
        end;
        begin
            dbms_output.put_line('drop tablespace users'||lpad(i,2,0)||' including contents and datafiles cascade constraints'); 
            execute immediate 'drop tablespace users'||lpad(i,2,0)||' including contents and datafiles cascade constraints';
            exception when others then dbms_output.put_line('[ '|| sqlcode||']'||sqlerrm);
        end;
        begin
            dbms_output.put_line('create tablespace users'||lpad(i,2,0)|| ' datafile '|| '''' ||'/opt/oracle/oradata/ORCLCDB/pdb'||lpad(&1,2,0)||'/users'||lpad(i,2,0)||'.dbf' || '''' || ' size 100m autoextend on next 500k maxsize unlimited'); 
            execute immediate 'create tablespace users'||lpad(i,2,0)|| ' datafile '|| '''' ||'/opt/oracle/oradata/ORCLCDB/pdb'||lpad(&1,2,0)||'/users'||lpad(i,2,0)||'.dbf' || '''' || ' size 100m autoextend on next 500k maxsize unlimited';
            exception when others then dbms_output.put_line('[ '|| sqlcode||']'||sqlerrm);
        end;
        begin
            dbms_output.put_line('create user '||'pdb'||lpad(i,2,0)||' identified by "oracle_pwd" default tablespace users'||lpad(i,2,0)||' temporary tablespace temp'); 
            execute immediate 'create user '||'pdb'||lpad(i,2,0)||' identified by "oracle_pwd" default tablespace users'||lpad(i,2,0)||' temporary tablespace temp';
            exception when others then dbms_output.put_line('[ '|| sqlcode||']'||sqlerrm);
        end;
        begin
            dbms_output.put_line('grant dba to pdb'||lpad(i,2,0)); 
            execute immediate 'grant dba to pdb'||lpad(i,2,0);
            exception when others then dbms_output.put_line('[ '|| sqlcode||']'||sqlerrm);
        end;
        begin
            dbms_output.put_line('grant unlimited tablespace to pdb'||lpad(i,2,0)); 
            execute immediate 'grant unlimited tablespace to pdb'||lpad(i,2,0);
            exception when others then dbms_output.put_line('[ '|| sqlcode||']'||sqlerrm);
        end;
    end loop;
end;
/
quit;
