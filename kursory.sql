declare
  n number;
begin
  select 1 into n from dual;
  dbms_output.put_line('pobrano ' || SQL%ROWCOUNT ||' wierszy');
end;

------------------------------------------------
declare
  type rek is RECORD (
    m ZC_SAMOCHODY.MARKA%TYPE,
    w ZC_SAMOCHODY.WERSJA%TYPE,
    s ZC_SAMOCHODY.SILNIK%TYPE
    );
   aa rek;
begin
    select 
    ZC_SAMOCHODY.MARKA,
    ZC_SAMOCHODY.WERSJA,
    ZC_SAMOCHODY.SILNIK into aa from ZC_samochody 
    where rownum = 1;
    
    DBMS_OUTPUT.PUT_LINE(aa.w);
EXCEPTION 
  when too_many_rows then DBMS_OUTPUT.PUT_LINE('wiecej ni¿ jeden rekord w sql');
  when no_data_found then DBMS_OUTPUT.PUT_LINE('brak rekordow');
end;
--------------------------------------------------
-- Czytanie wielu rekordow bez kursora jawnego
declare
begin
  for i in (  select 
              ZC_SAMOCHODY.MARKA,
              ZC_SAMOCHODY.WERSJA,
              ZC_SAMOCHODY.SILNIK from ZC_samochody 
            )LOOP
    DBMS_OUTPUT.PUT_LINE(i.MARKA ||' - '|| i.WERSJA);        
  end loop;          
end;
--------------------------------------------------
-- tu mamy przypisanie wielu rekordow do zmiennych i wyswietlenie ich

declare
  type rek is RECORD (
    m ZC_SAMOCHODY.MARKA%TYPE,
    w ZC_SAMOCHODY.WERSJA%TYPE,
    s ZC_SAMOCHODY.SILNIK%TYPE
    );
   aa rek;
begin
  for i in (  select 
              ZC_SAMOCHODY.MARKA,
              ZC_SAMOCHODY.WERSJA,
              ZC_SAMOCHODY.SILNIK into aa from ZC_samochody 
            )LOOP
    aa.m := i.MARKA;
    aa.w := i.wersja;
    aa.s := i.SILNIK;    
    DBMS_OUTPUT.PUT_LINE(aa.m ||' - '|| aa.w || aa.s);        
  DBMS_OUTPUT.put_line('"'||SQL%rowcount||'"');  
  end loop;          

EXCEPTION 
  when too_many_rows then DBMS_OUTPUT.PUT_LINE('wiecej ni¿ jeden rekord w sql');
  when no_data_found then DBMS_OUTPUT.PUT_LINE('brak rekordow');
end;

----------------------------------------------------------
-- deklarowanie kursora jawnego

DECLARE
  m   zc_samochody.marka%TYPE;
  w   zc_samochody.wersja%TYPE;
  s   zc_samochody.silnik%TYPE;
  CURSOR kur IS SELECT
    zc_samochody.marka,
    zc_samochody.wersja,
    zc_samochody.silnik
                FROM
    zc_samochody;

BEGIN
  OPEN kur;
    LOOP
      FETCH kur INTO m,w,s;
      EXIT WHEN kur%notfound;
      dbms_output.put_line(m);
    END LOOP;
  CLOSE kur;
END;
----------------------------------------------------------
-- dynamiczny kursor, procedura
create or replace procedure ZC_dyn_kur(in_marka in VARCHAR) is 
--declare
  m   zc_samochody.marka%TYPE;
  w   zc_samochody.wersja%TYPE;
  s   zc_samochody.silnik%TYPE;
  cursor wynik is 
    SELECT
        zc_samochody.marka,
        zc_samochody.wersja,
        zc_samochody.silnik
    FROM zc_samochody where marka= 'BMW';
   
begin
  open wynik;
    loop fetch wynik into m,w,s;
      EXIT WHEN wynik%notfound;
      dbms_output.put_line(m||'--'||w||'--'||s);
    end loop;
  close wynik;
end;











edeclare
  n number;
begin
  select 1 into n from dual;
  dbms_output.put_line('pobrano ' || SQL%ROWCOUNT ||' wierszy');
end;

------------------------------------------------
declare
  type rek is RECORD (
    m ZC_SAMOCHODY.MARKA%TYPE,
    w ZC_SAMOCHODY.WERSJA%TYPE,
    s ZC_SAMOCHODY.SILNIK%TYPE
    );
   aa rek;
begin
    select 
    ZC_SAMOCHODY.MARKA,
    ZC_SAMOCHODY.WERSJA,
    ZC_SAMOCHODY.SILNIK into aa from ZC_samochody 
    where rownum = 1;
    
    DBMS_OUTPUT.PUT_LINE(aa.w);
EXCEPTION 
  when too_many_rows then DBMS_OUTPUT.PUT_LINE('wiecej ni¿ jeden rekord w sql');
  when no_data_found then DBMS_OUTPUT.PUT_LINE('brak rekordow');
end;
--------------------------------------------------
-- Czytanie wielu rekordow bez kursora jawnego
declare
begin
  for i in (  select 
              ZC_SAMOCHODY.MARKA,
              ZC_SAMOCHODY.WERSJA,
              ZC_SAMOCHODY.SILNIK from ZC_samochody 
            )LOOP
    DBMS_OUTPUT.PUT_LINE(i.MARKA ||' - '|| i.WERSJA);        
  end loop;          
end;
--------------------------------------------------
-- tu mamy przypisanie wielu rekordow do zmiennych i wyswietlenie ich

declare
  type rek is RECORD (
    m ZC_SAMOCHODY.MARKA%TYPE,
    w ZC_SAMOCHODY.WERSJA%TYPE,
    s ZC_SAMOCHODY.SILNIK%TYPE
    );
   aa rek;
begin
  for i in (  select 
              ZC_SAMOCHODY.MARKA,
              ZC_SAMOCHODY.WERSJA,
              ZC_SAMOCHODY.SILNIK into aa from ZC_samochody 
            )LOOP
    aa.m := i.MARKA;
    aa.w := i.wersja;
    aa.s := i.SILNIK;    
    DBMS_OUTPUT.PUT_LINE(aa.m ||' - '|| aa.w || aa.s);        
  DBMS_OUTPUT.put_line('"'||SQL%rowcount||'"');  
  end loop;          

EXCEPTION 
  when too_many_rows then DBMS_OUTPUT.PUT_LINE('wiecej ni¿ jeden rekord w sql');
  when no_data_found then DBMS_OUTPUT.PUT_LINE('brak rekordow');
end;

----------------------------------------------------------
-- deklarowanie kursora jawnego

declare
    m ZC_SAMOCHODY.MARKA%TYPE;
    w ZC_SAMOCHODY.WERSJA%TYPE;
    s ZC_SAMOCHODY.SILNIK%TYPE;

cursor kur is 
  select ZC_SAMOCHODY.MARKA,
         ZC_SAMOCHODY.WERSJA,
         ZC_SAMOCHODY.SILNIK 
    from ZC_samochody;
    
begin
  OPEN kur;
    loop fetch kur into m, w ,s;
     exit when kur%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE(m);
    end loop;
  CLOSE kur;
end;
/******************************************************************/
/*****    Uruchomienie procedury     ******************************/
BEGIN
  for i in (select distinct ZC_SAMOCHODY.MARKA from ZC_samochody ) 
  loop
    ZC_dyn_kur(i.MARKA);
  end loop;
END;


