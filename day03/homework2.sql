-- 1. 모든 사원은 직속 상사 및 직속 직원을 갖는다. 최상위 또는 최하위 직원은 직속 상사 및 직원이 없다. 소속된 사원 중 어떤 사원의 상사로 근무중인 사원의 총 수를 출력하시오
show databases;
use hr;
show tables;
desc employees;
select * from employees;
select count(distinct manager_id)
from employees
;

-- 2 각 사원이 소속된 부서별로 급여 한계, 급여 평슌, 급여 최대값, 급여 최솟값을 집계하고자 한다. 계산된 출력값은 여섯자리와 세자리 구분기호, $ 표시와 함꼐 출력하고
-- 부서번호의 오름ㅁ차순 정렬하시오. 단 부서에 소속되지 않은 사원에 대한 정보는 제외하고 출력시 머리글은 다음처럼 별칭 처리하시오.
select
    department_id as "부서아이디",
    concat(sum(salary), '$') as "급여합계",
    concat(avg(salary), '$') as "급여평균",
    concat(max(salary), '$') as "급여최대",
    concat(min(salary), '$') as "급여최소"
from employees
group by department_id
order by department_id;


-- 3. 사원들의 업무별 전체 급여 평균이 $10,000보다 큰 경우를 조회하여 업무, 급여 평균을 출력하시오. 
-- 단 업무에 사원(CLERK)이 포함된 경우는 제외하고 전체 급여 평균이 높은 순서대로 출력하시오(7행) 
select job_id,avg(salary)
from employees
group by job_id
having avg(salary) > 10000
order by avg(salary) desc;



