<?php
  $ip = $_SERVER['REMOTE_ADDR'];
  echo "IP: ";
  echo $ip;
  echo "<br>";
  $hash = $_REQUEST['hash'];
  if ($hash == null) {
    $hash = 'erro';
  }
  $hash = str_replace('.','',$hash);
  $hash = str_replace('/','',$hash);
  echo "gravando ip no arquivo ".$hash.".txt";
  $fp = fopen($hash.".txt", "w");
  $escreve = fwrite($fp, $ip);
  fclose($fp);
?>