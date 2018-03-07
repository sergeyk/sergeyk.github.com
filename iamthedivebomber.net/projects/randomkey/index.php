<html>
<title>RMK</title>
</head>
<body style="text-align: center; padding-top: 200px;">
<p style="font-weight: bold; 
          font-size: 120pt; 
	            font-family: Arial, sans-serif; 
		              text-decoration: none; 
			                color: black;">
<?php

$keys = array(
"C", "Db", "D", "Eb", "E", "F", "F#", "Gb", "G", "Ab", "A", "Bb", "B"
);

srand();
print($keys[rand(0, count($keys))-1]);

?>
</p>
</body>
</html>
