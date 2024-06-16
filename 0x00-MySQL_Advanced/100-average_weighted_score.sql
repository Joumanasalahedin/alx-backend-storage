-- creates a stored procedure ComputeAverageWeightedScoreForUser
-- that computes and store the average weighted score for a student
DELIMITER //

CREATE PROCEDURE ComputeAverageWeightedScoreForUser(IN user_id INT)
BEGIN
    DECLARE avg_weighted_score FLOAT;

    SET avg_weighted_score = (
        SELECT SUM(score * weight) / SUM(weight)
        FROM users AS user
        JOIN corrections AS corr 
        ON user.id = corr.user_id
        JOIN projects AS pro
        On corr.project_id = pro.id
        WHERE user.id = user_id
    );
    UPDATE users
    SET average_score = avg_weighted_score
    WHERE id = user_id;
END //

DELIMITER ;
