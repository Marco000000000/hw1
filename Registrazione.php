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
            
                <p id="errore_utente" class="hidden errore">Il nome utente non può contenere caratteri speciali</p>
                <p id="errore_conferma" class="hidden errore">Le password non coincidono</p>
                <p id="errore_password" class="hidden errore">La Password deve contenere almeno un numero ed una lettera</p>
                <p id="errore_lunghezza" class="hidden errore">Limiti caratteri: Username=30; Password=30; Email=30;</p>
                <p id="errore_registrato" class="hidden errore">Nome utente o email già registrati</p>

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