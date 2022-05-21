function onResponse1(response)
{
    return response.text();
}
function onError(error) 
{
    console.log( error);
}
function onText(text)
{
console.log(text);

location.reload();
}
function onText1(text)
{
console.log(text);


}

function onChange(event)
{
    console.log(event.currentTarget.value);
    let quantita=event.currentTarget.value;
    let user=document.querySelector("a[href='Profilo.php']").textContent;
    let prodotto=event.currentTarget.closest(".articolo").querySelector(".descrizione a").href;
    fetch("cambiaQuantita.php?"+
    "&quantita="+encodeURIComponent(quantita)+
    "&user="+encodeURIComponent(user)+
    "&prodotto="+encodeURIComponent(prodotto)).then(onResponse1,onError).then(onText);
}

function OnDelete(event)
{   let user=document.querySelector("a[href='Profilo.php']").textContent;
    let link=event.currentTarget.closest(".articolo").querySelector(".descrizione a").href;
    fetch("EliminazioneCarrello.php?"+
    "&user="+encodeURIComponent(user)+
    "&link="+encodeURIComponent(link)).then(onResponse1,onError).then(onText1);
    let articolo=event.currentTarget.closest(".articolo");
    let totale=document.querySelector(".totale em");
    let prezzo=articolo.querySelector("#prezzo").textContent;
    let quantita=articolo.querySelector("select").value;
    prezzo=prezzo.substring(0, prezzo.length - 1);
    totale.textContent=(totale.textContent.substring(0, totale.textContent.length-1)-prezzo*quantita).toFixed(2)+"€";
    console.log(articolo.remove());
    event.currentTarget.removeEventListener("click", OnDelete,false);

}

function onPubblica(event)
{   event.preventDefault();
    let user=document.querySelector("a[href='Profilo.php']").textContent;
    let form=event.currentTarget;
    let titolo=form.querySelector("input[name='nome']").value;
    let descrizione=form.querySelector("textarea").value;
    let totale=document.querySelector(".totale em").textContent
    totale=totale.substring(0, totale.length-1);
    fetch("pubblica.php?"+
    "&user="+encodeURIComponent(user)+
    "&totale="+encodeURIComponent(totale)+
    "&titolo="+encodeURIComponent(titolo)+
    "&descrizione="+encodeURIComponent(descrizione)).then(onResponse1,onError).then(onText);

}



let cestini=document.querySelectorAll(".opzioni p");
let quantita=document.querySelectorAll("select");
let pubblica=document.querySelector(".pubblica form");
for(let i=0;i<cestini.length;i++)
{
    cestini[i].addEventListener("click",OnDelete);
}
for(let i=0;i<quantita.length;i++)
{
    options=quantita[i].addEventListener("input",onChange);
   
}

pubblica.addEventListener("submit",onPubblica);
