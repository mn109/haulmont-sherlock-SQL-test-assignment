-- Calculate the group averages and determine whether each student's average is above his group average through the use of window functions
WITH StudentAverages AS (
    SELECT
        s.`ФИО`,
        s.`Группа`,
        AVG(e.`Оценка`) AS `Средняя оценка студента`,
        AVG(AVG(e.`Оценка`)) OVER (PARTITION BY s.`Группа`) AS `Средняя оценка по группе`
    FROM
        `Студенты` AS s
        JOIN `Результаты экзаменов` AS e ON s.`Номер зачетной книжки` = e.`Номер зачетной книжки`
    GROUP BY
        s.`ФИО`, s.`Группа`
)
SELECT
    `ФИО`,
    `Группа`,
    `Средняя оценка студента`,
    IF(
        `Средняя оценка студента` > `Средняя оценка по группе`,
        'Да',
        'Нет'
    ) AS `Выше средней оценки по группе`
FROM
    StudentAverages;