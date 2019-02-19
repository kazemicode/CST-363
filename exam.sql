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
SELECT lastname, firstname, s.studentid
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
SELECT t.instructor AS 'Calculus 1 Instructor', COUNT(*) AS 'Number Enrolled in Calculus 2'
FROM enrollment e
JOIN
	(
	SELECT instructor, courseid
	FROM course 
	WHERE name = 'Calculus 1'
	)t
ON t.courseid = e.courseid    
WHERE courseid IN -- gets all rows that refer to students enrolled in Calc 2
	(
    SELECT courseid
	FROM course 
	WHERE name = 'Calculus 2'
    )
GROUP BY t.instructor;


