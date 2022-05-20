<?php

//echo json_encode($_GET) ;



if(isset($_GET["link"])&&isset($_GET["user"]))   
{echo $_GET["user"];
    $conn=mysqli_connect("localhost","root","","hw1") or die("Errore:".mysqli_connect_error());
    $user=mysqli_real_escape_string($conn,$_GET["user"]);
   
    $link=mysqli_real_escape_string($conn,$_GET["link"]);

    

    $query="SELECT carrelloCorrente from profilo where Username='".$user."'";
    $res= mysqli_query($conn,$query) or die("Errore:".mysqli_error($conn));
    echo "dopores";
    $row=mysqli_fetch_assoc($res);
    $row=$row["carrelloCorrente"];
    echo json_encode($row);
    $delete_prod_carr="DELETE FROM `prodotto-carrello`  WHERE prodotto='".$link."'and carrello='".$row."'";
    // print_r($controluser);
    //print_r($controlema
    //print_r($insert);
    echo mysqli_query($conn, $delete_prod_carr) or die("Errore:".mysqli_error($conn));
    //print_r($_GET);

    mysqli_close($conn);

       
    

}
?> 