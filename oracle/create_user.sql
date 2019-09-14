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
            dbms_output.put_line('drop tablespace tabsp'||lpad(i,2,0)||' including contents and datafiles cascade constraints'); 
            execute immediate 'drop tablespace tabsp'||lpad(i,2,0)||' including contents and datafiles cascade constraints';
            exception when others then dbms_output.put_line('[ '|| sqlcode||']'||sqlerrm);
        end;
        begin
            dbms_output.put_line('create tablespace tabsp'||lpad(i,2,0)|| ' datafile '|| '''' ||'/opt/oracle/oradata/ORCLCDB/pdb'||lpad(&1,2,0)||'/user'||lpad(i,2,0)||'.dbf' || '''' || ' size 100m autoextend on next 500k maxsize unlimited'); 
            execute immediate 'create tablespace tabsp'||lpad(i,2,0)|| ' datafile '|| '''' ||'/opt/oracle/oradata/ORCLCDB/pdb'||lpad(&1,2,0)||'/user'||lpad(i,2,0)||'.dbf' || '''' || ' size 100m autoextend on next 500k maxsize unlimited';
            exception when others then dbms_output.put_line('[ '|| sqlcode||']'||sqlerrm);
        end;
        begin
            dbms_output.put_line('create user '||'user'||lpad(i,2,0)||' identified by "ORACLE_PWD" default tablespace tabsp'||lpad(i,2,0)||' temporary tablespace temp'); 
            execute immediate 'create user '||'user'||lpad(i,2,0)||' identified by "ORACLE_PWD" default tablespace tabsp'||lpad(i,2,0)||' temporary tablespace temp';
            exception when others then dbms_output.put_line('[ '|| sqlcode||']'||sqlerrm);
        end;
        begin
            dbms_output.put_line('grant dba to user'||lpad(i,2,0)); 
            execute immediate 'grant dba to user'||lpad(i,2,0);
            exception when others then dbms_output.put_line('[ '|| sqlcode||']'||sqlerrm);
        end;
        begin
            dbms_output.put_line('grant unlimited tablespace to user'||lpad(i,2,0)); 
            execute immediate 'grant unlimited tablespace to user'||lpad(i,2,0);
            exception when others then dbms_output.put_line('[ '|| sqlcode||']'||sqlerrm);
        end;
    end loop;
end;
/
quit;
