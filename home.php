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
    $conn=mysqli_connect("localhost","root","","hw1") or die("Errore:".mysqli_connect_error());
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
        

    if(isset($_GET["cerca"]))
    {   $query1="SELECT * FROM `carrello` join `prodotto-carrello` ON (ID=carrello)  WHERE Nome IS NOT NULL and (Nome like '%".$_GET["cerca"]."%' OR Descrizione LIKE '%".$_GET["cerca"]."%' )  GROUP BY carrello ORDER by proprietario, carrello DESC";
    }
    else
    {
        $query1="SELECT * FROM `carrello` join `prodotto-carrello` ON (ID=carrello)  WHERE Nome IS NOT NULL GROUP BY carrello ORDER by proprietario, carrello DESC";
    }
    ?>

<html>

<head>
    <title>
        Home
    </title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="home.css">
    <script src="home.js" defer="true"></script>

</head>
<body>
    

    <nav>
             
        <a href="home.php"><div>Home</div> </a>
      
     <form action="home.php">
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
         <div id="username"> <img src="<?php echo $img;?>">
             <div id="nav_hidden">
                <a href="Profilo.php"><?php echo $_SESSION['username'];?></a>
                 <a   href="logout.php">Logout</a> 
             </div>
         
         </div>
         
      </div>

 </nav>

        
    
    <article>

        <?php
                $res= mysqli_query($conn,$query1) or die("Errore:".mysqli_error($conn));
                
                foreach( $res as $row)
                {  
                    $querydentro="SELECT ImmagineProfilo from profilo where Username='".$row["proprietario"]."'";
                    $resfor= mysqli_query($conn,$querydentro) or die("Errore:".mysqli_error($conn));
                    $rowfor=mysqli_fetch_assoc($resfor);
                    $ImmagineProfilo=$rowfor["ImmagineProfilo"];
                    $timestamp=strtotime($row["data"]);
                    
	                $strTime = array("s", "m", "h", "d", "m", "y");
	                $length = array("60","60","24","30","12","10");

	                $currentTime = time();
	                if($currentTime >= $timestamp) {
			           $diff     = time()- $timestamp;
                        for($i = 0; $diff >= $length[$i] && $i < count($length)-1; $i++) {
                        $diff = $diff / $length[$i];
                        }

                    $diff = round($diff);
                    $diff=$diff . " " . $strTime[$i];
	                }
	
                echo '<section>
                <div class="header">
                <div class="condivisore">
                <img src="'.$ImmagineProfilo.'">
                <p><strong>'.$row["proprietario"].'</strong><br>
                '.$diff.'</p>
                </div>
                <strong>'.$row["Totale"].'€</strong>
                </div>
                <div class="bordo">
                <div class="Corpo">
                <p>'.$row["Nome"].'</p>
                </div>
                <div class="carrello">';
                if(isset($_GET["cerca"]))
                {
                    $query='SELECT * FROM `carrello` join `prodotto-carrello` ON (ID=carrello) join prodotti ON(url=prodotto) WHERE carrello='.$row["carrello"].' and Nome IS NOT NULL and (Nome like "%'.$_GET["cerca"].'%" OR Descrizione LIKE "%'.$_GET["cerca"].'%" ) ORDER by proprietario, carrello DESC; ';
                }
                else
                {
                    $query='SELECT * FROM `carrello` join `prodotto-carrello` ON (ID=carrello) join prodotti ON(url=prodotto) WHERE carrello='.$row["carrello"].' and Nome IS NOT NULL ORDER by proprietario, carrello DESC;';
                }
                $resimg= mysqli_query($conn,$query) or die("Errore:".mysqli_error($conn));

                foreach($resimg as $rowimg){
                    echo '<a href="'.$rowimg["url"].'" target="_blank"><img src="'.$rowimg["UrlImg"].'"></a>';
                
                }
                echo '</div>
                </div>
                <div class="opzioni">
                <div class="like">
                    <p>'.$row["likes"].'</p>
                <p>🤍</p>
                </div>
                <img class="schermo_intero" src="images/Schermo_Intero.png">
                
                </div>
                </section>';

                }
        ?>



         
    </article>

</body>

</html>            

   








