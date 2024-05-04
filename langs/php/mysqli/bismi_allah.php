<?php
//in the name of Allah
//session_start();
//$_SESSION['bismi_allah'] = 'bismi_allah';

echo '<!DOCTYPE html>
<html>
<head>
    <title>in the name of Allah</title>
    <meta charset="UTF-8">
</head>
<body>
    <p>in the name of Allah</p>';



$servername = "localhost";
$username = "root";
$password = "toor";
$db_name = "bismi_allah_accounts";

$conn = mysqli_connect($servername, $username, $password, $db_name);
if(!$conn)
{
    echo '<p>We had an internal error, try later incha2Allah</p>';
    echo '</body>
</html>';
    exit();
}
mysqli_set_charset($conn, 'utf8mb4');

$input_username = mysqli_real_escape_string($conn, htmlspecialchars($_POST['bismi_allah_input_user_name']));
$input_password = mysqli_real_escape_string($conn, htmlspecialchars($_POST['bismi_allah_input_password']));
$query = "SELECT bismi_allah_account_name, bismi_allah_account_password FROM bismi_allah_accounts WHERE bismi_allah_account_name='" . $input_username . "' AND bismi_allah_account_password='" . $input_password . "'";
$result = mysqli_query($conn, $query);
echo '<p>Allah akbar</p>';

if(0 < mysqli_num_rows($result))
{
    if($row = mysqli_fetch_assoc($result))
    {
        echo '<p> your name is "' . $row['bismi_allah_account_name'] . '"</p>';
    }
}
else
{
    //echo '<p>couldn\'t find user ' . $input_username . ' </p>';
    echo '<p>user_name or password are incorrect</p>';
}


echo '</body>
</html>';

mysqli_close($conn);

//in the name of Allah
/*
$servername = "localhost";
$username = "username";
$password = "password";
$db_name = "bismi_allah_db";

//create connection
$conn = mysqli_connect($servername, $username, $password);
$conn = mysqli_connect($servername, $username, $password, $db_name);

//Check connection
if(!$conn)
{
    die("conn failed" . sqli_connect_error());
}
echo 'conected succ';

//create db
$sql = "create database db";
if(mysqli_query($conn, $sql))
{
    echo "success";
}
else
{
    echo 'error creating db' . mysqli_error($conn);
}

//insert into
$sql = 'insert into uiewuieui';
if(mysqli_query($conn, $sql))
{
    echo 'insert succ';
}
else
{
    echo 'insert failure';
}

mysqli_close($conn);

*/
