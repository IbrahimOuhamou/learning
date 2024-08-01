<?php
//in the name of Allah

echo "بسم الله الرحمن الرحيم\n";


$row = array();
$row['Performance'] = 'OUI';

bismiAllahFunc($row['Performance'] == 'NON');

function bismiAllahFunc(bool $condition) {
    var_dump($condition);
}


