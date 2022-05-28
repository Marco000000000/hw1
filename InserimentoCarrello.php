<?php

//echo json_encode($_GET) ;
//echo $_GET["user"];


if(isset($_GET["descrizione"])&&isset($_GET["img"])&&isset($_GET["link"])&&isset($_GET["prezzo"])&&isset($_GET["venditore"]))   
{
    //echo $_GET["descrizione"];
    include 'dbconfig.php';
    $conn = mysqli_connect($dbconfig['host'], $dbconfig['user'], $dbconfig['password'], $dbconfig['name']) or die(mysqli_connect_error($conn));
    $user=mysqli_real_escape_string($conn,$_GET["user"]);
    $descrizione=mysqli_real_escape_string($conn,$_GET["descrizione"]);
    $img=mysqli_real_escape_string($conn,$_GET["img"]);
    $prezzo=rtrim(mysqli_real_escape_string($conn,$_GET["prezzo"]), "€");
    $link=mysqli_real_escape_string($conn,$_GET["link"]);
    $venditore=mysqli_real_escape_string($conn,$_GET["venditore"]);
    $query=" SELECT * FROM prodotti WHERE url='".$link."' ";
    echo $query;
    $res1= mysqli_query($conn,$query) or die("Errore:".mysqli_error($conn));
    print_r($res1) ;
  
    $insert_prod="INSERT INTO `prodotti` (`url`, `Venditore`, `titolo`, `prezzo`, `UrlImg`) VALUES ('".$link."', '".$venditore."', '".$descrizione."', '".$prezzo."', '".$img."') ";

    $query="SELECT carrelloCorrente from profilo where Username='".$user."'";
    $res= mysqli_query($conn,$query) or die("Errore:".mysqli_error($conn));
    $row=mysqli_fetch_assoc($res);
    $row=$row["carrelloCorrente"];
    //echo json_encode($row);
    $insert_prod_carr="INSERT INTO `prodotto-carrello` (`prodotto`, `carrello`) VALUES ('".$link."', '".$row."')";
    // print_r($controluser);
    //print_r($controlema
    //print_r($insert);
    if(($res1->num_rows)==0)
    {   echo "row1";
     mysqli_query($conn, $insert_prod) or die("Errore:".mysqli_error($conn));

    }
    $query=" SELECT * FROM `prodotto-carrello` WHERE prodotto='".$link."' and carrello='".$row."'";
   // echo $query;
    $res2= mysqli_query($conn,$query) or die("Errore:".mysqli_error($conn));
    print_r($res2) ;

    //print_r($_GET);
    if($res2->num_rows==0)
    {   echo "row2";
         mysqli_query($conn, $insert_prod_carr)or die("Errore:".mysqli_error($conn));

    }

    mysqli_close($conn);

       
    

}
?>              