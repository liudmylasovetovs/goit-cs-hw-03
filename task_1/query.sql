-- 1. Отримати всі завдання певного користувача
-- Приклад: user_id = 1
SELECT * FROM tasks
WHERE user_id = 1;

-- 2. Вибрати завдання за певним статусом (наприклад 'new')
SELECT * FROM tasks
WHERE status_id = (
    SELECT id FROM status WHERE name = 'new'
);

-- 3. Оновити статус конкретного завдання на 'in progress'
-- Приклад: task_id = 5
UPDATE tasks
SET status_id = (
    SELECT id FROM status WHERE name = 'in progress'
)
WHERE id = 5;

-- 4. Користувачі без жодного завдання
SELECT * FROM users
WHERE id NOT IN (
    SELECT DISTINCT user_id FROM tasks
);

-- 5. Додати нове завдання для користувача
-- Приклад: user_id = 1, статус = 'new'
INSERT INTO tasks (title, description, status_id, user_id)
VALUES ('Test Task', 'Example description',
        (SELECT id FROM status WHERE name = 'new'), 1);

-- 6. Усі завдання, які ще не завершено
SELECT * FROM tasks
WHERE status_id != (
    SELECT id FROM status WHERE name = 'completed'
);

-- 7. Видалити конкретне завдання
-- Приклад: task_id = 3
DELETE FROM tasks
WHERE id = 3;

-- 8. Знайти користувачів з певною електронною поштою
-- Приклад: домен '@example.com'
SELECT * FROM users
WHERE email LIKE '%@example.com';

-- 9. Оновити ім’я користувача
-- Приклад: id = 2
UPDATE users
SET fullname = 'New Full Name'
WHERE id = 2;

-- 10. Кількість завдань для кожного статусу
SELECT s.name AS status_name, COUNT(t.id) AS task_count
FROM status s
LEFT JOIN tasks t ON s.id = t.status_id
GROUP BY s.name;

-- 11. Завдання від користувачів з певною доменною частиною email
-- Приклад: '@example.com'
SELECT t.*
FROM tasks t
JOIN users u ON t.user_id = u.id
WHERE u.email LIKE '%@example.com';

-- 12. Завдання без опису
SELECT * FROM tasks
WHERE description IS NULL OR description = '';

-- 13. Користувачі та їхні завдання зі статусом 'in progress'
SELECT u.fullname, t.title, s.name AS status_name
FROM tasks t
JOIN users u ON t.user_id = u.id
JOIN status s ON t.status_id = s.id
WHERE s.name = 'in progress';

-- 14. Користувачі та кількість їхніх завдань
SELECT u.fullname, COUNT(t.id) AS task_count
FROM users u
LEFT JOIN tasks t ON u.id = t.user_id
GROUP BY u.id, u.fullname;