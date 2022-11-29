CREATE TABLE system_options (
	id INT PRIMARY KEY,
    name VARCHAR(64) NOT NULL,
    description VARCHAR(256),
    activate BOOLEAN DEFAULT TRUE NOT NULL,
    create_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    update_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);


CREATE TABLE users (
	id INT AUTO_INCREMENT PRIMARY KEY,
    user_name VARCHAR(64) NOT NULL, -- name use for login system
    activate BOOLEAN DEFAULT TRUE NOT NULL,
    create_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    update_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE level_access (
	id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(64) NOT NULL,
    description VARCHAR(256),
    activate BOOLEAN DEFAULT TRUE NOT NULL,
    create_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    update_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE users_level_access (
	id INT AUTO_INCREMENT PRIMARY KEY,
    id_user INT NOT NULL,
    id_level_access INT NOT NULL,
    activate BOOLEAN DEFAULT TRUE NOT NULL,
    create_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    update_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (id_user) REFERENCES users(id),
    FOREIGN KEY (id_level_access) REFERENCES level_access(id),
	UNIQUE KEY pk_user_level_access (id_user,id_level_access)  
);


CREATE TABLE users_system_options (
	id INT AUTO_INCREMENT PRIMARY KEY,
    id_user INT NOT NULL,
    id_system_option INT NOT NULL,
    allow BOOLEAN DEFAULT true,
    create_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    update_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (id_user) REFERENCES users(id),
    FOREIGN KEY (id_system_option) REFERENCES system_options(id),
    UNIQUE KEY pk_user_system_option (id_user,id_system_option)  
);

CREATE TABLE level_access_system_options (
	id INT AUTO_INCREMENT PRIMARY KEY,
    id_level_access INT NOT NULL,
    id_system_option INT NOT NULL,
    allow BOOLEAN DEFAULT TRUE NOT NULL,
    create_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    update_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (id_level_access) REFERENCES level_access(id),
    FOREIGN KEY (id_system_option) REFERENCES system_options(id),
    UNIQUE KEY pk_level_access_system_option (id_level_access,id_system_option)  
);



