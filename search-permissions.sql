@user_id int;


SELECT U.id, U.name, (U.allow OR R.allow) AS allow 
    FROM (

            SELECT P1.id, P1.name, IF(P2.allow IS NULL, false, P1.activate AND P2.allow) AS allow
                FROM system_optionsAS P1 
                LEFT JOIN ( 
                    SELECT system_options.id, users_system_options.allow
                    FROM system_options 
                    JOIN users_system_options ON system_options.id = users_system_options.id_system_option
                    JOIN users ON users_system_options.id_user = users.id
                    WHERE users.id = @user_id
                ) AS P2 ON P1.id = P2.id
    ) AS U
    JOIN (
            SELECT P1.id, P1.name, IF(P2.allow IS NULL, false, P1.activate AND P2.allow) AS allow
                FROM system_optionsAS P1 
                LEFT JOIN (
                    SELECT system_options.id, (level_access.activate AND users_level_access.activate IS NOT NULL AND users_level_access.activate AND level_access_system_options.allow IS NOT NULL AND MAX(level_access_system_options.allow)) AS allow
                    FROM system_options 
                    JOIN level_access_system_options ON system_options.id = level_access_system_options.id_system_option
                    JOIN level_access ON level_access_system_options.id_level_access = level_access.id
                    JOIN users_level_access ON level_access.id = users_level_access.id_level_access
                    JOIN users ON users_level_access.id_user = users.id
                    WHERE users.id = @user_id
                    GROUP BY system_options.id
                ) AS P2 ON P1.id = P2.id

    ) AS R ON U.id = R.id
;