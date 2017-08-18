--Write a query IDing type of each record in the TRIANGLES table using its 3 side lengths. 
-- Output one of the following statements for each record in the table:
--	-	Equilateral: It's a triangle with  sides of equal length.
--	-	Isosceles: It's a triangle with  sides of equal length.
--	-	Scalene: It's a triangle with  sides of differing lengths.
--	-	Not A Triangle: The given values of A, B, and C don't form a triangle.
SELECT 
    CASE      
        WHEN (A + B) > C
            AND (A + C) > B
            AND (B + C) > A  -- 2 combined sides must be > 3rd side      
                THEN CASE
                    WHEN (A = B) AND (B = C) AND (A = C) THEN 'Equilateral' -- 3 equal sides
                    WHEN (A = B) OR (B = C) OR (C = A) THEN 'Isosceles'   -- 2 equal sides     
                    WHEN (A != B) OR (B != C) OR (C != A) THEN 'Scalene'  -- No equal sides      
                END
         ELSE 'Not A Triangle'
    END
FROM TRIANGLES

--Query an alphabetically ordered list of all names in OCCUPATIONS, immediately followed by the 1ST letter of each profession as a parenthetical (enclosed in parentheses). 
--	- Ex: AnActorName(A), ADoctorName(D), AProfessorName(P), and ASingerName(S).
-- Query the number of ocurrences of each occupation in OCCUPATIONS. 
--	- Sort the occurrences in ASC order, and output them in the following format: There are a total of [occupation_count] [occupation]s.
--	- where [occupation_count] is the # of occurrences of an occupation in OCCUPATIONS and [occupation] is the lowercase occupation name. 
--	- If more than 1 Occupation has the same [occupation_count], they should be ordered alphabetically.
-- Note: There will be at least 2 entries in the table for each type of occupation.
SELECT concat(Name,'(', LEFT(Occupation,1), ')')
        -- Name + '(' + LEFT(Occupation ,1) + ')' 
FROM OCCUPATIONS
ORDER BY Name

SELECT concat('There are a total of ',COUNT(Occupation),' ',LOWER(Occupation),'s.')
FROM OCCUPATIONS
GROUP BY Occupation
ORDER BY COUNT(Occupation)

