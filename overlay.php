<?php
            if(!isset($_GET["id"]))
                {echo "0";
                    exit;
                }
 
        

        
        $conn=mysqli_connect("localhost","root","","hw1") or die("Errore:".mysqli_connect_error());
        
        $id=mysqli_real_escape_string($conn,$_GET["id"]);
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

                    
                    $totale=$totale+$row["quantita"]*$row["prezzo"];
                    
         $data[$cont]=$dato;
         $cont++;
        }

        
        $data["length"]=$cont;
        
         
         
        
            $query='SELECT * FROM `commenti` where carrello='.$id;
            $res= mysqli_query($conn,$query) or die("Errore:".mysqli_error($conn));
            $commenti=[];
            $cont=0;
            foreach($res as $row)
            {   $commento["id"]=$row["id"];
                $commento["mittente"]=$row["mittente"];
                $commento["commento"]=$row["commento"];
                
                $commenti[$cont]=$commento;
                $cont++;
            }
            
            $commenti["length"]=$cont;
            $data["commenti"]=$commenti;
            $data["totale"]=number_format($totale,2);
          
    echo json_encode($data);
    mysqli_close($conn);
    ?>
          

