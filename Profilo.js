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


let input=document.querySelector("input[name=foto]");
input.addEventListener("input",uploadFile);
let img=document.querySelector(".profilo img");
let imgsrc=img.src;
img.addEventListener("mouseover",onHover);


