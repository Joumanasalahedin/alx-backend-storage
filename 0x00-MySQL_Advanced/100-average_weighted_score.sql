-- creates a stored procedure ComputeAverageWeightedScoreForUser
-- that computes and store the average weighted score for a student
DELIMITER //

CREATE PROCEDURE ComputeAverageWeightedScoreForUser(IN user_id INT)
BEGIN
    DECLARE total_weight INT;
    DECLARE weighted_score_sum FLOAT;
    DECLARE avg_weighted_score FLOAT;

    -- Compute the sum of weights and the weighted score sum
    SELECT 
        SUM(p.weight) INTO total_weight,
        SUM(c.score * p.weight) INTO weighted_score_sum
    FROM 
        corrections c
    JOIN 
        projects p ON c.project_id = p.id
    WHERE 
        c.user_id = user_id;

    -- Compute the average weighted score
    IF total_weight > 0 THEN
        SET avg_weighted_score = weighted_score_sum / total_weight;
    ELSE
        SET avg_weighted_score = 0;
    END IF;

    -- Update the average score in the users table
    UPDATE users
    SET average_score = avg_weighted_score
    WHERE id = user_id;
END //

DELIMITER ;
