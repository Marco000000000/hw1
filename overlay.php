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
    <link rel="stylesheet" href="overlay.css">
    <script src="overlay.js" defer="true"></script>

</head>
<body>
    



        
        
    
    <article>
        
        <div class="divisore">
        <?php 

        
        $conn=mysqli_connect("localhost","root","","hw1") or die("Errore:".mysqli_connect_error());
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
                    🛒 </p>
                    
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
           
            <div id="chiudi"><p >X</p>
            </div>
            <div class="info">
                <h2>Titolo</h2>
                <p>descrizione</p>    
            
            </div>
            <div class="commenti">
                <div class="commento">
                <strong>mittente</strong>
                <p>commentodddddddddddddddddddddddddddddddddddddddddddddddddddddddaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaad</p>    
                </div>
                <div class="commento">
                <strong>mittente</strong>
                <p>commentoaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa</p>    
                </div>
                <div class="commento">
                <strong>mittentssssssssssssssssssssssssssssssssssssssssssssssssssse</strong>
                <p>commento</p>    
                </div>
            </div>
            <div id="totale">
                <p>
                    <strong>Totale:&nbsp</strong><em><?php echo $totale;?>€</em>
                </p>
            </div>
        </section>
        
    </article>
    
</body>

</html>            

