
<!-- saved from url=(0039)http://192.168.1.103/upload/Signin.php -->
<html><head><meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
    <title>
        Registrazione
    </title>
     
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="Registrazione.css">
    <script src="Registrazione.js" defer="true"></script>

<link rel="preconnect" href="https://fonts.googleapis.com/" crossorigin="true"><link rel="preconnect" href="https://fonts.gstatic.com/"><link rel="stylesheet" href="./Registrazione_files/css2"></head>
<body>
    
    <div id="Container">
        <div id="overlay">
            <h1>Registrati</h1>
            <p id="utente" class="hidden errore">Il nome utente non può contenere caratteri speciali</p>
            <p class="hidden errore">Le password non coincidono</p>
            <p class="hidden errore">Email non valida</p>
            <p class="hidden errore">La Password deve contenere almeno un numero ed una lettera</p>
    <form action="home.php" method="post">
        <label><input type="text" placeholder="Nome Utente" name="utente"></label>
        <label><input type="text" placeholder="Email" name="Email"></label>
        <label><input type="password" placeholder="Password" name="password"></label>
        <label><input type="password" placeholder="Conferma Password"></label>
        <label id="submit"><input type="submit" value="Registrazione"></label>
    </form>
    <a href="Login.php"> <h3>Hai gia'un account?<br>Accedi</h3></a>

    </div>
    </div>
 


        </body></html>