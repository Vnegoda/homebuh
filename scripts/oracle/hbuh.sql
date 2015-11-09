------------------------------------------
-- Export file for user HBUH            --
-- Created by m on 08.11.2015, 23:17:33 --
------------------------------------------

set define off
spool hbuh.log

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
    is_empty_values exception;
    is_null_values  exception;
    is_dublicate_record exception;
  begin
    v_cnt:=0;
    v_nout := 0;
    v_sout := '???????? ?? ?????????';
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
    v_cnt:=0;
    select  count(1) into v_cnt from hbuh.spr_valut 
            where cod=upper(v_cod)
                  or short_name=upper(v_short_name)
                  or name = upper(v_name);
    if v_cnt<>0 then
      raise is_dublicate_record;
    end if;
    
  -- insert values 
    insert into hbuh.spr_valut
      (id, cod, short_name, name)
    values
      (hbuh.spr_buh_id.nextval, upper(trim(v_cod)), upper(trim(v_short_name)), upper(trim(v_name)));
  
    commit;
  exception
    when is_empty_values then
      v_nout := 1;
      v_sout := '???? ?????? ???????????? ?????????. ???????? ?? ?????????';
      rollback;
    when is_null_values then
      v_nout := 2;
      v_sout := '???? ???????????? ????????? ?????????? null. ???????? ?? ?????????';
      rollback;   
         when is_dublicate_record then
      v_nout := 3;
      v_sout := '???????????? ??????. ???????? ?? ?????????';
      rollback;  
    when others then
      v_nout := SQLCODe;
      v_sout := SUBSTR(SQLERRM, 1, 100);
      rollback;
  end;
end spr_valut_ins;
/

prompt
prompt Creating procedure TESTEXC
prompt ==========================
prompt
create or replace procedure hbuh.testexc is

begin
     DECLARE     err_num  number;
      err_msg  CHAR(100);
    begin

               err_num := 1;
                err_msg := '?????? ???';
    
                 err_num := SQLCODe;
                err_msg := SUBSTR(SQLERRM, 1, 100);
    end;
end testexc;
/


spool off
