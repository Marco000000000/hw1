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
    $query="select ImmagineProfilo as img from profilo where Username='".$_SESSION["username"]."'";
    include 'dbconfig.php';
    $conn = mysqli_connect($dbconfig['host'], $dbconfig['user'], $dbconfig['password'], $dbconfig['name']) or die(mysqli_connect_error($conn));
    $carrello=mysqli_real_escape_string($conn,$_GET["carrello"]);
    $res= mysqli_query($conn,$query) or die("Errore:".mysqli_error($conn));
    $row=mysqli_fetch_assoc($res);
    if(isset($row["img"]))
    {
        $img=$row["img"];
    }
    else
    {
        $img="Images/profilo-vuoto.png";
    }
    $row=$row["img"];
   
    ?>

<html>

<head>
    <title>
        Carrello
    </title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="Carrello.css">
    <script src="Carrello.js" defer="true"></script>

</head>
<body>
    

    <nav>
             
        <a href="home.php"><div>Home</div> </a>
      
     <form action="Ricerca.php" method="post">
        <svg width="30" height="30" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path d="M10.5 18a7.5 7.5 0 1 1 0-15 7.5 7.5 0 0 1 0 15Zm10.45 2.95L16 16l4.95 4.95Z" class="icon_svg-stroke" stroke="#666" stroke-width="1.5" fill="none" stroke-linecap="round" stroke-linejoin="round"></path></svg>

         <label> <input type="text" placeholder="Cerca prodotto" name="cerca"></label>
      </form>
     <!--<div >
         <a href="logout.php"> Accedi </a>
         <a href="Registrazione.php"> Registrati</a>
      </div>
     -->
     
     
     
     <div id="right">
         <a id="icona" href="Carrello.php">🛒        </a>
         <div id="username"> <img src="<?php echo $img;?>">
             <div id="nav_hidden">
                <a href="Profilo.php"><?php echo $_SESSION['username'];?></a>
                 <a   href="logout.php">Logout</a> 
             </div>
         
         </div>
         
      </div>

 </nav>


        
        
    
    <article>
        
        <div class="divisore">
        <?php 

        
        $username=$_SESSION["username"];

        $query='SELECT * FROM `prodotti` JOIN `prodotto-carrello` on( url=prodotto) JOIN carrello on(id=carrello) join profilo on(id=carrelloCorrente) WHERE proprietario="'.$username.'"';
        $res= mysqli_query($conn,$query) or die("Errore:".mysqli_error($conn));
        $totale=0;
        foreach( $res as $row)
        {    

         echo '<section class="articolo" >

            <div class="header">
                <div class="venditore">
                <p>'.$row["Venditore"].'</p>
                </div>
                <div class="opzioni">
                    <p>	
                        🗑️ </p>
                    
                </div>
            </div>

            <div class="oggetto">
                <div class="descrizione ">
                  <a href="'.$row["url"].'">  <img src="'.$row["UrlImg"].'"></a>
                    <div>
                        
                        <p>'.$row["titolo"].'</p>
                    </div>
                    
                    
                </div>
                <div class="prezzo">
                <p>quantità  
                    <select name="quantita">
                    ';
                    for($i=1;$i<10;$i++)
                    {
                        if($row["quantita"]==$i)
                        echo '<option selected value="'.$i.'">'.$i.'</option>';
                        else 
                        echo '<option value="'.$i.'">'.$i.'</option>';

                    }
                    $totale=$totale+$row["quantita"]*$row["prezzo"];
                    echo '</select></p>
                <p id="prezzo">'.$row["prezzo"].'€</p>
                </div>
            </div>

            

         </section>';
        }

        mysqli_close($conn);

        
         
         ?>
        </div>


         <section class="totale">
            <div>
                <p>
                    <strong>Totale:&nbsp</strong><em><?php echo $totale;?>€</em>
                </p>
            </div>
            <div class="pubblica">
                <p class="errore hidden">Superato il limite dei 255 caratteri</p>
                <form>
                <input row="2"  id="nome" name="nome" type="text" placeholder="Nome carrello" required>
                <textarea id="descrizione" name="descrizione" placeholder="Descrizione" rows="10" cols="50" required></textarea>
                <input id="pubblica" name="pubblica" type="submit" value="Pubblica">

                
            </form>
            </div>
            
        </section>
        
    </article>
    
</body>

</html>            

