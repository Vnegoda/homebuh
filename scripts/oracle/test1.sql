------------------------------------------
-- Export file for user SCOTT           --
-- Created by m on 17.11.2015, 13:40:41 --
------------------------------------------

set define off
spool hbuh.log

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
    v_cnt  := 0;
    v_nout := 0;
    v_sout := 'Операция не выполнена';
    ----------- valid input values
    -- valid null
    if v_id_parent is null or v_is_rashod is null or v_name is null then
      raise is_null_values;
    end if;

    -- valid empty
    if v_id_parent = 0 then
      raise is_empty_values;
    end if;

    if length(trim(v_name)) = 0 then
      raise is_empty_values;
    end if;
    if v_is_rashod != 0 and v_is_rashod != 1 then
      raise is_not_correct_values;
    end if;
    -- valid parent category
    if v_id_parent > 0 then
      v_cnt := 0;
      select count(1)
        into v_cnt
        from hbuh.spr_category
       where id = v_id_parent;
      if v_cnt <> 0 then
        raise is_not_exist_parent;
      end if;
    end if;
    -- valid dublicat
    v_cnt := 0;
    select count(1)
      into v_cnt
      from hbuh.spr_category
     where id_parent = v_id_parent
       and is_rashod = v_is_rashod
       and name = upper(trim(v_name));
    if v_cnt <> 0 then
      raise is_dublicate_record;
    end if;

    v_cnt := 0;
    select count(1)
      into v_cnt
      from hbuh.spr_category
     where name = upper(trim(v_name));
    if v_cnt <> 0 then
      raise is_dublicate_name;
    end if;
    -- insert values
    insert into hbuh.spr_category
      (id, id_parent, is_rashod, name)
    values
      (hbuh.seq_spr_category.nextval,
       v_id_parent,
       v_is_rashod,
       upper(trim(v_name)));

    commit;
    v_nout := 1;
    v_sout := 'Операция  выполнена';
  exception
    when is_empty_values then
      v_nout := -1;
      v_sout := 'Есть незаполненные значения. Операция не выполнена';
      rollback;
    when is_null_values then
      v_nout := -2;
      v_sout := 'Есть поля содержащие значение null. Операция не выполнена';
      rollback;
    when is_dublicate_record then
      v_nout := -3;
      v_sout := 'Уже есть такая категория. Операция не выполнена';
      rollback;
    when is_not_correct_values then
      v_nout := -4;
      v_sout := 'Некорректный признак операции (доход/расход). Операция не выполнена';
      rollback;
    when is_not_exist_parent then
      v_nout := -5;
      v_sout := 'Не найдена родительская категория. Операция не выполнена';
      rollback;
    when is_dublicate_name then
      v_nout := -6;
      v_sout := 'Уже есть категория с таким названием. Операция не выполнена';
      rollback;
    when others then
      v_nout := SQLCODe;
      v_sout := SUBSTR(SQLERRM, 1, 100);
      rollback;
  end;
end spr_category_ins;
/


spool off
