function onInput(event)
{
    console.log("aa");
    let form=event.target.closest("form");
    form.submit();
}
function onLeave(event)
{
    event.target.src="images/img.webp";
}
function onHover(event)
{
    event.target.src="images/senzatitolo.png";
    img.addEventListener("mouseleave",onLeave);
    
}
let input=document.querySelector("input[name=foto]");
input.addEventListener("input",onInput);
img=document.querySelector(".profilo img");
img.addEventListener("mouseover",onHover)