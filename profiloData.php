<?php
session_start();
if(isset($_GET["cerca"])&&isset($_GET["opzione"]))
    {    include 'dbconfig.php';
        $conn = mysqli_connect($dbconfig['host'], $dbconfig['user'], $dbconfig['password'], $dbconfig['name']) or die(mysqli_connect_error($conn));
    

    $username=mysqli_real_escape_string($conn,$_GET["cerca"]);
    $queryprincipale="select * from profilo where username='$username'";

    $queryalternativa="SELECT * ,COUNT(*) FROM `carrello`  join profilo ON(Username=proprietario) WHERE Nome IS NOT NULL and (Nome like '%$username%' OR Descrizione LIKE '%$username%' ) GROUP by Username ORDER BY COUNT(id) DESC;";

    
    $res= mysqli_query($conn,$queryprincipale) or die("Errore:".mysqli_error($conn));
        
    if($res->num_rows>0)
    {
        $row=mysqli_fetch_assoc($res);
        $username=$row["Username"];
        $imgprofilo=$row["ImmagineProfilo"];
        
    }
    else {
        $res= mysqli_query($conn,$queryalternativa) or die("Errore:".mysqli_error($conn));
        if($res->num_rows>0)
        {
            $row=mysqli_fetch_assoc($res);
            $username=$row["Username"];
            $imgprofilo=$row["ImmagineProfilo"];

        }
        else {
            echo 0;
            exit;
        }
    }

    if($_GET["opzione"]=="pub")
    {
        $query1="SELECT * FROM `carrello` join `prodotto-carrello` ON (ID=carrello)  WHERE proprietario='$username' and Nome IS NOT NULL  GROUP BY carrello ORDER by data desc";

    }
    else{
        if($_GET["opzione"]=="like")
            $query1="SELECT * FROM `carrello` join `prodotto-carrello` ON (ID=carrello)  WHERE carrello in (SELECT carrello from profilo join piaciuti on(mittente=Username) where Username='$username' ) and Nome IS NOT NULL  GROUP BY carrello ORDER by data desc";
        else
            if($_GET["opzione"]=="follow")
               $query1="SELECT * FROM `carrello` join `prodotto-carrello` ON (ID=carrello)  WHERE proprietario in (SELECT seguito from profilo join segui on(seguace=Username) where Username='$username' ) and Nome IS NOT NULL  GROUP BY carrello ORDER by data DESC";
            else
                echo 0;
    }
    $queryfollow="Select count(*) as conta from segui where   seguito='$username'";
    $res= mysqli_query($conn,$queryfollow) or die("Errore:".mysqli_error($conn));
    $row=mysqli_fetch_assoc($res);
    $row=$row["conta"];


   
    $queryFollower="Select * from segui where seguace='".$_SESSION["username"]."' and seguito='$username'";

    $res= mysqli_query($conn,$queryFollower) or die("Errore:".mysqli_error($conn));
    $data=[];
    //$data["get"]=$_GET["cerca"];
    $data["follower"]=$row;
    if($res->num_rows>0)
        {
            $data["followed"]=true;
        }
    else
        {
            $data["followed"]=false;
        }
    $res= mysqli_query($conn,$query1) or die("Errore:".mysqli_error($conn));

    $data["imgProfilo"]=$imgprofilo;
    $data["username"]=$username;
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
    
        $querylike="SELECT * FROM `piaciuti` WHERE mittente='".$_SESSION["username"]."' and carrello=".$row["carrello"];
        $reslike= mysqli_query($conn,$querylike) or die("Errore:".mysqli_error($conn));
        

        $dato=[];
        
        $dato["carrello"]=$row["carrello"];
        $dato["ImmagineProfilo"]=$ImmagineProfilo;
        $dato["proprietario"]=$row["proprietario"];
        $dato["Totale"]=$row["Totale"];
        $dato["Nome"]=$row["Nome"];
        $dato["likes"]=$row["likes"];
        if($reslike->num_rows>0)
        {
            $dato["emoji"]="❤️";
        }
        else{
            $dato["emoji"]="🤍";
        }
        $dato["tempo"]=$diff;
       
        $query='SELECT * FROM `carrello` join `prodotto-carrello` ON (ID=carrello) join prodotti ON(url=prodotto) WHERE  carrello='.$row["carrello"].' and Nome IS NOT NULL  ORDER by  carrello DESC; ';
    
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
        $data["length"]=$contatore;
        echo json_encode($data);
    }else {
        echo 0;
        }
        ?>

