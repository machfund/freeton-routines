#!/usr/bin/php
<?php

if (!isset($argv[1])) exit("Error: number (e.g. \"1.12389723189\" is not specified\r\n");
else $number = $argv[1];

$result = round($number, 2);
echo $result;

?>
