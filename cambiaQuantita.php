<?php
if(isset($_GET["user"])&&isset($_GET["titolo"])&&isset($_GET["descrizione"]))   
{
    //echo $_GET["descrizione"];
    $conn=mysqli_connect("localhost","root","","hw1") or die("Errore:".mysqli_connect_error());
    $titolo=mysqli_real_escape_string($conn,$_GET["titolo"]);
    $descrizione=mysqli_real_escape_string($conn,$_GET["descrizione"]);
    $user=mysqli_real_escape_string($conn,$_GET["user"]);
    $query="SELECT carrelloCorrente from profilo where Username='".$user."'";
    $res= mysqli_query($conn,$query) or die("Errore:".mysqli_error($conn));
    $row=mysqli_fetch_assoc($res);
    $carrello=$row["carrelloCorrente"];
    $query="UPDATE `prodotto-carrello` SET `quantita` = $quantita WHERE `prodotto` ='$prodotto' and carrello='$carrello'";
    echo mysqli_query($conn,$query) or die("Errore:".mysqli_error($conn));
    $delete_prod_carr="DELETE FROM `prodotto-carrello`  WHERE carrello='".$row."'";

    mysqli_close($conn);

       
    

}
?>