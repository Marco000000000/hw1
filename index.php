<?php
session_start();
if(isset($_SESSION["username"])||isset($_COOKIE["username"]))
    {
       

            header("Location: home.php");
            exit;
       
        
    }
    ?>
<html>

<head>
    <title>
        Home
    </title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="overlay.css">
    <link rel="stylesheet" href="home.css">
   
    <link rel="icon" type="image/x-icon" href="images/logo.jpg">
    <script src="index.js" defer="true"></script>

</head>
<body>
    

    <nav>
             
        <a href="home.php"><div>Home</div> </a>
      
     <form action="Ricerca.php">
        <svg width="30" height="30" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path d="M10.5 18a7.5 7.5 0 1 1 0-15 7.5 7.5 0 0 1 0 15Zm10.45 2.95L16 16l4.95 4.95Z" class="icon_svg-stroke" stroke="#666" stroke-width="1.5" fill="none" stroke-linecap="round" stroke-linejoin="round"></path></svg>

         <label> <input type="text" placeholder="Cerca carrello" name="cerca"></label>
      </form>
     <!--<div >
         <a href="logout.php"> Accedi </a>
         <a href="Registrazione.php"> Registrati</a>
      </div>
     -->
     
     
     
     <div id="right">
         <a id="icona" href="Carrello.php">🛒        </a>
         <div id="username"> <img src="images/profilo-vuoto.png">
             <div id="nav_hidden">
                <a href="login.php"> Accedi </a>
                <a href="Registrazione.php"> Registrati</a>
             </div>
         
         </div>
         
      </div>

 </nav>

        
    
    <article>
         
    </article>

</body>

</html>            

   








