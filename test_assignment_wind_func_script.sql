-- Calculate the group averages and determine whether each student's average is above his group average through the use of window functions
WITH StudentAverages AS (
    SELECT
        s.`ФИО`,
        s.`Группа`,
        ROUND(AVG(e.`Оценка`), 2) AS `Средняя оценка студента`,
        ROUND(AVG(AVG(e.`Оценка`)) OVER (PARTITION BY s.`Группа`), 2) AS `Средняя оценка по группе`
    FROM
        `Студенты` AS s
        JOIN `Результаты экзаменов` AS e USING (`Номер зачетной книжки`)
    GROUP BY
        s.`ФИО`, s.`Группа`
)
SELECT
    `ФИО`,
    `Группа`,
    `Средняя оценка студента`,
    `Средняя оценка по группе`,
    IF(
        `Средняя оценка студента` > `Средняя оценка по группе`,
        'Да',
        'Нет'
    ) AS `Выше средней оценки по группе`
FROM
    StudentAverages;