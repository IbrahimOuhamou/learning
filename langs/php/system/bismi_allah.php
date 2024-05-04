<?php
//in the name of Allah
echo "in the name of Allah\n";

$var = exec("~/test/c/bismi_allah/bin/bismi_allah");
system("~/test/c/bismi_allah/bin/bismi_allah");

var_dump($var);

$ip = "archlinux.org";

echo exec("nmap $ip");
system("nmap $ip")
?>

