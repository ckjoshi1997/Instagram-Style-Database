-- Find the 5 oldest users

SELECT *
FROM users
ORDER BY created_at
LIMIT 5
;

-- What day of the week do most users register on?

SELECT
	DAYNAME(created_at) AS day,
	COUNT(*) AS total
FROM users
GROUP BY day
ORDER BY total DESC
;

-- Find the users who have never posted a photo

SELECT username AS USERS_WHO_NEVER_POSTED
FROM users
LEFT JOIN photos
	ON users.id = photos.user_id
WHERE photos.id IS NUL
L;

-- Which photo has the most likes? Who posted it?

SELECT 
	username AS posted_by,
	photos.id, 
	photos.image_url, 
	COUNT(*) AS total_likes
FROM photos
INNER JOIN likes
	ON likes.photo_id = photos.id
INNER JOIN users
	ON photos.user_id = users.id
GROUP BY photos.id
ORDER BY total_likes DESC
LIMIT 1
;

-- How many times does the average user post?

SELECT (
	(SELECT COUNT(*) FROM photos) 
	/ 
	(SELECT COUNT(*) FROM users)
) AS average_posts_per_user
;

-- What are the top 5 most common hashtags?

SELECT 
	tags.tag_name,
	COUNT(*) AS total_used
FROM photo_tags
JOIN tags
	ON photo_tags.tag_id = tags.id
GROUP BY tags.id
ORDER BY total_used DESC
LIMIT 5
;

-- Find users who have liked every single photo on the site

SELECT
	username,
	user_id,
	COUNT(*) AS total_liked
FROM users
INNER JOIN likes
	ON users.id = likes.user_id
GROUP BY users.id
HAVING total_liked = 
	(SELECT COUNT(*) FROM photos)
;
























