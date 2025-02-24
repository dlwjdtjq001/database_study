use hr;
-- HR 부서의 어떤 사원은 급여정보를 조회하는 업무를 맡고 있다. Tucker 사원보다 급여 를 많이 받고 있는 사원의 성과 이름(Name으로 별칭), 업무, 급여를 출력하시오
select concat(first_name , ' ' , last_name) as Name, job_id, salary
from employees
where salary > (select salary from employees where last_name = 'Tucker');
-- 사원의 급여 정보 중 업무별 최소 급여를 받는 사원의 성과 이름(Name으로 별칭), 업무,급여, 입사일을 출력하시오

select concat(e1.first_name, ' ', e1.last_name) as Name, job_id, salary, hire_date
from employees e1
where e1.salary = (select min(e2.salary) from employees e2 where e1.job_id = e2.job_id);

-- 소속 부서의 평균 급여보다 많은 급여를 받는 사원의 성과 이름(Name으로 별칭), 급여,부서번호, 업무를 출력하시오
select concat(e1.first_name, ' ', e1.last_name) as Name, e1.salary, e1.department_id, e1.job_id
from employees e1
where salary >(select avg(salary) from employees e2 where e1.department_id = e2.department_id);
-- 사원들의 지역별 근무 현황을 조회하고자 한다. 도시 이름이 영문 ‘O’로 시작하는 지역에 살고 있는 사원의 사번, 성과 이름(Name으로 별칭), 업무, 입사일을 출력하시오
 select concat(first_name, ' ', last_name) as Name, job_id, hire_date
 from employees
 where department_id=(select department_id from departments
 where location_id=(select location_id from locations where city like 'O%'));


-- 시애틀에 사는 사람 중 커미션을 버는 모든 사람들의 LAST_NAME, 부서 명, 지역 ID 및 도시 명을 조회한다.
select last_name
, (select d.department_name from departments d where d.department_id = e.department_id)
, (select city from locations l where l.location_id = (select location_id from departments where department_id = e.department_id ))
from employees e 
where (e.commission_pct is not null) and (e.department_id = (select department_id from departments where location_id =
(select location_id from locations where city = 'seattle')));

-- LAST_NAME 이 DAVIES 인 사람보다 후에 고용된 사원들의 LAST_NAME 및 HIRE_DATE 을 조회한다.

-- 매니저로 근무하는 사원들의 총 수를 조회한다.

-- LAST_NAME 이 Zlotkey 와 동일한 부서에 근무하는 모든 사원들의 사번 및 고용날짜를 조회한다.