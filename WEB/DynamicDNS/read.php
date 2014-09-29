<?php
  $hash = $_REQUEST['hash'];
  $hash = str_replace('.','',$hash);
  $hash = str_replace('/','',$hash);
  if (file_exists($hash.'.txt')) {
    $ponteiro = fopen ($hash.'.txt', "r");
    while (!feof ($ponteiro)) {
      $linha = fgets($ponteiro, 4096);
      echo $linha;
    }
    fclose ($ponteiro);
  }  else {
    echo '000.000.000.000';
  }
 ?>