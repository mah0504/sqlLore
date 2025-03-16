
with recursive fibo(a,b) as (select 0, 1
union select b,a+b from fibo where b < 100)
select a from fibo;

