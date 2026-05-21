<?php

declare(strict_types=1);

require_once __DIR__ . '/../config/database.php';

try{
    $database = new Database();
    $connection = $database->connect();

    echo '<h1>SeguroFlow API conectada com sucesso!</h1>';
} catch (Exception $e){
    echo $e->getMessage();
}