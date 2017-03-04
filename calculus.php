<?php
  header('Content-Type: application/json');
	if(isset($_POST['calculus']) && isset($_POST['x_min']) && isset($_POST['x_max']) && isset($_POST['step'])){
		echo shell_exec("echo \"" . $_POST['calculus'] . "\" | bison/calc " . $_POST['x_min'] . " " . $_POST['x_max'] . " " . $_POST['step']);
	}
?>
