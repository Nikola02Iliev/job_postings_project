WITH ranked_skills AS (
  SELECT
    role,
    skill,
    yearly_salary,
    COUNT(*) OVER (PARTITION BY skill ORDER BY yearly_salary DESC) AS rn
  FROM (
    SELECT
      job_postings.job_title_short AS role,
      subquery_skills.skill,
      job_postings.salary_year_avg AS yearly_salary
    FROM job_postings_fact AS job_postings
    INNER JOIN 
    (
      SELECT sk.skills AS skill,
      sj.job_id
      FROM skills_job_dim AS sj
      INNER JOIN skills_dim AS sk ON sj.skill_id = sk.skill_id
    ) AS subquery_skills ON job_postings.job_id = subquery_skills.job_id
    WHERE 
      job_postings.salary_year_avg IS NOT NULL
      AND job_postings.job_title_short = 'Business Analyst'
    GROUP BY role, subquery_skills.skill, yearly_salary
  ) AS grouped_data
)
SELECT role, skill, yearly_salary
FROM ranked_skills
WHERE rn = 1
ORDER BY yearly_salary DESC



