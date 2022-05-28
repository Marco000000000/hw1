<?php
session_start();
if(isset($_GET["seguito"])&&isset($_SESSION["username"]))   
{
    //echo $_GET["descrizione"];
    include 'dbconfig.php';
    $conn = mysqli_connect($dbconfig['host'], $dbconfig['user'], $dbconfig['password'], $dbconfig['name']) or die(mysqli_connect_error($conn));
    $seguito=mysqli_real_escape_string($conn,$_GET["seguito"]);
    $user=mysqli_real_escape_string($conn,$_SESSION["username"]);
    $querycontrollo="Select * from segui where seguace='$user' and seguito='$seguito'";
    $res= mysqli_query($conn,$querycontrollo) or die("Errore:".mysqli_error($conn));
    if($user==$seguito)
    {
        echo 0;
        exit;
    }
    if($res->num_rows==0)
    { 
    $query="INSERT INTO `segui` (`seguace`, `seguito`) VALUES ('$user', '$seguito')";
    
    mysqli_query($conn,$query) or die("Errore:".mysqli_error($conn));
    }
    else{
        $query="delete from segui where seguace='$user' and seguito='$seguito'";
    
        mysqli_query($conn,$query) or die("Errore:".mysqli_error($conn));
    }
    mysqli_close($conn);

       echo "1";
        exit;    

}
echo "0";
?>