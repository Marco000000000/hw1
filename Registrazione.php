<?php
session_start();
if(isset($_SESSION["username"])||isset($_COOKIE["username"]))
    {
       

            header("Location: home.php");
            exit;
       
        
    }
    ?>


<!-- saved from url=(0039)http://192.168.1.103/upload/Signin.php -->
<html><head><meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
    <title>
        Registrazione
    </title>
     
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="Registrazione.css">
    <script src="Registrazione.js" defer="true"></script>

 <body>
    
    <div id="Container">
        <div id="overlay">
            <h1>Registrati</h1>
            <div class="errori">
            <?php
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
                if(isset($_POST["utente"])&&isset($_POST["password"])&&isset($_POST["email"]))   
                    {
                        $specialChars = "/ [`!@#$%^&*()_+\-=\[\]{};':\"\\|,.<>\/?~]/;";
                        $num="0123456789";
                        $letters="abcdefghijklmnopqrstuvwxyz";

                        if((!contains($_POST["utente"],$specialChars))&& ((contains($_POST["password"],$num))&&(contains(strtolower($_POST["password"]),$letters))))
                        {   
                            $conn=mysqli_connect("localhost","root","","hw1") or die("Errore:".mysqli_connect_error());

                            $utente=mysqli_real_escape_string($conn,$_POST["utente"]);
                            $password=mysqli_real_escape_string($conn,$_POST["password"]);
                            $email=mysqli_real_escape_string($conn,$_POST["email"]);
                            $insert="INSERT INTO profilo (`Username`, `Password`, `Email`) VALUES ('".($utente)."', '".($password)."', '".($email)."')";
                            
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
                            
                            $_SESSION["username"]=$utente;
                            header("Location: home.php");
                            
                            //print_r($_POST);
                            }
                            else
                            {
                                echo '<p id="errore_registrato" class="errore">Nome utente o email già registrati</p>';
                            }
                            mysqli_close($conn);
                        }
                        
                    
                    }
?>
                <p id="errore_utente" class="hidden errore">Il nome utente non può contenere caratteri speciali</p>
                <p id="errore_conferma" class="hidden errore">Le password non coincidono</p>
                <p id="errore_password" class="hidden errore">La Password deve contenere almeno un numero ed una lettera</p>
                <p id="errore_lunghezza" class="hidden errore">Limiti caratteri: Username=30; Password=30; Email=30;</p>

            </div>
    
            <form action="" method="post">
                <label><input type="text" placeholder="Nome Utente" name="utente" required></label>
                <label><input type="email" placeholder="Email" name="email" required></label>
                <label><input type="password" placeholder="Password" name="password" required></label>
                <label><input id="conferma" type="password" placeholder="Conferma Password" required></label>
                <label id="submit"><input type="submit" value="Registrazione"></label>
            </form>
            <a href="Login.php"> <h3>Hai gia'un account?<br>Accedi</h3></a>

        </div>
    </div>
 


        </body></html>