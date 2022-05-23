<?php


if(isset($_GET["link"])&&isset($_GET["user"]))   
{
    
    $conn=mysqli_connect("localhost","root","","hw1") or die("Errore:".mysqli_connect_error());
    $user=mysqli_real_escape_string($conn,$_GET["user"]);
    $link=mysqli_real_escape_string($conn,$_GET["link"]);
    $query="SELECT carrelloCorrente from profilo where Username='".$user."'";
    $res= mysqli_query($conn,$query) or die("Errore:".mysqli_error($conn));
    $row=mysqli_fetch_assoc($res);
    $row=$row["carrelloCorrente"];

    $insert_prod_carr="INSERT INTO `prodotto-carrello` (`prodotto`, `carrello`) VALUES ('".$link."', '".$row."')";

   
    $query=" SELECT * FROM `prodotto-carrello` WHERE prodotto='".$link."' and carrello='".$row."'";
    $res2= mysqli_query($conn,$query) or die("Errore:".mysqli_error($conn));

    //print_r($_GET);
    if($res2->num_rows==0)
    {   echo 1;
         mysqli_query($conn, $insert_prod_carr)or die("Errore:".mysqli_error($conn));

    }
    else{
        echo 0;
    }

    mysqli_close($conn);

       
    

}
?>              