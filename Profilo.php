<?php
session_start();
if(!isset($_SESSION["username"]))
    {
        if(!isset($_COOKIE["username"])){

            header("Location: index.php");
            exit;
        }
        else{
            $_SESSION["username"]= $_COOKIE["username"];
        }
        
    }


    if(isset($_FILES["foto"])&&$_FILES["foto"]["type"]=="jpg")
        {
            
        $conn=mysqli_connect("localhost","root","","hw1") or die("Errore:".mysqli_connect_error());
        $username=$_SESSION["username"];
        echo $_FILES["foto"];
        $dati_file=$_FILES["foto"]["tmp_name"];
        $dati_file = file_get_contents($username);

// Preparo il contenuto del file per la query sql
        $dati_file = addslashes($dati_file);
        $query="UPDATE `profilo` SET `ImmagineProfilo` = $dati_file WHERE `Username` =$username";
        $res= mysqli_query($conn,$query) or die("Errore:".mysqli_error($conn));
        
        }

        
    ?>
<html>

<head>
    <title>
        Profilo
    </title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="Profilo.css">
    <script src="Profilo.js" defer="true"></script>

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
         <div id="username"> <img src="images/img.webp">
             <div id="nav_hidden">
                <a><?php echo $_SESSION['username'];?></a>
                 <a   href="logout.php">Logout</a> 
             </div>
         
         </div>
         
      </div>

 </nav>

 
    <header>
        <div class="profilo">
            <form target="_myFrame" action="">
            <label><input class="hidden" name="foto" type="file"></input><img src="images/img.webp"></label>
            
            </form>
            <div class="dati">
                <h1> <?php if(isset($_GET["foto"])) echo $_GET["foto"];?>Marco Finocchiaro</h1>
                <div class="segui">
                    <p>200 seguaci</p>
                    <button><strong>Segui</strong></button>
                </div>
                
            </div>
        </div>
        <div class="scelta">
            <div id="pub"><a >Pubblicati</a></div>
            <div id="like"><a>Piaciuti</a></div>
            
        </div>

    </header>
    <article>
         <section>
             <div class="header">
             <div class="condivisore">
                <img src="images/img.webp">
                <p><strong>Marco</strong><br>
                2h</p>
             </div>
             <strong>946.50€</strong>
            </div>
             <div class="bordo">
             <div class="Corpo">
                <p>Impianto elettrico a meno di 1000€? <br>Eccolo qui!</p>
            </div>
             <div class="carrello">
                <img src="images/arduino_uno_r3.webp">
                <img src="images/ES32-CAM-esp-32-camera-module_LR.jpg">
                <img src="images/esp32-wroom.jpg">
                <img src="images/arduino_uno_r3.webp">
                
             </div>
             </div>
             <div class="opzioni">
                <div class="like">
                    <p>150</p>
               <p>🤍</p>
                </div>
                <a ><img src="images/Schermo_Intero.png"></a>
                
             </div>
         </section>
         <section>
            <div class="header">
            <div class="condivisore">
               <img src="images/img.webp">
               <p><strong>Marco</strong><br>
               2h</p>
            </div>
            <strong>946.50€</strong>
           </div>
            <div class="bordo">
            <div class="Corpo">
               <p>Impianto elettrico a meno di 1000€? <br>Eccolo qui!</p>
           </div>
            <div class="carrello">
                <img src="images/arduino_uno_r3.webp">
                <img src="images/ES32-CAM-esp-32-camera-module_LR.jpg">
                <img src="images/esp32-wroom.jpg">
                <img src="images/arduino_uno_r3.webp">
                <img src="images/arduino_uno_r3.webp">
                <img src="images/ES32-CAM-esp-32-camera-module_LR.jpg">
                <img src="images/esp32-wroom.jpg">
                <img src="images/arduino_uno_r3.webp">
               
            </div>
            </div>
            <div class="opzioni">
                <div class="like">
                    <p>150</p>
               <p>🤍</p>
                </div>
                <a ><img src="images/Schermo_Intero.png"></a>
                
                </div>
               
            </div>
        </section>
    </article>

</body>

</html>            

   








