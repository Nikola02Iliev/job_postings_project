SELECT
job_postings.job_title_short AS role,
companies_query.company_name,
job_postings.salary_year_avg AS yearly_salary
FROM job_postings_fact AS job_postings
INNER JOIN
(
    SELECT
    company_id,
    name AS company_name
    FROM company_dim AS companies
) AS companies_query ON job_postings.company_id = companies_query.company_id
WHERE 
job_postings.job_title_short IN('Business Analyst') AND 
job_postings.salary_year_avg IS NOT NULL
ORDER BY yearly_salary DESC
LIMIT 10;
