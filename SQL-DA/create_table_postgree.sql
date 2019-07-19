CREATE TABLE test (
    id INT,
    start_time TIME,
    end_time TIME
);

INSERT INTO test (id, start_time, end_time) VALUES (1, '09:00', '10:30');
INSERT INTO test (id, start_time, end_time) VALUES (2, '09:30', '11:00');
INSERT INTO test (id, start_time, end_time) VALUES (3, '13:00', '14:00');
INSERT INTO test (id, start_time, end_time) VALUES (4, '15:00', '16:00');


/*Query*/
SELECT MAX(min_room)
FROM (SELECT COUNT(*) min_room
     FROM test t
     left join test y
     on t.start_time between y.start_time and y.end_time
     GROUP BY t.id) z;

 WITH will_catch AS (
    SELECT p.id  pid, MIN(CAST(t.departure_time AS TIME)) AS t_deptime
    FROM passengers p
    LEFT JOIN trains t ON t.origin = p.origin AND t.dest = p.dest
        AND CAST(t.departure_time AS TIME) >= CAST(p.departure_time AS TIME)
    GROUP BY p.id
)
SELECT t.id, COUNT(t_deptime)
FROM will_catch wc
LEFT JOIN passengers p ON wc.pid = p.id
LEFT JOIN trains t ON (p.origin = t.origin AND p.dest = t.dest) 
    AND (wc.t_deptime = CAST(t.departure_time AS TIME) OR t_deptime IS NULL)
GROUP BY t.id