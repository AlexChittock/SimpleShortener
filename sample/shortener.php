<?php


  //$link = $_POST['link'];

  /* Putting of the '/' at the end of the url */ 
  if (substr($link, -1, 1) == "/")
  {
    $link = substr($link, 0, -1);
  }    

  /* This is used to encode the link and making a few characters available. It gets decoded in the pack.lua*/  
  $link = urlencode($link);
  
  /* Link has to be like an URL */
  if(filter_var($link, FILTER_VALIDATE_URL) === FALSE)
  {
    echo "URL not valid";
  }
  else
  {
    /* Sending the request on /shorten */
    $base = "http://myhost.com/shorten?url=";
    $tosend = $base . $link;
    $ch = curl_init();
    curl_setopt($ch, CURLOPT_URL, $tosend);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
    curl_setopt($ch, CURLOPT_COOKIESESSION, true);
    $ret = curl_exec($ch);
    if (!$ret)
    {
      echo curl_error($ch);
    }
    else
    {
      echo ($ch);
    }
  }
?>
