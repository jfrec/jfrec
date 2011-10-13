<?php
$fp = fopen( 'test.mp3', 'wb' );
fwrite( $fp, $GLOBALS['HTTP_RAW_POST_DATA'] );
fclose( $fp );
?>