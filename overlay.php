<?php
            if(!isset($_GET["id"]))
                {echo "0";
                    exit;
                }
   /* echo '
        
        <div class="divisore">';*/
        

        
        $conn=mysqli_connect("localhost","root","","hw1") or die("Errore:".mysqli_connect_error());
        
        $id=$_GET["id"];
        $data=[];
        $query='SELECT * FROM `prodotti` JOIN `prodotto-carrello` on( url=prodotto) JOIN carrello on(id=carrello) join profilo on(proprietario=username) WHERE id='.$id.'';
        $res= mysqli_query($conn,$query) or die("Errore:".mysqli_error($conn));
        $totale=0;
        $cont=0;
        foreach( $res as $row)
        {    $data["titolo"]=$row["Nome"];
            $data["descrizione"]=$row["Descrizione"];
            $dato=[];
            $dato["Venditore"]=$row["Venditore"];
            $dato["url"]=$row["url"];
            $dato["UrlImg"]=$row["UrlImg"];
            $dato["titolo"]=$row["titolo"];
            $dato["prezzo"]=$row["prezzo"];
            $dato["quantita"]=$row["quantita"];

         /*echo '<section class="articolo" >

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
                <p><em>quantità<em> 
                    <select name="quantita">
                    ';*/
                       /* echo '<option selected value="'.$row["quantita"].'">'.$row["quantita"].'</option>';
                        
*/
                    
                    $totale=$totale+$row["quantita"]*$row["prezzo"];
                    /*echo '</select></p>
                <p id="prezzo">'.$row["prezzo"].'€</p>
                </div>
            </div>

            

         </section>';*/
         $data[$cont]=$dato;
         $cont++;
        }

        
        $data["length"]=$cont;
        
         
         
        /*echo '</div>


         <section class="totale">
           
            <div id="chiudi"><p >X</p>
            </div>
            <div class="info">
                <h2>Titolo</h2>
                <p>descrizione</p>    
            
            </div>
            <div class="commenti">';
*/
            $query='SELECT * FROM `commenti` where carrello='.$id;
            $res= mysqli_query($conn,$query) or die("Errore:".mysqli_error($conn));
            $commenti=[];
            $cont=0;
            foreach($res as $row)
            {
                $commento["mittente"]=$row["mittente"];
                $commento["commento"]=$row["commento"];
                /*echo '<div class="commento">
                <strong>'.$row["mittente"].'</strong>
                <p>'.$row["commento"].'</p>    
                </div>';*/
                $commenti[$cont]=$commento;
                $cont++;
            }
            
            $commenti["length"]=$cont;
            $data["commenti"]=$commenti;
            $data["totale"]=number_format($totale,2);
           /* echo '
                <div class="commento nuovo">
                <strong>Nuovo commento: </strong>
                
                <textarea></textarea> 
                </div>
            </div>
            <div id="totale">
                <p>
                    <strong>Totale:&nbsp</strong><em>'.$totale.'€</em>
                </p>
            </div>
        </section>
        
    </article>';*/
    echo json_encode($data);
    mysqli_close($conn);
    ?>
          

