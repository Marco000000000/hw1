<?php
session_start();
if(isset($_GET["carrello"])&&isset($_SESSION["username"]))   
{
    //echo $_GET["descrizione"];
    $conn=mysqli_connect("localhost","root","","hw1") or die("Errore:".mysqli_connect_error());
    $carrello=mysqli_real_escape_string($conn,$_GET["carrello"]);
    $user=mysqli_real_escape_string($conn,$_SESSION["username"]);
    $querycontrollo="Select * from piaciuti where mittente='".$user."' and carrello=".$carrello;
    $res= mysqli_query($conn,$querycontrollo) or die("Errore:".mysqli_error($conn));
    if($res->num_rows>0)
    $query="delete from piaciuti where mittente='".$user."' and carrello=".$carrello;
    else
    $query="INSERT INTO `piaciuti` (`mittente`, `carrello`) VALUES ('$user', $carrello)";
    mysqli_query($conn,$query) or die("Errore:".mysqli_error($conn));
    mysqli_close($conn);

       echo "1";
        exit;    

}
echo "0";
?>