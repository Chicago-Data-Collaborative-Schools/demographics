create table twentieth_day_school as
with ever_student as (
  select
    "School ID",
    "School",
    grade
  from
    twentieth_day_report
  where
    students is not null
    and "School" != ''
    and "School" not like 'District Total%'
  group by
    "School ID",
    "School",
    grade
  having
    sum(students) > 1
)
select
  *
from
  twentieth_day_report
  inner join ever_student using ("School ID", "School", grade);

DROP TABLE twentieth_day_report;

