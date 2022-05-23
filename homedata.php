<?php
session_start();
if(isset($_GET["cerca"]))
    {   $query1="SELECT * FROM `carrello` join `prodotto-carrello` ON (ID=carrello)  WHERE Nome IS NOT NULL and (Nome like '%".$_GET["cerca"]."%' OR Descrizione LIKE '%".$_GET["cerca"]."%' )  GROUP BY carrello ORDER by data desc,proprietario, carrello DESC";
    }
    else
    {
        $query1="SELECT * FROM `carrello` join `prodotto-carrello` ON (ID=carrello)  WHERE Nome IS NOT NULL GROUP BY carrello ORDER by data desc,proprietario, carrello DESC";
    }


    $conn=mysqli_connect("localhost","root","","hw1") or die("Errore:".mysqli_connect_error());


    $res= mysqli_query($conn,$query1) or die("Errore:".mysqli_error($conn));
    $data=[];
    //$data["get"]=$_GET["cerca"];
    $contatore=0;
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
        if(isset($_SESSION["username"])){
        $querylike="SELECT * FROM `piaciuti` WHERE mittente='".$_SESSION["username"]."' and carrello=".$row["carrello"];
        $reslike= mysqli_query($conn,$querylike) or die("Errore:".mysqli_error($conn));
        }

        $dato=[];
        
        $dato["carrello"]=$row["carrello"];
        $dato["ImmagineProfilo"]=$ImmagineProfilo;
        $dato["proprietario"]=$row["proprietario"];
        $dato["Totale"]=$row["Totale"];
        $dato["Nome"]=$row["Nome"];
        $dato["likes"]=$row["likes"];
        if(isset($_SESSION["username"])&&$reslike->num_rows>0)
        {
            $dato["emoji"]="❤️";
        }
        else{
            $dato["emoji"]="🤍";
        }
        $dato["tempo"]=$diff;
        if(isset($_GET["cerca"]))
        {
            $query='SELECT * FROM `carrello` join `prodotto-carrello` ON (ID=carrello) join prodotti ON(url=prodotto) WHERE carrello='.$row["carrello"].' and Nome IS NOT NULL and (Nome like "%'.$_GET["cerca"].'%" OR Descrizione LIKE "%'.$_GET["cerca"].'%" ) ORDER by proprietario, carrello DESC; ';
        }
        else
        {
            $query='SELECT * FROM `carrello` join `prodotto-carrello` ON (ID=carrello) join prodotti ON(url=prodotto) WHERE carrello='.$row["carrello"].' and Nome IS NOT NULL ORDER by proprietario, carrello DESC;';
        }
        $resimg= mysqli_query($conn,$query) or die("Errore:".mysqli_error($conn));
        $foto=[];
        $link=[];
        $cont=0;
        foreach($resimg as $rowimg){
            $foto["img".$cont]=$rowimg["UrlImg"];
            $link["url".$cont]=$rowimg["url"];
            $cont++;
        }
        $dato["numElementi"]=$cont;
        $dato["foto"]=$foto;
        $dato["link"]=$link;
        
        $data[$contatore]=$dato;
        $contatore++;
        }
        echo json_encode($data);
   
        ?>


