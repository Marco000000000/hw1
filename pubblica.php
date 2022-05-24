<?php
if(isset($_GET["descrizione"])&&isset($_GET["titolo"])&&isset($_GET["totale"])&&isset($_GET["user"]))   
{
    //echo $_GET["descrizione"];
    $conn=mysqli_connect("localhost","root","","hw1") or die("Errore:".mysqli_connect_error());
    $titolo=mysqli_real_escape_string($conn,$_GET["titolo"]);
    $totale=mysqli_real_escape_string($conn,$_GET["totale"]);
    $descrizione=mysqli_real_escape_string($conn,$_GET["descrizione"]);
    $user=mysqli_real_escape_string($conn,$_GET["user"]);
    $query="SELECT carrelloCorrente from profilo where Username='".$user."'";
    $res= mysqli_query($conn,$query) or die("Errore:".mysqli_error($conn));
    $row=mysqli_fetch_assoc($res);
    $carrello=$row["carrelloCorrente"];

    $query2="INSERT INTO `carrello` ( `proprietario`, `Totale`, `Nome`, `Descrizione`, `likes`) VALUES ('$user', '$totale', '$titolo', '$descrizione', '0')";
    echo mysqli_query($conn,$query2) or die("Errore:".mysqli_error($conn));
    $query3="(SELECT (max(id)) as max FROM `carrello`)";
    $res=mysqli_query($conn,$query3) or die("Errore:".mysqli_error($conn));
    $row=mysqli_fetch_assoc($res)["max"];
    echo "insert";
    $query="INSERT INTO `prodotto-carrello` (`prodotto`, `carrello`,quantita)  select p.prodotto , ".$row.",p.quantita from `prodotto-carrello` as p where carrello=".$carrello;
    echo mysqli_query($conn,$query) or die("Errore:".mysqli_error($conn));
    echo "insert";
    $query4="DELETE FROM `prodotto-carrello`  WHERE carrello=".$carrello;
    echo mysqli_query($conn,$query4) or die("Errore:".mysqli_error($conn));

    mysqli_close($conn);

       
    

}

?>