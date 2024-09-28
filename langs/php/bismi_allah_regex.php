<?php
// بسم الله الرحمن الرحيم
// la ilaha illa Allah Mohammed rassoul Allah

echo "بسم الله الرحمن الرحيم\n";

var_dump(preg_match('/[-a-z]+/', 'bismi-Allah'));
var_dump(preg_match('/^[_-a-z]$/', 'bismi-allah'));


$bismi_allah_str = 'bismi-allah_!A';
for ($i=0; $i < strlen($bismi_allah_str); $i++) { 
    echo $bismi_allah_str[$i] . ' ' . (( ($bismi_allah_str[$i] >= 'a' && $bismi_allah_str[$i] <= 'z') || $bismi_allah_str[$i] === '-' || $bismi_allah_str[$i] === '_') ? 'TRUE' : 'FALSE') . "\n";
}

