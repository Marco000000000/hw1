<?php
if(isset($_FILES['file']['name'])){
   // file name
   session_start();

   $filename = $_FILES['file']['name'];
   include 'dbconfig.php';
   $conn = mysqli_connect($dbconfig['host'], $dbconfig['user'], $dbconfig['password'], $dbconfig['name']) or die(mysqli_connect_error($conn));

   $filename=mysqli_real_escape_string($conn, $filename);
   // Location
   $location = "upload/".$filename;
   $url="upload/".$_SESSION['username'];
   // file extension
   $file_extension = pathinfo($location, PATHINFO_EXTENSION);
   $file_extension = strtolower($file_extension);
   $url=$url.".".$file_extension;
   $query="UPDATE `profilo` SET `ImmagineProfilo` = '".$url."' WHERE `Username` ='".$_SESSION['username']."'";

   // Valid extensions
   $valid_ext = array("pdf","doc","docx","jpg","png","jpeg","bmp","gif");

   $response = 0;
   if(in_array($file_extension,$valid_ext)){
      // Upload file
      if(move_uploaded_file($_FILES['file']['tmp_name'],$url)){
         $res=mysqli_query($conn, $query) or die("Errore:".mysqli_error($conn));
         
         $response = 1;
      } 
   }
   mysqli_close($conn); 

   echo $response;
   exit;
}
?>

