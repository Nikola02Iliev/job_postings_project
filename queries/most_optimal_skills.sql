WITH ranked_skills_optimality AS
(
SELECT 
subquery.skill AS skill,
COUNT(job_postings.job_id) AS number_of_jobs,
MAX(job_postings.salary_year_avg) AS yearly_salary,
COUNT(job_postings.job_id) * MAX(job_postings.salary_year_avg) AS optimality_coefficient
FROM job_postings_fact AS job_postings
INNER JOIN
(
    SELECT 
    skills_job.job_id AS job_id,
    skills.skills AS skill,
    skills.skill_id AS skill_id
    FROM skills_job_dim AS skills_job
    INNER JOIN skills_dim AS skills ON skills_job.skill_id = skills.skill_id
) AS subquery ON job_postings.job_id = subquery.job_id
WHERE salary_year_avg IS NOT NULL
GROUP BY skill
)

SELECT
skill,
number_of_jobs,
yearly_salary,
optimality_coefficient
FROM ranked_skills_optimality
ORDER BY optimality_coefficient DESC;



