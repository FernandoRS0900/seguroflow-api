<?php

declare(strict_types=1);

class Database
{
    private String $host = 'localhost';
    private String $dbName = 'seguroflow';
    private String $username = 'root';
    private String $password = 'root';
    private ?PDO $connection = null;

    public function connect(): PDO
    {
        if ($this->connection !== null) {
            return $this->connection;
        }
        try {
            $this->connection = new PDO(
                "mysql:host={$this->host};dbname={$this->dbName};charset=utf8mb4",
                $this->username,
                $this->password
            );

            $this->connection->setAttribute(
                PDO::ATTR_ERRMODE,
                PDO::ERRMODE_EXCEPTION
            );
            $this->connection->setAttribute(
                PDO::ATTR_DEFAULT_FETCH_MODE,
                PDO::FETCH_ASSOC
            );

            return $this->connection;
        } catch (PDOException $e) {
            die('Database erro de conexação: ' .
                $e->getMessage());
        }
    }
}
