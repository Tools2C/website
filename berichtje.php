<?php 
  if (mail( "astrid@tools2c.nl"
          , "Tools2C msg van " . $_POST["Naam"] . " <" . $_POST["E-mail"] . ">"
          , "Van    : " . $_POST["Naam"] . "\r\n"
          . "E-mail : " . $_POST["E-mail"] . "\r\n"
          . "Bericht: " . $_POST["Berichtje"] . "\r\n")) {
    print("<p>Jouw bericht is ontvangen.<br />Dank je wel! <i class=\"fas fa-heart w3-text-red\"></i></p>");
  } else {
    print("<p><i class=\"fas fa-exclamation-triangle w3-text-red\"></i> Er ging iets mis! Je bericht is niet ontvangen!</p>");
  }
?>
