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
         <div id="username"> <img src="images/img.webp">
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

        
        $conn=mysqli_connect("localhost","root","","hw1") or die("Errore:".mysqli_connect_error());
        $username=$_SESSION["username"];

        $query='SELECT * FROM `prodotti` JOIN `prodotto-carrello` on( url=prodotto) JOIN carrello on(id=carrello) WHERE proprietario="'.$username.'"';
        $res= mysqli_query($conn,$query) or die("Errore:".mysqli_error($conn));

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
                    <img src="'.$row["UrlImg"].'">
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
                    echo '</select></p>
                <p>'.$row["prezzo"].'€</p>
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
                    <strong>Totale:</strong>125€
                </p>
            </div>
            <div class="pubblica">
                <form>
                <input row="2"  id="nome" name="nome" type="text" placeholder="Nome carrello">
                
                <input  row="10" id="descrizione" name="descrizione" type="text" placeholder="Descrizione">
                <input id="pubblica" name="pubblica" type="submit" value="Pubblica">

                
            </form>
            </div>
            
        </section>
        
    </article>
    
</body>

</html>            

