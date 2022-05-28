<?php
            if(!isset($_GET["username"]))
                {echo "0";
                    exit;
                }
  

        
                include 'dbconfig.php';
                $conn = mysqli_connect($dbconfig['host'], $dbconfig['user'], $dbconfig['password'], $dbconfig['name']) or die(mysqli_connect_error($conn));
                    
        $username=mysqli_real_escape_string($conn,$_GET["username"]);
        $data=[];
        $query='SELECT * FROM `prodotti` JOIN `prodotto-carrello` on( url=prodotto) JOIN carrello on(id=carrello) join profilo on(id=carrelloCorrente) WHERE proprietario="'.$username.'"';
        $res= mysqli_query($conn,$query) or die("Errore:".mysqli_error($conn));
        $totale=0;
        $cont=0;
        foreach( $res as $row)
        {    
            
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
        
         
     
           
            $data["totale"]=$totale;
          
    echo json_encode($data);
    mysqli_close($conn);
    ?>
          

