------------------------------------------
-- Export file for user SCOTT           --
-- Created by m on 17.11.2015, 13:42:39 --
------------------------------------------

set define off
spool hbuhtest.log

prompt
prompt Creating procedure SPR_CATEGORY_INS
prompt ===================================
prompt
create or replace procedure scott.spr_category_ins(v_id_parent in number,
                                             v_is_rashod in number,
                                             v_name      in varchar2,
                                             v_nout      out number,
                                             v_sout      out varchar2

                                             ) is
  -- nva 2015.10.28
  -- insert values in spr_category
begin
  declare
    v_cnt number;
    is_empty_values       exception;
    is_null_values        exception;
    is_not_correct_values exception;
    is_dublicate_record   exception;
    is_dublicate_name     exception;
    is_not_exist_parent   exception;
  begin
    v_cnt:=0;
    v_sout:='проверка кодировок';
  end;
end spr_category_ins;
/


spool off
