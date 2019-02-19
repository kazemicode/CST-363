-- exam 

-- #3
SELECT lastname, firstname
FROM student
wHERE (major = 'Biology') AND 
(GPA >= 3.0 AND GPA <= 3.5)
ORDER BY lastname;

-- #4
SELECT major, COUNT(*) AS numberOfStudents, AVG(gpa) AS averageGPA
FROM student
GROUP BY major;

-- #5
SELECT lastname, firstname
FROM student s
JOIN enrollment e
WHERE s.studentid = e.studentid
AND e.courseid IN (
	SELECT courseid
    FROM course
    WHERE name = 'Discrete Math')
AND grade IN ('A', 'B')
ORDER BY lastname, firstname;

-- # 6
SELECT c.courseid, name, COUNT(studentid) AS numEnrolled
FROM enrollment e
RIGHT OUTER JOIN course c
ON c.courseid = e.courseid
GROUP BY courseid
ORDER BY courseid;


-- #7
SELECT lastname, firstname
FROM student s
JOIN
	( -- subquery gets all students who passed Calc 1 with a C or better
    SELECT studentid
    FROM enrollment
    WHERE grade IN ('A', 'B', 'C')
	AND courseid IN
        (
        SELECT courseid
		FROM course
		WHERE name = 'Calculus 1'
		)
	)t
    ON t.studentid = s.studentid
    AND s.studentid IN 
		( -- subquery gets all students enrolled in Calc 2 in Spring 2017
		SELECT studentid
		FROM enrollment
		WHERE semester = '2017Sp'
		AND courseid IN
			(
			SELECT courseid
			FROM course
			WHERE name = 'Calculus 2'
			)
	)
ORDER BY lastname, firstname;

-- #8
SELECT instructor as Calc1Instructor, COUNT(DISTINCT e2.studentid) AS NumberTakingCalc2, AVG(t.points) AS AverageGradeCalculus2
FROM enrollment e1
JOIN course c
ON e1.courseid = c.courseid
AND e1.courseid IN (
	SELECT courseid 
	FROM course
	WHERE name = "Calculus 1")
JOIN enrollment e2
ON e1.studentid = e2.studentid
AND e2.courseid IN (
	SELECT courseid
	FROM course
	WHERE name = "Calculus 2")
JOIN (SELECT courseid, studentid, CASE grade
	WHEN 'A' THEN 4.0
    WHEN 'B' THEN 3.0
    WHEN 'C' THEN 2.0
    WHEN 'D' THEN 1.0
    WHEN 'F' THEN 0.0
	END AS points
    FROM enrollment) t
ON t.courseid = e2.courseid
AND t.studentid = e2.studentid
GROUP BY instructor;

-- #9
SELECT courseid, name, semester, grade, units
FROM (SELECT c.courseid, name, semester, grade, units, CASE semester
	WHEN '2016Sp' THEN 1
    WHEN '2016Fa' THEN 2
    WHEN '2017Sp' THEN 3
    WHEN '2017Fa' THEN 4
    end as semester_order
FROM enrollment e
JOIN course c
ON c.courseid = e.courseid
WHERE studentid = 4456
)t
ORDER BY t.semester_order;

-- # 10
SELECT studentid
FROM enrollment e
WHERE studentid NOT IN 
	(
	SELECT e1.studentid
	FROM enrollment e1
	JOIN enrollment e2
    ON e1.studentid = e2.studentid
    AND e1.courseid = e2.courseid
    AND e1.semester != e2.semester
    WHERE e1.courseid IN (
		SELECT courseid
		FROM course
		WHERE name = "Discrete Math")
	)
and 
	studentid NOT IN
    (
    SELECT studentid
    FROM enrollment 
    WHERE courseid IN (
		SELECT courseid  
        FROM course
        WHERE name = "Discrete Math")
	AND grade IN ('A', 'B', 'C')  
    )
AND courseid IN (
		SELECT courseid
		FROM course
		WHERE name = "Discrete Math");
        
-- #11
UPDATE enrollment
SET grade = 'B'
WHERE studentid = 4456
AND courseid IN (
	SELECT courseid 
    FROM course 
    WHERE name = 'Discrete Math')
AND semester = '2017Sp'
AND grade = 'C';
        