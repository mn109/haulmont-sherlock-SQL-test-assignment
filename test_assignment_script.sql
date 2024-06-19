-- Calculate the group averages and determine whether each student's average is above his group average
WITH GroupAVG AS (
    SELECT
        s.`Группа`,
        AVG(e.`Оценка`) AS `Средняя оценка по группе`
    FROM
        `Студенты` AS s
        JOIN `Результаты экзаменов` AS e
        ON s.`Номер зачетной книжки` = e.`Номер зачетной книжки`
    GROUP BY
        s.`Группа`
)
SELECT
    s.`ФИО`,
    s.`Группа`,
    AVG(e.`Оценка`) AS `Средняя оценка студента`,
    IF(
        AVG(e.`Оценка`) > ga.`Средняя оценка по группе`,
        'Да',
        'Нет'
    ) AS `Выше средней оценки по группе`
FROM
    `Студенты` AS s
    JOIN `Результаты экзаменов` AS e
    ON s.`Номер зачетной книжки` = e.`Номер зачетной книжки`
    JOIN GroupAVG AS ga
    ON s.`Группа` = ga.`Группа`
GROUP BY
    s.`ФИО`, s.`Группа`, ga.`Средняя оценка по группе`;