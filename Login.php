<?php

session_start();
if(isset($_SESSION["username"]) ||isset($_COOKIE["username"]))
    {
        header("Location: home.php");
        exit;
    }
    //print_r($_SESSION);
    
   // print_r($_COOKIE);
    
    ?>


<!-- saved from url=(0039)http://192.168.1.103/upload/Signin.php -->
<html><head><meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
    <title>
        Login
    </title>
    <link rel="icon" type="image/x-icon" href="images/logo.jpg">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="Login.css">
    <script src="" defer="true"></script>

<body>
    
    <div id="Container">
        <div id="overlay">
            <h1>Accedi</h1>
            <div class="errori">
            <?php
if(isset($_POST["utente"])&&isset($_POST["password"]))   
    {
        $conn=mysqli_connect("localhost","root","","hw1") or die("Errore:".mysqli_connect_error());
        //print_r($_POST);

        $utente=mysqli_real_escape_string($conn, $_POST["utente"]);
        $password=mysqli_real_escape_string($conn, $_POST["password"]);
        if(isset($_POST["check"]))
            $check=mysqli_real_escape_string($conn, $_POST["check"]);
        
        $usernameControl="SELECT * FROM `profilo` WHERE Username='".$utente."';";
        $emailControl="SELECT * FROM `profilo` WHERE Email='".$utente."';";
        $res1=mysqli_query($conn, $usernameControl) or die("Errore:".mysqli_error($conn));
        $controluser=(mysqli_num_rows($res1)); 
        $controlemail=(mysqli_num_rows(mysqli_query($conn, $emailControl))); 
       // print_r($controluser);
        //print_r($controlemail);
        $where="";
        if($controluser-$controlemail!=0)
        {
            $controluser=true;
            if($controluser>$controlemail)
                $where="Username";
            else
                $where="Email";
        }    
        else
        {
            $controluser=false;
        }


        if($controluser)
        {
        $query="SELECT * FROM `profilo` WHERE ".$where."='".$utente."';";
        $res= mysqli_query($conn,$query) or die("Errore:".mysqli_error($conn));
        $row=mysqli_fetch_assoc($res);
        //print_r($row);
        if($row["Password"]==$password)
        {
            if(isset($_POST["check"])&&$check=="on")
            {
                setcookie("username", $row["Username"]);

            }
            $_SESSION["username"] =$row["Username"];
            
            header("Location: home.php");
            exit;
        
        }
        else
        {
            echo '<p id="errore_sbagliato" class="errore">Password non corretta</p>';
        }
        
        }
        else
        {
            echo '<p id="errore_sbagliato" class="errore">Utente o email non riconosciute</p>';
        }
        
        mysqli_close($conn); 
            
    }
        
    
    
?>
            </div>
    <form action="" method="post">
        <label><input type="text" placeholder="Nome Utente/Email" name="utente" required></label>
        <label><input type="password" placeholder="Password" name="password" required></label>
        <label id="label_check"><input id="checkbox" type="checkbox" placeholder="" name="check"><p>Resta collegato</p></label>
        <label id="submit"><input type="submit" value="Accedi"></label>
    </form>
    <a href="Registrazione.php"> <h3>Non hai un account?<br>Registrati</h3></a>
    </div>
    </div>
 


        </body></html>