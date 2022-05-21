/*function onInput(event)
{
    console.log("aa");
    let form=event.target.closest("form");
    form.submit();
}*/
function onLeave(event)
{
    event.target.src=imgsrc;
}
function onHover(event)
{
    event.target.src="images/senzatitolo.png";
    img.addEventListener("mouseleave",onLeave);
    
}
function onResponse(response)
{
    return response.text();
}

function onText(text)
{
    console.log(text);
    if(text==1)
    {
        alert("Immagine caricata correttamente");
        location.reload();
    }
    else{

        alert("formato non valido");
    }
}

function uploadFile(event) {

    let files = event.currentTarget.files;
 
    if(files.length > 0 ){
 
       var formData = new FormData();
       formData.append("file", files[0]);
 
 

        fetch("uploadPhoto.php",{
            method:"post",
            body:formData
        }).then(onResponse).then(onText);

 
    }else{
       alert("Please select a file");
    }
 
 }


let input=document.querySelector("input[name=foto]");
input.addEventListener("input",uploadFile);
let img=document.querySelector(".profilo img");
let imgsrc=img.src;
img.addEventListener("mouseover",onHover);


/*function onResponse(response)
{
    return response.text();
}

function onText(text)
{
    console.log(text);
}

function uploadFile() {

    let files = document.getElementById("file").files;
 
    if(files.length > 0 ){
 
       let formData = new FormData();
       formData.append("file", files[0]);
 
 

        fetch("uploadPhoto.php",{
            method:"post",
            body:formData
        }).then(onResponse).then(onText);

 
    }else{
       alert("Please select a file");
    }
 
 }
 
 
 <html>
    <head>
    <script src="upload.js" defer> </script>
</head>
   
<body>
<input type="file" name="file" id="file">
  <input type="button" id="btn_uploadfile" 
     value="Upload" 
     onclick="uploadFile();" >
</div>  
</body></html>
<div >
 


<?php

if(isset($_FILES['file']['name'])){
   // file name
   $filename = $_FILES['file']['name'];

   // Location
   $location = $filename;

   // file extension
   $file_extension = pathinfo($location, PATHINFO_EXTENSION);
   $file_extension = strtolower($file_extension);

   // Valid extensions
   $valid_ext = array("pdf","doc","docx","jpg","png","jpeg");

   $response = 0;
   if(in_array($file_extension,$valid_ext)){
      // Upload file
      if(move_uploaded_file($_FILES['file']['tmp_name'],$location)){
         $response = 1;
      } 
   }

   echo $response;
   exit;
}
?>


 */