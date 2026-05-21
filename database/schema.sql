CREATE DATABASE IF NOT EXISTS seguroflow
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;

USE seguroflow;

CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(120) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    role ENUM('admin', 'analyst') DEFAULT 'analyst',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE clients (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(120) NOT NULL,
    email VARCHAR(150),
    phone VARCHAR(20),
    cpf VARCHAR(14),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE insurance_requests (
    id INT AUTO_INCREMENT PRIMARY KEY,
    client_id INT NOT NULL,
    title VARCHAR(150) NOT NULL,
    description TEXT,
    insurance_type VARCHAR(100),

    status ENUM(
        'pending',
        'analysis',
        'approved',
        'rejected'
    ) DEFAULT 'pending',

    priority ENUM(
        'low',
        'medium',
        'high'
    ) DEFAULT 'medium',

    created_by INT,

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    ON UPDATE CURRENT_TIMESTAMP,

    CONSTRAINT fk_request_client
        FOREIGN KEY (client_id)
        REFERENCES clients(id)
        ON DELETE CASCADE,

    CONSTRAINT fk_request_user
        FOREIGN KEY (created_by)
        REFERENCES users(id)
        ON DELETE SET NULL
);

CREATE TABLE request_history (
    id INT AUTO_INCREMENT PRIMARY KEY,

    request_id INT NOT NULL,

    old_status VARCHAR(50),

    new_status VARCHAR(50),

    changed_by INT,

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_history_request
        FOREIGN KEY (request_id)
        REFERENCES insurance_requests(id)
        ON DELETE CASCADE,

    CONSTRAINT fk_history_user
        FOREIGN KEY (changed_by)
        REFERENCES users(id)
        ON DELETE SET NULL
);