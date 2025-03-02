SELECT
job_postings.job_title_short AS role,
companies_query.company_name,
skills_query.skill,
job_postings.salary_year_avg AS yearly_salary
FROM job_postings_fact AS job_postings
INNER JOIN
(
    SELECT
    company_id,
    name AS company_name
    FROM company_dim AS companies
) AS companies_query ON job_postings.company_id = companies_query.company_id
INNER JOIN
(
SELECT 
    skills_job.job_id,
    skills.skill
FROM skills_job_dim AS skills_job
INNER JOIN
(
    SELECT
        skills.skill_id,
        skills.skills AS skill
    FROM skills_dim AS skills
) AS skills ON skills_job.skill_id = skills.skill_id
) AS skills_query ON job_postings.job_id = skills_query.job_id
WHERE 
job_postings.job_title_short IN('Business Analyst') AND 
job_postings.salary_year_avg IS NOT NULL
ORDER BY yearly_salary DESC
LIMIT 50;