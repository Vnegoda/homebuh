---------------------------------------------
-- Export file for user HBUH               --
-- Created by Vova on 17.11.2015, 15:20:12 --
---------------------------------------------

set define off
spool hbuh.log

prompt
prompt Creating table MOVE
prompt ===================
prompt
create table HBUH.MOVE
(
  id              NUMBER not null,
  id_count_source NUMBER not null,
  id_count_dest   NUMBER not null,
  summa_source    NUMBER(10,2) not null,
  summa_dest      NUMBER(10,2) not null
)
tablespace HBUH
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
alter table HBUH.MOVE
  add constraint KEY_ID_MOVE unique (ID)
  using index 
  tablespace HBUH
  pctfree 10
  initrans 2
  maxtrans 255;

prompt
prompt Creating table OPERATION
prompt ========================
prompt
create table HBUH.OPERATION
(
  id       NUMBER not null,
  id_user  NUMBER not null,
  id_count NUMBER not null,
  summa    NUMBER(10,3) not null,
  id_categ NUMBER not null
)
tablespace HBUH
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
alter table HBUH.OPERATION
  add constraint KEY_ID_OPER unique (ID)
  using index 
  tablespace HBUH
  pctfree 10
  initrans 2
  maxtrans 255;

prompt
prompt Creating table SPR_CATEGORY
prompt ===========================
prompt
create table HBUH.SPR_CATEGORY
(
  id        NUMBER not null,
  id_parent NUMBER default 0 not null,
  is_rashod NUMBER(1) not null,
  name      VARCHAR2(100) not null
)
tablespace HBUH
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
alter table HBUH.SPR_CATEGORY
  add constraint KEY_ID_SPR_CATEG unique (ID)
  using index 
  tablespace HBUH
  pctfree 10
  initrans 2
  maxtrans 255;

prompt
prompt Creating table SPR_VALUT
prompt ========================
prompt
create table HBUH.SPR_VALUT
(
  id         NUMBER not null,
  cod        VARCHAR2(3) not null,
  short_name VARCHAR2(20) not null,
  name       VARCHAR2(50) not null
)
tablespace HBUH
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
create unique index HBUH.IND_ID on HBUH.SPR_VALUT (ID)
  tablespace HBUH
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
alter table HBUH.SPR_VALUT
  add constraint ID_VALUT unique (ID);

prompt
prompt Creating table USERS
prompt ====================
prompt
create table HBUH.USERS
(
  id   NUMBER not null,
  name VARCHAR2(100) not null
)
tablespace HBUH
  pctfree 10
  initrans 1
  maxtrans 255;
alter table HBUH.USERS
  add constraint KEY_ID_USER unique (ID)
  using index 
  tablespace HBUH
  pctfree 10
  initrans 2
  maxtrans 255;

prompt
prompt Creating table SPR_COUNTS
prompt =========================
prompt
create table HBUH.SPR_COUNTS
(
  id       NUMBER not null,
  id_user  NUMBER not null,
  name     NUMBER not null,
  id_valut NUMBER not null
)
tablespace HBUH
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
create index HBUH.KEY_ID_VALUT on HBUH.SPR_COUNTS (ID_VALUT)
  tablespace HBUH
  pctfree 10
  initrans 2
  maxtrans 255;
alter table HBUH.SPR_COUNTS
  add constraint FK_ID_USER foreign key (ID_USER)
  references HBUH.USERS (ID);
alter table HBUH.SPR_COUNTS
  add constraint FK_ID_VALUT foreign key (ID_VALUT)
  references HBUH.SPR_VALUT (ID);

prompt
prompt Creating table SPR_KURS
prompt =======================
prompt
create table HBUH.SPR_KURS
(
  id          NUMBER not null,
  date_kurs   DATE not null,
  id_valuta1  NUMBER not null,
  id_valuta2  NUMBER not null,
  sum_valuta1 NUMBER(10,5) not null,
  sum_valuta2 NUMBER(10,5) not null
)
tablespace HBUH
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    minextents 1
    maxextents unlimited
  );
alter table HBUH.SPR_KURS
  add constraint KEY_ID_KURS unique (ID)
  using index 
  tablespace HBUH
  pctfree 10
  initrans 2
  maxtrans 255;
alter table HBUH.SPR_KURS
  add constraint FK_ID_VALUTA1 foreign key (ID_VALUTA1)
  references HBUH.SPR_VALUT (ID);
alter table HBUH.SPR_KURS
  add constraint FK_ID_VALUTA2 foreign key (SUM_VALUTA2)
  references HBUH.SPR_VALUT (ID);

prompt
prompt Creating sequence SEQ_MOVE
prompt ==========================
prompt
create sequence HBUH.SEQ_MOVE
minvalue 1
maxvalue 999999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_OPERATION
prompt ===============================
prompt
create sequence HBUH.SEQ_OPERATION
minvalue 1
maxvalue 9999999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_SPR_BUH_ID
prompt ================================
prompt
create sequence HBUH.SEQ_SPR_BUH_ID
minvalue 1
maxvalue 99999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_SPR_CATEGORY
prompt ==================================
prompt
create sequence HBUH.SEQ_SPR_CATEGORY
minvalue 1
maxvalue 9999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_SPR_COUNTS
prompt ================================
prompt
create sequence HBUH.SEQ_SPR_COUNTS
minvalue 1
maxvalue 999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_SPR_KURS
prompt ==============================
prompt
create sequence HBUH.SEQ_SPR_KURS
minvalue 1
maxvalue 999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating sequence SEQ_SPR_USERS
prompt ===============================
prompt
create sequence HBUH.SEQ_SPR_USERS
minvalue 1
maxvalue 999999
start with 1
increment by 1
cache 20;

prompt
prompt Creating view V_SPR_USER
prompt ========================
prompt
create or replace force view hbuh.v_spr_user as
select "ID","NAME"
    from hbuh.users;

prompt
prompt Creating view V_SPR_VALUT
prompt =========================
prompt
create or replace force view hbuh.v_spr_valut as
select id,cod,short_name,name
    from hbuh.spr_valut;

prompt
prompt Creating procedure OPERATION_DEL
prompt ================================
prompt
create or replace procedure hbuh.operation_del(v_id      in number,
                                          v_id_user in number,
                                          v_nout    out number,
                                          v_sout    out varchar2
                                          
                                          ) is
  -- last edit
  -- nva 
  -- 2015.11.17

begin
  declare
    v_cnt         number;
    
    v_owner_oper  number; -- owner opertion
  
    is_not_exist_operation exception;
    is_not_exist_categ     exception;
    is_not_your_count      exception;
    is_not_your_oper       exception;
    is_empty_values        exception;
    is_null_values         exception;
    is_dublicate_record    exception;
    is_not_exist_user      exception;
    is_not_exist_valut     exception;
  begin
    v_cnt  := 0;
    v_nout := 0;
    v_sout := 'Операция не выполнена';
    ----------- valid input values
    -- valid null
    if v_id_user is null then
      raise is_null_values;
    end if;
  
    -- valid empty
  
    if v_id_user = 0 then
      raise is_empty_values;
    end if;
  
    v_owner_oper := 0;
    select id_user into v_owner_oper from hbuh.operation where id = v_id;
    if v_owner_oper != v_id_user then
      -- it's necessary add full control for admin user
      raise is_not_your_oper;
    end if;
    -- valit exist value
  
    v_cnt := 0;
    select count(1) into v_cnt from hbuh.operation where id = v_id;
    if v_cnt != 0 then
      raise is_not_exist_operation;
    end if;
  
    v_cnt := 0;
    select count(1) into v_cnt from hbuh.users where id = v_id_user;
    if v_cnt != 0 then
      raise is_not_exist_user;
    end if;
  
    -- delete values
    delete from hbuh.operation where id = v_id;
  
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
      v_sout := 'Уже есть счет с таким названием. Операция не выполнена';
      rollback;
    when is_not_exist_user then
      v_nout := -4;
      v_sout := 'Заданный пользователь не найден. Операция не выполнена';
      rollback;
    when is_not_exist_valut then
      v_nout := -5;
      v_sout := 'Заданная валюта не найдена. Операция не выполнена';
      rollback;
    when is_not_your_count then
      v_nout := -6;
      v_sout := 'Нельзя вносить операции по счету владельцем которого вы не являетесь. Операция не выполнена';
      rollback;
    when is_not_exist_categ then
      v_nout := -7;
      v_sout := 'Не найдена указанная категория. Операция не выполнена';
      rollback;
    when is_not_exist_operation then
      v_nout := -8;
      v_sout := 'Не найдена указанная операция. Операция не выполнена';
      rollback;
    when is_not_your_oper then
      v_nout := -8;
      v_sout := 'Можно удалять только свои операции. Операция не выполнена';
      rollback;
    when others then
      v_nout := SQLCODe;
      v_sout := SUBSTR(SQLERRM, 1, 100);
      rollback;
  end;
end operation_del;
/

prompt
prompt Creating procedure OPERATION_INS
prompt ================================
prompt
create or replace procedure hbuh.operation_ins(v_id_user  in number,
                                          v_id_count in number,
                                          v_summa    in number,
                                          v_id_categ in number,
                                          v_nout     out number,
                                          v_sout     out varchar2
                                          
                                          ) is
  -- last edit
  -- nva 
  -- 2015.11.17

begin
  declare
    v_cnt         number;
    v_owner_count number; -- владелец счета
  
    is_not_exist_categ  exception;
    is_not_your_count   exception;
    is_empty_values     exception;
    is_null_values      exception;
    is_dublicate_record exception;
    is_not_exist_user   exception;
    is_not_exist_valut  exception;
  begin
    v_cnt  := 0;
    v_nout := 0;
    v_sout := 'Операция не выполнена';
    ----------- valid input values
    -- valid null
    if v_id_user is null or v_id_count is null or v_summa is null then
      raise is_null_values;
    end if;
  
    -- valid empty
  
    if v_id_user = 0 or v_id_count = 0 or v_summa = 0 then
      raise is_empty_values;
    end if;
  
    v_owner_count := 0;
    select id
      into v_owner_count
      from hbuh.spr_counts
     where id = v_id_count;
    if v_owner_count != v_id_count then
      -- it's necessary add full control for admin user
      raise is_not_your_count;
    end if;
  
    -- valit exist value
    v_cnt := 0;
    select count(1) into v_cnt from hbuh.users where id = v_id_user;
    if v_cnt != 0 then
      raise is_not_exist_user;
    end if;
  
    v_cnt := 0;
    select count(1)
      into v_cnt
      from hbuh.spr_category
     where id = v_id_categ;
    if v_cnt != 0 then
      raise is_not_exist_categ;
    end if;
  
    -- insert values
    insert into hbuh.operation
      (id, id_user, id_count, summa, id_categ)
    values
      (seq_operation.nextval, v_id_user, v_id_count, v_summa, v_id_categ);
  
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
      v_sout := 'Уже есть счет с таким названием. Операция не выполнена';
      rollback;
    when is_not_exist_user then
      v_nout := -4;
      v_sout := 'Заданный пользователь не найден. Операция не выполнена';
      rollback;
    when is_not_exist_valut then
      v_nout := -5;
      v_sout := 'Заданная валюта не найдена. Операция не выполнена';
      rollback;
    when is_not_your_count then
      v_nout := -6;
      v_sout := 'Нельзя вносить операции по счету владельцем которого вы не являетесь. Операция не выполнена';
      rollback;
    when is_not_exist_categ then
      v_nout := -7;
      v_sout := 'Не найдена указанная категория. Операция не выполнена';
      rollback;
    when others then
      v_nout := SQLCODe;
      v_sout := SUBSTR(SQLERRM, 1, 100);
      rollback;
  end;
end operation_ins;
/

prompt
prompt Creating procedure OPERATION_UPD
prompt ================================
prompt
create or replace procedure hbuh.operation_upd(v_id       in number,
                                          v_id_user  in number,
                                          v_id_count in number,
                                          v_summa    in number,
                                          v_id_categ in number,
                                          v_nout     out number,
                                          v_sout     out varchar2
                                          
                                          ) is
  -- last edit
  -- nva 
  -- 2015.11.17

begin
  declare
    v_cnt         number;
    v_owner_count number; -- owner count
    v_owner_oper  number; -- owner opertion
  
    is_not_exist_operation exception;
    is_not_exist_categ     exception;
    is_not_your_count      exception;
    is_not_your_oper       exception;
    is_empty_values        exception;
    is_null_values         exception;
    is_dublicate_record    exception;
    is_not_exist_user      exception;
    is_not_exist_valut     exception;
  begin
    v_cnt  := 0;
    v_nout := 0;
    v_sout := 'Операция не выполнена';
    ----------- valid input values
    -- valid null
    if v_id_user is null or v_id_count is null or v_summa is null then
      raise is_null_values;
    end if;
  
    -- valid empty
  
    if v_id_user = 0 or v_id_count = 0 or v_summa = 0 then
      raise is_empty_values;
    end if;
  
    v_owner_count := 0;
    select id
      into v_owner_count
      from hbuh.spr_counts
     where id = v_id_count;
    if v_owner_count != v_id_count then
      -- it's necessary add full control for admin user
      raise is_not_your_count;
    end if;
  
    v_owner_oper := 0;
    select id_user into v_owner_oper from hbuh.operation where id = v_id;
    if v_owner_oper != v_id_user then
      -- it's necessary add full control for admin user
      raise is_not_your_oper;
    end if;
    -- valit exist value
  
    v_cnt := 0;
    select count(1) into v_cnt from hbuh.operation where id = v_id;
    if v_cnt != 0 then
      raise is_not_exist_operation;
    end if;
  
    v_cnt := 0;
    select count(1) into v_cnt from hbuh.users where id = v_id_user;
    if v_cnt != 0 then
      raise is_not_exist_user;
    end if;
  
    v_cnt := 0;
    select count(1)
      into v_cnt
      from hbuh.spr_category
     where id = v_id_categ;
    if v_cnt != 0 then
      raise is_not_exist_categ;
    end if;
  
    -- insert values
    update hbuh.operation
       set id_user  = v_id_user,
           id_count = v_id_count,
           summa    = v_summa,
           id_categ = v_id_categ
     where id = v_id;
  
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
      v_sout := 'Уже есть счет с таким названием. Операция не выполнена';
      rollback;
    when is_not_exist_user then
      v_nout := -4;
      v_sout := 'Заданный пользователь не найден. Операция не выполнена';
      rollback;
    when is_not_exist_valut then
      v_nout := -5;
      v_sout := 'Заданная валюта не найдена. Операция не выполнена';
      rollback;
    when is_not_your_count then
      v_nout := -6;
      v_sout := 'Нельзя вносить операции по счету владельцем которого вы не являетесь. Операция не выполнена';
      rollback;
    when is_not_exist_categ then
      v_nout := -7;
      v_sout := 'Не найдена указанная категория. Операция не выполнена';
      rollback;
    when is_not_exist_operation then
      v_nout := -8;
      v_sout := 'Не найдена указанная операция. Операция не выполнена';
      rollback;
    when is_not_your_oper then
      v_nout := -8;
      v_sout := 'Можно изменять только свои операции. Операция не выполнена';
      rollback;
    when others then
      v_nout := SQLCODe;
      v_sout := SUBSTR(SQLERRM, 1, 100);
      rollback;
  end;
end operation_upd;
/

prompt
prompt Creating procedure SPR_CATEGORY_DEL
prompt ===================================
prompt
create or replace procedure hbuh.spr_category_del(v_id   in number,
                                             v_nout out number,
                                             v_sout out varchar2
                                             
                                             ) is
  -- nva 2015.10.28
  -- delete values in spr_category
begin
  declare
    v_cnt number;
  
    v_id_parent number;
  
    is_categ_used exception;
  
    is_not_exist_category exception;
  
  begin
    v_id_parent := 0;
    v_cnt       := 0;
    v_nout      := 0;
    v_sout      := 'Операция не выполнена';
    ----------- valid input values
    v_cnt := 0;
    select count(1) into v_cnt from hbuh.spr_category where id = v_id;
    if v_cnt != 0 then
      raise is_not_exist_category;
    end if;
  
    -- valid exist use category in operation and invert flag rashod
    v_cnt := 0;
    select count(1) into v_cnt from hbuh.operation where id_categ = v_id;
    if v_cnt <> 0 then
      raise is_categ_used;
    
    end if;
  
    --replace id_parent for child category, where parent this  category
    select id_parent
      into v_id_parent
      from hbuh.spr_category
     where id = v_id;
    update hbuh.spr_category
       set id_parent = v_id_parent
     where id_parent = v_id;
    -- delete values
    delete from hbuh.spr_category where id = v_id;
  
    commit;
    v_nout := 1;
    v_sout := 'Операция  выполнена';
  exception
    when is_not_exist_category then
      v_nout := -7;
      v_sout := 'Изменяемая категория не найдена. Операция не выполнена';
      rollback;
    
    when is_categ_used then
      v_nout := -8;
      v_sout := 'По данной категории уже были движения, удалять нельзя. Операция не выполнена';
      rollback;
    when others then
      v_nout := SQLCODe;
      v_sout := SUBSTR(SQLERRM, 1, 100);
      rollback;
  end;
end spr_category_del;
/

prompt
prompt Creating procedure SPR_CATEGORY_INS
prompt ===================================
prompt
create or replace procedure hbuh.spr_category_ins(v_id_parent in number,
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

prompt
prompt Creating procedure SPR_CATEGORY_UPD
prompt ===================================
prompt
create or replace procedure hbuh.spr_category_upd(v_id        in number,
                                             v_id_parent in number,
                                             v_is_rashod in number,
                                             v_name      in varchar2,
                                             v_nout      out number,
                                             v_sout      out varchar2
                                             
                                             ) is
  -- nva 2015.10.28
  -- insert values in spr_category
begin
  declare
    v_cnt           number;
    v_is_rashod_old number(1);
  
    is_empty_values       exception;
    is_null_values        exception;
    is_not_correct_values exception;
    is_dublicate_record   exception;
    is_dublicate_name     exception;
    is_not_exist_parent   exception;
    is_not_exist_category exception;
    cant_edit_flag_rashod exception;
  begin
    v_cnt  := 0;
    v_nout := 0;
    v_sout := 'Операция не выполнена';
    ----------- valid input values
    v_cnt := 0;
    select count(1) into v_cnt from hbuh.spr_category where id = v_id;
    if v_cnt != 0 then
      raise is_not_exist_category;
    end if;
  
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
    -- valid exist use category in operation and invert flag rashod
    v_cnt := 0;
    select count(1) into v_cnt from hbuh.operation where id_categ = v_id;
    if v_cnt <> 0 then
      --if this kateg used
      select is_rashod
        into v_is_rashod_old
        from hbuh.spr_category
       where id = v_id;
      if v_is_rashod_old != v_is_rashod then
        raise cant_edit_flag_rashod;
      end if;
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
     where id != v_id
       and id_parent = v_id_parent
       and is_rashod = v_is_rashod
       and name = upper(trim(v_name));
    if v_cnt <> 0 then
      raise is_dublicate_record;
    end if;
  
    v_cnt := 0;
    select count(1)
      into v_cnt
      from hbuh.spr_category
     where id != v_id
       and name = upper(trim(v_name));
    if v_cnt <> 0 then
      raise is_dublicate_name;
    end if;
    -- update values
    update hbuh.spr_category
       set id_parent = v_id_parent, is_rashod = v_is_rashod, name = v_name
     where id = v_id;
  
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
    when is_not_exist_category then
      v_nout := -7;
      v_sout := 'Изменяемая категория не найдена. Операция не выполнена';
      rollback;
    when cant_edit_flag_rashod then
      v_nout := -8;
      v_sout := 'По данной категории уже были движения, изменять признак расхода нельзя. Операция не выполнена';
      rollback;
    when others then
      v_nout := SQLCODe;
      v_sout := SUBSTR(SQLERRM, 1, 100);
      rollback;
  end;
end spr_category_upd;
/

prompt
prompt Creating procedure SPR_COUNTS_DEL
prompt =================================
prompt
create or replace procedure hbuh.spr_counts_del(v_id in number,
                                           
                                           v_nout out number,
                                           v_sout out varchar2
                                           
                                           ) is
  -- nva 2015.10.28
  -- insert values in spr_valut
begin
  declare
    v_cnt       number;
    v_old_valut number;
    is_empty_values exception;
    is_null_values  exception;
  
    is_not_exist_counts exception;
  
    is_count_used exception;
  begin
    v_cnt  := 0;
    v_nout := 0;
    v_sout := 'Операция не выполнена';
    ----------- valid input values
    -- valid null
    if v_id is null then
      raise is_null_values;
    end if;
  
    -- valit exist value
    v_cnt := 0;
    select count(1) into v_cnt from hbuh.spr_counts where id = v_id;
    if v_cnt != 0 then
      raise is_not_exist_counts;
    end if;
  
    v_cnt := 0;
    select count(1)
      into v_cnt
      from hbuh.operation
     where id_count = v_id;
    if v_cnt > 0 then
      raise is_count_used;
    end if;
  
    -- delete values
    delete from hbuh.spr_counts where id = v_id;
  
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
    
    when is_not_exist_counts then
      v_nout := -6;
      v_sout := 'Не найден изменяемый счет. Операция не выполнена';
      rollback;
    when is_count_used then
      v_nout := -7;
      v_sout := 'По счет было движение, менять валюту нельзя. Операция не выполнена';
      rollback;
    when others then
      v_nout := SQLCODe;
      v_sout := SUBSTR(SQLERRM, 1, 100);
      rollback;
  end;
end spr_counts_del;
/

prompt
prompt Creating procedure SPR_COUNTS_INS
prompt =================================
prompt
create or replace procedure hbuh.spr_counts_ins(v_id_user  in number,
                                           v_name     in varchar2,
                                           v_id_valut in number,
                                           v_nout     out number,
                                           v_sout     out varchar2
                                           
                                           ) is
  -- nva 2015.10.28
  -- insert values in spr_valut
begin
  declare
    v_cnt number;
    is_empty_values     exception;
    is_null_values      exception;
    is_dublicate_record exception;
    is_not_exist_user   exception;
    is_not_exist_valut  exception;
  begin
    v_cnt  := 0;
    v_nout := 0;
    v_sout := 'Операция не выполнена';
    ----------- valid input values
    -- valid null
    if v_id_user is null then
      raise is_null_values;
    end if;
  
    if v_name is null then
      raise is_null_values;
    end if;
  
    if v_id_valut is null then
      raise is_null_values;
    end if;
    -- valid empty
    if v_id_user = 0 then
      raise is_empty_values;
    end if;
  
    if v_id_valut = 0 then
      raise is_empty_values;
    end if;
  
    if length(trim(v_name)) = 0 then
      raise is_empty_values;
    end if;
    -- valit exist value
    v_cnt := 0;
    select count(1) into v_cnt from hbuh.users where id = v_id_user;
    if v_cnt != 0 then
      raise is_not_exist_user;
    end if;
    --
    v_cnt := 0;
    select count(1) into v_cnt from hbuh.spr_valut where id = v_id_valut;
    if v_cnt != 0 then
      raise is_not_exist_valut;
    end if;
  
    -- valid dublicat
    v_cnt := 0;
    select count(1)
      into v_cnt
      from hbuh.spr_counts
     where name = upper(v_name);
    if v_cnt <> 0 then
      raise is_dublicate_record;
    end if;
  
    -- insert values
    insert into hbuh.spr_counts
      (id, id_user, name, id_valut)
    values
      (hbuh.seq_spr_counts.nextval,
       v_id_user,
       upper(trim(v_name)),
       v_id_valut);
  
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
      v_sout := 'Уже есть счет с таким названием. Операция не выполнена';
      rollback;
    when is_not_exist_user then
      v_nout := -4;
      v_sout := 'Заданный пользователь не найден. Операция не выполнена';
      rollback;
    when is_not_exist_valut then
      v_nout := -5;
      v_sout := 'Заданная валюта не найдена. Операция не выполнена';
      rollback;
    when others then
      v_nout := SQLCODe;
      v_sout := SUBSTR(SQLERRM, 1, 100);
      rollback;
  end;
end spr_counts_ins;
/

prompt
prompt Creating procedure SPR_COUNTS_UPD
prompt =================================
prompt
create or replace procedure hbuh.spr_counts_upd(v_id       in number,
                                           v_id_user  in number,
                                           v_name     in varchar2,
                                           v_id_valut in number,
                                           v_nout     out number,
                                           v_sout     out varchar2
                                           
                                           ) is
  -- nva 2015.10.28
  -- insert values in spr_valut
begin
  declare
    v_cnt       number;
    v_old_valut number;
    is_empty_values     exception;
    is_null_values      exception;
    is_dublicate_record exception;
    is_not_exist_user   exception;
    is_not_exist_valut  exception;
    is_not_exist_counts exception;
  
    is_count_used exception;
  begin
    v_cnt  := 0;
    v_nout := 0;
    v_sout := 'Операция не выполнена';
    ----------- valid input values
    -- valid null
    if v_id is null then
      raise is_null_values;
    end if;
  
    if v_id_user is null then
      raise is_null_values;
    end if;
  
    if v_name is null then
      raise is_null_values;
    end if;
  
    if v_id_valut is null then
      raise is_null_values;
    end if;
    -- valid empty
    if v_id_user = 0 then
      raise is_empty_values;
    end if;
  
    if v_id_valut = 0 then
      raise is_empty_values;
    end if;
  
    if length(trim(v_name)) = 0 then
      raise is_empty_values;
    end if;
    -- valit exist value
    v_cnt := 0;
    select count(1) into v_cnt from hbuh.spr_counts where id = v_id;
    if v_cnt != 0 then
      raise is_not_exist_counts;
    end if;
  
    v_cnt := 0;
    select count(1) into v_cnt from hbuh.users where id = v_id_user;
    if v_cnt != 0 then
      raise is_not_exist_user;
    end if;
    --
    v_cnt := 0;
    select count(1) into v_cnt from hbuh.spr_valut where id = v_id_valut;
    if v_cnt != 0 then
      raise is_not_exist_valut;
    end if;
  
    -- valid dublicat
    v_cnt := 0;
    select count(1)
      into v_cnt
      from hbuh.spr_counts
     where id != v_id
       and name = upper(v_name);
    if v_cnt <> 0 then
      raise is_dublicate_record;
    end if;
    -- valid use count in opertaion
    v_old_valut := 0;
    select id_valut into v_old_valut from hbuh.spr_counts where id = v_id;
    -- проверить, если валюта изменяется и есть движение по этому счету, 
    -- то менять валюту счета нельзя
    if v_id_valut != v_old_valut then
      v_cnt := 0;
      select count(1)
        into v_cnt
        from hbuh.operation
       where id_count = v_id;
      if v_cnt > 0 then
        raise is_count_used;
      end if;
    end if;
  
    -- insert values
    update hbuh.spr_counts
       set id_user = v_id_user, name = upper(v_name), id_valut = v_id_valut
     where id = v_id;
  
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
      v_sout := 'Уже есть счет с таким названием. Операция не выполнена';
      rollback;
    when is_not_exist_user then
      v_nout := -4;
      v_sout := 'Заданный пользователь не найден. Операция не выполнена';
      rollback;
    when is_not_exist_valut then
      v_nout := -5;
      v_sout := 'Заданная валюта не найдена. Операция не выполнена';
      rollback;
    when is_not_exist_counts then
      v_nout := -6;
      v_sout := 'Не найден изменяемый счет. Операция не выполнена';
      rollback;
    when is_count_used then
      v_nout := -7;
      v_sout := 'По счет было движение, менять валюту нельзя. Операция не выполнена';
      rollback;
    when others then
      v_nout := SQLCODe;
      v_sout := SUBSTR(SQLERRM, 1, 100);
      rollback;
  end;
end spr_counts_upd;
/

prompt
prompt Creating procedure SPR_KURS_DEL
prompt ===============================
prompt
create or replace procedure hbuh.spr_kurs_del(v_id   in number,
                                         v_nout out number,
                                         v_sout out varchar2
                                         
                                         ) is
  -- nva 2015.10.28
  -- delete values in spr_kurs
begin
  declare
    v_cnt number;
    is_empty_values exception;
    is_null_values  exception;
    is_not_exists   exception;
  
  begin
    v_cnt  := 0;
    v_nout := 0;
    v_sout := 'Операция не выполнена';
    ----------- valid input values
    -- valid null
    if v_id is null then
      raise is_null_values;
    end if;
  
    --valid exists
    v_cnt := 0;
    select count(1) into v_cnt from hbuh.spr_kurs where id = v_id;
    if v_cnt = 0 then
      raise is_not_exists;
    end if;
  
    -- valid empty
    if v_id = 0 then
      raise is_empty_values;
    end if;
  
    -- update values
    delete from hbuh.spr_kurs where id = v_id;
  
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
    
    when is_not_exists then
      v_nout := -4;
      v_sout := 'Удаляемые данные не найдены. Операция отменена';
      rollback;
    when others then
      v_nout := SQLCODe;
      v_sout := SUBSTR(SQLERRM, 1, 100);
      rollback;
  end;
end spr_kurs_del;
/

prompt
prompt Creating procedure SPR_KURS_INS
prompt ===============================
prompt
create or replace procedure hbuh.spr_kurs_ins(v_date        in date,
                                         v_id_valuta1  in number,
                                         v_id_valuta2  in NUMBER,
                                         v_sum_valuta1 in number,
                                         v_sum_valuta2 in number,
                                         v_nout        out number,
                                         v_sout        out varchar2
                                         
                                         ) is
  -- nva 2015.10.28
  -- insert values in spr_kurs
begin
  declare
    v_cnt number;
    is_empty_values     exception;
    is_null_values      exception;
    is_dublicate_record exception;
  begin
    v_cnt  := 0;
    v_nout := 0;
    v_sout := 'Операция не выполнена';
    ----------- valid input values
    -- valid null
    if v_date is null or v_id_valuta1 is null or v_id_valuta2 is null or
       v_sum_valuta1 is null or v_sum_valuta2 is null then
      raise is_null_values;
    end if;
  
    -- valid empty
    if v_id_valuta1 = 0 or v_id_valuta2 = 0 or v_sum_valuta1 = 0 or
       v_sum_valuta1 = 0 then
      raise is_empty_values;
    end if;
  
    -- valid dublicat
    v_cnt := 0;
    select count(1)
      into v_cnt
      from hbuh.spr_kurs
     where date_kurs = v_date
       and id_valuta1 = v_id_valuta1
       and id_valuta2 = v_id_valuta2;
    if v_cnt <> 0 then
      raise is_dublicate_record;
    end if;
  
    -- insert values
    insert into hbuh.spr_kurs
      (id, date_kurs, id_valuta1, id_valuta2, sum_valuta1, sum_valuta2)
    values
      (hbuh.seq_spr_kurs.nextval,
       v_date,
       v_id_valuta1,
       v_id_valuta2,
       v_sum_valuta1,
       v_sum_valuta2);
  
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
      v_sout := 'На эту дату для этих валют уже есть заданный курс. Операция не выполнена';
      rollback;
    when others then
      v_nout := SQLCODe;
      v_sout := SUBSTR(SQLERRM, 1, 100);
      rollback;
  end;
end spr_kurs_ins;
/

prompt
prompt Creating procedure SPR_KURS_UPD
prompt ===============================
prompt
create or replace procedure hbuh.spr_kurs_upd(v_id          in number,
                                         v_date        in date,
                                         v_id_valuta1  in number,
                                         v_id_valuta2  in NUMBER,
                                         v_sum_valuta1 in number,
                                         v_sum_valuta2 in number,
                                         v_nout        out number,
                                         v_sout        out varchar2
                                         
                                         ) is
  -- nva 2015.10.28
  -- update values in spr_kurs
begin
  declare
    v_cnt number;
    is_empty_values     exception;
    is_null_values      exception;
    is_dublicate_record exception;
    is_not_exists       exception;
  
  begin
    v_cnt  := 0;
    v_nout := 0;
    v_sout := 'Операция не выполнена';
    ----------- valid input values
    -- valid null
    if v_date is null or v_id_valuta1 is null or v_id_valuta2 is null or
       v_sum_valuta1 is null or v_sum_valuta2 is null or v_id is null then
      raise is_null_values;
    end if;
  
    --valid exists
    v_cnt := 0;
    select count(1) into v_cnt from hbuh.spr_kurs where id = v_id;
    if v_cnt = 0 then
      raise is_not_exists;
    end if;
  
    -- valid empty
    if v_id_valuta1 = 0 or v_id_valuta2 = 0 or v_sum_valuta1 = 0 or
       v_sum_valuta1 = 0 or v_id = 0 then
      raise is_empty_values;
    end if;
  
    -- valid dublicat
    v_cnt := 0;
    select count(1)
      into v_cnt
      from hbuh.spr_kurs
     where id != v_id
       and date_kurs = v_date
       and id_valuta1 = v_id_valuta1
       and id_valuta2 = v_id_valuta2;
    if v_cnt <> 0 then
      raise is_dublicate_record;
    end if;
  
    -- update values
    update hbuh.spr_kurs
       set date_kurs   = v_date,
           id_valuta1  = v_id_valuta1,
           id_valuta2  = v_id_valuta2,
           sum_valuta1 = v_sum_valuta1,
           sum_valuta2 = v_sum_valuta2
     where id = v_id;
  
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
      v_sout := 'На эту дату для этих валют уже есть заданный курс. Операция не выполнена';
      rollback;
    when is_not_exists then
      v_nout := -4;
      v_sout := 'Редактируемые данные не найдены. Операция отменена';
      rollback;
    when others then
      v_nout := SQLCODe;
      v_sout := SUBSTR(SQLERRM, 1, 100);
      rollback;
  end;
end spr_kurs_upd;
/

prompt
prompt Creating procedure SPR_VALUT_DEL
prompt ================================
prompt
create or replace procedure hbuh.spr_valut_del(v_id   in number,
                                          v_nout out number,
                                          v_sout out varchar2
                                          
                                          ) is
  -- nva 2015.10.28
  -- update values in spr_valut
begin
  declare
    v_cnt number;
  
    is_used_spr_kurs   exception;
    is_used_spr_counts exception;
    is_no_valut        exception;
  begin
    v_cnt  := 0;
    v_nout := 0;
    v_sout := 'Операция не выполнена';
    ----------- valid input values
    v_cnt := 0;
    select count(1) into v_cnt from hbuh.spr_valut where id = v_id;
    if v_cnt != 0 then
      raise is_no_valut;
    end if;
  
    v_cnt := 0;
    select count(1)
      into v_cnt
      from hbuh.spr_kurs
     where id_valuta1 = v_id
        or id_valuta2 = v_id;
    if v_cnt != 0 then
      raise is_used_spr_kurs;
    end if;
  
    v_cnt := 0;
    select count(1) into v_cnt from hbuh.spr_counts where id_valut = v_id;
    if v_cnt != 0 then
      raise is_used_spr_counts;
    end if;
  
    -- delete values
    delete from hbuh.spr_valut where id = v_id;
  
    commit;
  
    v_nout := 1;
    v_sout := 'Операция  выполнена';
  exception
  
    when is_used_spr_kurs then
      v_nout := -2;
      v_sout := 'Валюта используется в справочнике курсов. Удалять нельзя. Операция не выполнена';
      rollback;
    when is_used_spr_counts then
      v_nout := -3;
      v_sout := 'Валюта используется в справочнике счетов. Удалять нельзя. Операция не выполнена';
      rollback;
    when is_no_valut then
      v_nout := -4;
      v_sout := 'изменяемая запись не найдена. Операция не выполнена';
      rollback;
    when others then
      v_nout := SQLCODe;
      v_sout := SUBSTR(SQLERRM, 1, 100);
      rollback;
  end;
end spr_valut_del;
/

prompt
prompt Creating procedure SPR_VALUT_INS
prompt ================================
prompt
create or replace procedure hbuh.spr_valut_ins(v_cod        in varchar2,
                                          v_short_name in varchar2,
                                          v_name       in varchar2,
                                          v_nout       out number,
                                          v_sout       out varchar2
                                          
                                          ) is
  -- nva 2015.10.28
  -- insert values in spr_valut
begin
  declare
    v_cnt number;
    is_empty_values     exception;
    is_null_values      exception;
    is_dublicate_record exception;
  begin
    v_cnt  := 0;
    v_nout := 0;
    v_sout := 'Операция не выполнена';
    ----------- valid input values
    -- valid null
    if v_cod is null then
      raise is_null_values;
    end if;
  
    if v_short_name is null then
      raise is_null_values;
    end if;
  
    if v_name is null then
      raise is_null_values;
    end if;
    -- valid empty
    if length(trim(v_cod)) = 0 then
      raise is_empty_values;
    end if;
  
    if length(trim(v_short_name)) = 0 then
      raise is_empty_values;
    end if;
  
    if length(trim(v_name)) = 0 then
      raise is_empty_values;
    end if;
    -- valid dublicat
    v_cnt := 0;
    select count(1)
      into v_cnt
      from hbuh.spr_valut
     where cod = upper(v_cod)
        or short_name = upper(v_short_name)
        or name = upper(v_name);
    if v_cnt <> 0 then
      raise is_dublicate_record;
    end if;
  
    -- insert values
    insert into hbuh.spr_valut
      (id, cod, short_name, name)
    values
      (hbuh.seq_spr_buh_id.nextval,
       upper(trim(v_cod)),
       upper(trim(v_short_name)),
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
      v_sout := 'Уже есть валюты содержащие такой код, название илии обозначение. Операция не выполнена';
      rollback;
    when others then
      v_nout := SQLCODe;
      v_sout := SUBSTR(SQLERRM, 1, 100);
      rollback;
  end;
end spr_valut_ins;
/

prompt
prompt Creating procedure SPR_VALUT_UPD
prompt ================================
prompt
create or replace procedure hbuh.spr_valut_upd(v_id         in number,
                                          v_cod        in varchar2,
                                          v_short_name in varchar2,
                                          v_name       in varchar2,
                                          v_nout       out number,
                                          v_sout       out varchar2

                                          ) is
  -- nva 2015.10.28
  -- update values in spr_valut
begin
  declare
    v_cnt number;
    is_empty_values     exception;
    is_null_values      exception;
    is_dublicate_record exception;
    is_no_valut         exception;
  begin
    v_cnt  := 0;
    v_nout := 0;
    v_sout := 'Операция не выполнена';
    ----------- valid input values
    v_cnt := 0;
    select count(1) into v_cnt from hbuh.spr_valut where id = v_id;
    if v_cnt != 0 then
      raise is_no_valut;
    end if;

    -- valid null
    if v_cod is null then
      raise is_null_values;
    end if;

    if v_short_name is null then
      raise is_null_values;
    end if;

    if v_name is null then
      raise is_null_values;
    end if;
    -- valid empty
    if length(trim(v_cod)) = 0 then
      raise is_empty_values;
    end if;

    if length(trim(v_short_name)) = 0 then
      raise is_empty_values;
    end if;

    if length(trim(v_name)) = 0 then
      raise is_empty_values;
    end if;
    -- valid dublicat
    v_cnt := 0;
    select count(1)
      into v_cnt
      from hbuh.spr_valut
     where id!=v_id and (cod = upper(v_cod)
        or short_name = upper(v_short_name)
        or name = upper(v_name));
    if v_cnt <> 0 then
      raise is_dublicate_record;
    end if;

    -- insert values
    update hbuh.spr_valut set
    cod=v_cod,
    short_name=v_short_name,
    name=v_name
    where id=v_id;

    commit;
     v_nout := 1;
    v_sout := 'Операция выполнена';
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
      v_sout := 'Уже есть валюты содержащие такой код, название илии обозначение. Операция не выполнена';
      rollback;
    when is_no_valut then
      v_nout := -4;
      v_sout := 'изменяемая запись не найдена. Операция не выполнена';
      rollback;
    when others then
      v_nout := SQLCODe;
      v_sout := SUBSTR(SQLERRM, 1, 100);
      rollback;
  end;
end spr_valut_upd;
/


spool off
