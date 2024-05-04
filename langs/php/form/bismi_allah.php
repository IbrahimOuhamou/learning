<?php
//in the name of Allah

echo '
<!DOCTYPE html>
<html>
<head>
    <title>in the name of Allah</title>
</head>
<body>
    <p>in the name of Allah</p>
    <form action="handle.php" method="post">
        <label for="name">Your name:</label>
        <input id="name" name="name" type="text">
        <button type="submit">Submit</button>
    </form>
<form action="action.php" method="post">
    <label for="name">Your name:</label>
    <input name="name" id="name" type="text">

    <label for="age">Your age:</label>
    <input name="age" id="age" type="number">

    <button type="submit">Submit</button>
</form>
</body>
</html>
';

?>
