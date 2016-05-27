<?php

error_reporting(E_ALL);
// $emailaddress = 'androidhub@intel.com';
$emailaddress = 'androidhub@intel.com';

define("DEBUG_MODE", FALSE);

if (!$_SERVER || $_SERVER['REQUEST_METHOD'] != "POST") {
  die ("go away\n\n");
}

$json = stream_get_contents(detectRequestBody());
$body = formatData(json_decode($json));

$headers =
    'From: ' . $emailaddress . "\r\n" .
    'Reply-To: ' . $emailaddress . "\r\n" .
    'X-Mailer: PHP/' . phpversion();

$args = '-f' . $emailaddress;

if (!email($emailaddress, "Someone wants to commit to the Android Hub!", $body, $headers, $args)) {
  header('HTTP/1.1 400 Internal Server Error');
  echo json_encode(array(
    'success' => false
  ));
} else {
  header('HTTP/1.1 200 OK');
  echo json_encode(array(
    'success' => true
  ));
}

function formatData($data) {
  $emailBody = array();;

  foreach ($data as $key => $value) {
    $emailBody[] = $key . ': ' . $value;
  }

  return implode("\r\n", $emailBody);
}

function email($to, $subject, $body, $headers, $args) {
  if (DEBUG_MODE) {
    return TRUE;
  }

  return mail($to, $subject, $body, $headers, $args);
}

function detectRequestBody() {
    $rawInput = fopen('php://input', 'r');
    $tempStream = fopen('php://temp', 'r+');
    stream_copy_to_stream($rawInput, $tempStream);
    rewind($tempStream);

    return $tempStream;
}
