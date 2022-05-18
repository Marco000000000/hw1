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

    if(!isset($_POST["prodotto"]))
    {
        header("Location: carrello.php");
            exit;
    }

    ?>

<html>

<head>
    <title>
        Ricerca
    </title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="Ricerca.css">
    <script src="Ricerca.js" defer="true"></script>

</head>
<body>
    

    <nav>
             
        <a href="home.php"><div>Home</div> </a>
      
     <form action="Ricerca.php">
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
         <section class="articolo" >

            <div class="header">
                <div class="venditore">
                <p>venditore</p>
                </div>
                <div class="opzioni">
                   
                    <p> 🛒</p>
                </div>
            </div>

            <div class="oggetto">
                <div class="descrizione ">
                    <a href="" target="_blank"><img src="images/arduino_uno_r3.webp"></a>
                    <div>
                        
                        <p>oggetto</p>
                    </div>
                    
                    
                </div>
                <div class="prezzo">
                <p>quantità  
                    <select name="quantita">
                        <option selected value="1">1</option>
                        <option value="2">2</option>
                        <option value="3">3</option>
                        <option value="4">4</option>
                        <option value="5">5</option>
                        <option value="6">6</option>
                        <option value="7">7</option>
                        <option value="8">8</option>
                        <option value="9">9</option>
                    </select></p>
                <p>prezzo</p>
                </div>
            </div>

            

         </section>
        </div>
        

        <div class="divisore">
            <section class="articolo" >
   
               <div class="header">
                   <div class="venditore">
                   <p>venditore</p>
                   </div>
                   <div class="opzioni">
                       
                       <p> 🛒</p>
                       <!--❤️-->
                   </div>
               </div>
   
               <div class="oggetto">
                   <div class="descrizione ">
                   <a href="" target="_blank"><img src="images/arduino_uno_r3.webp"></a>
                       <div>
                           
                           <p>oggetto</p>
                       </div>
                       
                       
                   </div>
                   <div class="prezzo">
                   <p>quantità  
                       <select name="quantita">
                           <option selected value="1">1</option>
                           <option value="2">2</option>
                           <option value="3">3</option>
                           <option value="4">4</option>
                           <option value="5">5</option>
                           <option value="6">6</option>
                           <option value="7">7</option>
                           <option value="8">8</option>
                           <option value="9">9</option>
                       </select></p>
                   <p>prezzo</p>
                   </div>
               </div>
   
               
   
            </section>
           </div>
           <div class="divisore">
            <section class="articolo" >
   
               <div class="header">
                   <div class="venditore">
                   <p>venditore</p>
                   </div>
                   <div class="opzioni">
                      
                       <p> 🛒</p>
                       <!--❤️-->
                   </div>
               </div>
   
               <div class="oggetto">
                   <div class="descrizione ">
                   <a href=""><img src="images/arduino_uno_r3.webp"></a>
                       <div>
                           
                           <p>oggetto</p>
                       </div>
                       
                       
                   </div>
                   <div class="prezzo">
                   <p>quantità  
                       <select name="quantita">
                           <option selected value="1">1</option>
                           <option value="2">2</option>
                           <option value="3">3</option>
                           <option value="4">4</option>
                           <option value="5">5</option>
                           <option value="6">6</option>
                           <option value="7">7</option>
                           <option value="8">8</option>
                           <option value="9">9</option>
                       </select></p>
                   <p>prezzo</p>
                   </div>
               </div>
   
               
   
            </section>
           </div>
           <div class="divisore">
            <section class="articolo" >
   
               <div class="header">
                   <div class="venditore">
                   <p>venditore</p>
                   </div>
                   <div class="opzioni">
                     
                       <p> 🛒</p>
                       <!--❤️-->
                   </div>
               </div>
   
               <div class="oggetto">
                   <div class="descrizione ">
                   <a href=""><img src="images/arduino_uno_r3.webp"></a>
                       <div>
                           
                           <p>oggetto</p>
                       </div>
                       
                       
                   </div>
                   <div class="prezzo">
                   <p>quantità  
                       <select name="quantita">
                           <option selected value="1">1</option>
                           <option value="2">2</option>
                           <option value="3">3</option>
                           <option value="4">4</option>
                           <option value="5">5</option>
                           <option value="6">6</option>
                           <option value="7">7</option>
                           <option value="8">8</option>
                           <option value="9">9</option>
                       </select></p>
                   <p>prezzo</p>
                   </div>
               </div>
   
               
   
            </section>
            
           </div>
           <div class="divisore">
            <section class="articolo" >
   
               <div class="header">
                   <div class="venditore">

                   <p>venditore</p>
                   </div>
                   <div class="opzioni">
                      
                       <p> 🛒</p>
                       <!--❤️-->
                   </div>
               </div>
   
               <div class="oggetto">
                   <div class="descrizione ">
                   <a href=""><img src="images/arduino_uno_r3.webp"></a>
                       <div>
                           
                           <p>oggetto</p>
                       </div>
                       
                       
                   </div>
                   <div class="prezzo">
                   <p>quantità  
                       <select name="quantita">
                           <option selected value="1">1</option>
                           <option value="2">2</option>
                           <option value="3">3</option>
                           <option value="4">4</option>
                           <option value="5">5</option>
                           <option value="6">6</option>
                           <option value="7">7</option>
                           <option value="8">8</option>
                           <option value="9">9</option>
                       </select></p>
                   <p>prezzo</p>
                   </div>
               </div>
   
               
   
            </section>
            
           </div>


         
        
    </article>
    
</body>

</html>            

   