SELECT
skills_query.skill,
COUNT(skills_query.job_id) AS number_of_jobs
FROM job_postings_fact AS job_postings
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
WHERE  job_postings.job_title_short IN('Business Analyst')
GROUP BY skills_query.skill
ORDER BY COUNT(skills_query.job_id) DESC;