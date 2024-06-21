-- Calculate the group averages and determine whether each student's average is above his group average
WITH GroupAVG AS (
    SELECT
        s.`Группа`,
        AVG(e.`Оценка`) AS `Средняя оценка по группе`
    FROM
        `Студенты` AS s
        JOIN `Результаты экзаменов` AS e
        USING (`Номер зачетной книжки`)
    GROUP BY
        s.`Группа`
)
SELECT
    s.`ФИО`,
    s.`Группа`,
    AVG(e.`Оценка`) AS `Средняя оценка студента`,
    ga.`Средняя оценка по группе`,
    IF(
        ROUND(AVG(e.`Оценка`), 4) > ROUND(ga.`Средняя оценка по группе`, 4),
        'Да',
        'Нет'
    ) AS `Выше средней оценки по группе`
FROM
    `Студенты` AS s
    JOIN `Результаты экзаменов` AS e
    USING (`Номер зачетной книжки`)
    JOIN GroupAVG AS ga
    USING (`Группа`)
GROUP BY
    s.`ФИО`, s.`Группа`, ga.`Средняя оценка по группе`;