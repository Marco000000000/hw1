<?php

echo json_encode($_GET) ;
/*
if(isset($_POST["utente"])&&isset($_POST["password"])&&isset($_POST["email"]))   
{
    
    $conn=mysqli_connect("localhost","root","","hw1") or die("Errore:".mysqli_connect_error());

    $utente=mysqli_real_escape_string($_POST["utente"]);
    $password=mysqli_real_escape_string($_POST["password"]);
    $email=mysqli_real_escape_string($_POST["email"]);
    $insert="INSERT INTO prodotti ('carrello', 'prezzo', 'titolo','url','UrlImg','Venditore') VALUES ('".($_POST["carrello"])."', '".($_POST["prezzo"])."', '".($_POST["titolo"])."', '".($_POST["titolo"])."')";
    
    $usernameControl="SELECT * FROM `profilo` WHERE Username='".($utente)."';";
    $emailControl="SELECT * FROM `profilo` WHERE Email='".($email)."';";
    $controluser=(mysqli_num_rows(mysqli_query($conn, $usernameControl))==0); 
    $controlemail=(mysqli_num_rows(mysqli_query($conn, $emailControl))==0); 
    // print_r($controluser);
    //print_r($controlemail);

    
    if($controluser&&$controlemail)
    {
    //print_r($insert);
    mysqli_query($conn, $insert)or die("Errore:".mysqli_error($conn));
    //print_r($_POST);
    }
    else
    {
        echo '<p id="errore_registrato" class="errore">Nome utente o email già registrati</p>';
    }
    mysqli_close($conn);

       
    

}*/
?>              