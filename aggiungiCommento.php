<?php
session_start();
if(isset($_GET["commento"])&&isset($_GET["carrello"])&&isset($_SESSION["username"]))   
{
    //echo $_GET["descrizione"];
    include 'dbconfig.php';
    $conn = mysqli_connect($dbconfig['host'], $dbconfig['user'], $dbconfig['password'], $dbconfig['name']) or die(mysqli_connect_error($conn));
    $commento=mysqli_real_escape_string($conn,$_GET["commento"]);
    $carrello=mysqli_real_escape_string($conn,$_GET["carrello"]);
    $user=mysqli_real_escape_string($conn,$_SESSION["username"]);
    $query="INSERT INTO `commenti` (`mittente`, `carrello`, `commento`) VALUES ('$user', $carrello, '$commento')";
    mysqli_query($conn,$query) or die("Errore:".mysqli_error($conn));
    mysqli_close($conn);

       echo "1";
        exit;    

}
echo "0";
?>