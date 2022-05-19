<?php

//echo json_encode($_GET) ;
echo $_GET["user"];


if(isset($_GET["descrizione"])&&isset($_GET["img"])&&isset($_GET["link"])&&isset($_GET["prezzo"])&&isset($_GET["venditore"]))   
{
    echo $_GET["descrizione"];
    $conn=mysqli_connect("localhost","root","","hw1") or die("Errore:".mysqli_connect_error());
    $user=mysqli_real_escape_string($conn,$_GET["user"]);
    $descrizione=mysqli_real_escape_string($conn,$_GET["descrizione"]);
    $img=mysqli_real_escape_string($conn,$_GET["img"]);
    $link=rtrim(mysqli_real_escape_string($conn,$_GET["link"]), "€");
    $prezzo=mysqli_real_escape_string($conn,$_GET["prezzo"]);
    $venditore=mysqli_real_escape_string($conn,$_GET["venditore"]);
    
    $insert_prod="INSERT INTO `prodotti` (`url`, `Venditore`, `titolo`, `prezzo`, `UrlImg`) VALUES ('".$link."', '".$venditore."', '".$descrizione."', '".$prezzo."', '".$img."')";

    $query="SELECT carrelloCorrente from profilo where Username='".$user."'";
    $res= mysqli_query($conn,$query) or die("Errore:".mysqli_error($conn));
    echo "dopores";
    $row=mysqli_fetch_assoc($res);
    $row=$row["carrelloCorrente"];
    echo json_encode($row);
    $insert_prod_carr="INSERT INTO `prodotto-carrello` (`prodotto`, `carrello`) VALUES ('".$link."', '".$row."')";
    // print_r($controluser);
    //print_r($controlema
    //print_r($insert);
    echo mysqli_query($conn, $insert_prod) or die("Errore:".mysqli_error($conn));
    //print_r($_GET);
    echo mysqli_query($conn, $insert_prod_carr)or die("Errore:".mysqli_error($conn));

    mysqli_close($conn);

       
    

}
?>              