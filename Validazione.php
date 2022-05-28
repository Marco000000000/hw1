<?php
session_start();
    function contains($str,$chars) {
        //print_r([$str,$chars]);
        for($i=0;$i<strlen($chars);$i++)
        {   
            if(strpos($str,$chars[$i])!==false)
            {
                return true;
            }
        }
        return false;
    }
    if(isset($_GET["utente"])&&isset($_GET["password"])&&isset($_GET["email"]))   
        {
            $specialChars = "/ [`!@#$%^&*()_+\-=\[\]{};':\"\\|,.<>\/?~]/;";
            $num="0123456789";
            $letters="abcdefghijklmnopqrstuvwxyz";

            if((!contains($_GET["utente"],$specialChars))&& ((contains($_GET["password"],$num))&&(contains(strtolower($_GET["password"]),$letters))))
            {   
                include 'dbconfig.php';
                $conn = mysqli_connect($dbconfig['host'], $dbconfig['user'], $dbconfig['password'], $dbconfig['name']) or die(mysqli_connect_error($conn));
            
                $utente=mysqli_real_escape_string($conn,$_GET["utente"]);
                $password=mysqli_real_escape_string($conn,$_GET["password"]);
                $email=mysqli_real_escape_string($conn,$_GET["email"]);
                $insert="INSERT INTO profilo (`Username`, `Password`, `Email`) VALUES ('$utente', '$password', '$email')";
                $usernameControl="SELECT * FROM `profilo` WHERE Username='".($utente)."';";
                $emailControl="SELECT * FROM `profilo` WHERE Email='".($email)."';";
                $controluser=(mysqli_num_rows(mysqli_query($conn, $usernameControl))==0); 
                $controlemail=(mysqli_num_rows(mysqli_query($conn, $emailControl))==0); 
            // print_r($controluser);
                //print_r($controlemail);

                if($controluser&&$controlemail)
                {
                mysqli_query($conn, $insert) or die("Errore:".mysqli_error($conn));
                
                $_SESSION["username"]=$utente;
                echo 1;
                
                //print_r($_GET);
                }
                else
                {
                    echo 0;
                }
                mysqli_close($conn);
            }
            
        
        }
?>