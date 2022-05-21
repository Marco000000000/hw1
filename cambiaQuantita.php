<?php
if(isset($_GET["user"])&&isset($_GET["quantita"])&&isset($_GET["prodotto"]))   
{
    //echo $_GET["descrizione"];
    $conn=mysqli_connect("localhost","root","","hw1") or die("Errore:".mysqli_connect_error());
    $quantita=mysqli_real_escape_string($conn,$_GET["quantita"]);
    $prodotto=mysqli_real_escape_string($conn,$_GET["prodotto"]);
    $user=mysqli_real_escape_string($conn,$_GET["user"]);
    $query="SELECT carrelloCorrente from profilo where Username='".$user."'";
    $res= mysqli_query($conn,$query) or die("Errore:".mysqli_error($conn));
    $row=mysqli_fetch_assoc($res);
    $carrello=$row["carrelloCorrente"];
    $query="UPDATE `prodotto-carrello` SET `quantita` = $quantita WHERE `prodotto` ='$prodotto' and carrello='$carrello'";
     mysqli_query($conn,$query) or die("Errore:".mysqli_error($conn));

    mysqli_close($conn);

       echo "1";
        exit;    

}
echo "0";
?>