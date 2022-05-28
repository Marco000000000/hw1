<?php
session_start();
if(isset($_GET["carrello"])&&isset($_GET["user"])&&isset($_SESSION["username"]))   
{
    //echo $_GET["descrizione"];
    include 'dbconfig.php';
    $conn = mysqli_connect($dbconfig['host'], $dbconfig['user'], $dbconfig['password'], $dbconfig['name']) or die(mysqli_connect_error($conn));
    $carrello=mysqli_real_escape_string($conn,$_GET["carrello"]);
    $user=mysqli_real_escape_string($conn,$_GET["user"]);
    if($user!=$_SESSION["username"])
        {echo 0;
            exit;
        }
    $query="DELETE FROM `prodotto-carrello` WHERE `prodotto-carrello`.`carrello` = $carrello";
    mysqli_query($conn,$query) or die("Errore:".mysqli_error($conn));
    $query="delete from carrello where id=$carrello";
    mysqli_query($conn,$query) or die("Errore:".mysqli_error($conn));
    mysqli_close($conn);
       echo "1";
        exit;    

}
echo "0";
?>