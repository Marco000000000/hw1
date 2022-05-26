function onResponse1(response)
{
    return response.text();
}
function onResponse(response)
{
    return response.json();
}
function onError(error) 
{
    console.log( error);
}
function onText(text)
{
console.log(text);


}
function onText1(text)
{
console.log(text);


}
function onJson(json)
{
    console.log(json);
    const divisore=document.querySelector(".divisore");
    const totale=document.querySelector(".totale em");
    totale.textContent=parseFloat(json.totale).toFixed(2)+"€";
    let ind=0;
    for(let i=0;i<json.length;i++)
    {   data=json[i];
        const articolo=document.createElement("section");
        articolo.dataset.num=i;
        articolo.classList.add("articolo");
        const header=document.createElement("div");
        header.classList.add("header");
        const venditore=document.createElement("div");
        venditore.classList.add("venditore");
        const p_venditore=document.createElement("p");
        p_venditore.textContent=data.Venditore;
        venditore.appendChild(p_venditore);
        const opzioni=document.createElement("div");
        opzioni.classList.add("opzioni");
        const p_opzioni=document.createElement("p");
        p_opzioni.textContent="🗑️";
        p_opzioni.addEventListener("click",OnDeconste);
        opzioni.appendChild(p_opzioni);
        header.appendChild(venditore);
        header.appendChild(opzioni);
        articolo.appendChild(header);
        const oggetto=document.createElement("div");
        oggetto.classList.add("oggetto");
        const descrizione=document.createElement("div");
        descrizione.classList.add("descrizione");
        const a=document.createElement("a");
        a.href=data.url;
        const img=document.createElement("img");
        img.src=data.UrlImg;
        a.appendChild(img);
        div_titolo=document.createElement("div");
        p_titolo=document.createElement("p");
        p_titolo.textContent=data.titolo;
        div_titolo.appendChild(p_titolo);
        descrizione.appendChild(a);
        descrizione.appendChild(div_titolo);
        const prezzo=document.createElement("div");
        prezzo.classList.add("prezzo");
        const p_quantita=document.createElement("p");
        const em=document.createElement("em");
        em.textContent="quantità";
        const select=document.createElement("select");
        select.name="quantita";
        
        for (let i=1;i<10;i++){
            const option=document.createElement("option");
            option.value=i;
            option.textContent=i;
            if(i==data.quantita)
            {   quantita_precedenti[ind]=i;
                ind++;
                option.selected=true;
            }
            select.appendChild(option);
        }
        
        select.addEventListener("input",onChange);
        p_quantita.appendChild(em);
        p_quantita.appendChild(select);
        const p_prezzo=document.createElement("p");
        p_prezzo.setAttribute("id","prezzo");
        p_prezzo.textContent=data.prezzo+"€";
        prezzo.appendChild(p_quantita);
        prezzo.appendChild(p_prezzo);
        oggetto.appendChild(descrizione);
        oggetto.appendChild(prezzo);
        articolo.appendChild(oggetto);
        divisore.appendChild(articolo);
    }
    console.log(quantita_precedenti);
}
function onRedirect(text)
{
    console.log(text);
    window.location.replace("home.php");
}

function onChange(event)
{
    console.log(event.currentTarget.value);
    const totale=document.querySelector(".totale em");
    console.log(parseFloat(totale.textContent.substring(0, totale.textContent.length-1)));
    const quantita=event.currentTarget.value;
    const articolo=event.currentTarget.closest(".articolo");
    const user=document.querySelector("a[href='Profilo.php']").textContent;
    const prodotto=articolo.querySelector(".descrizione a").href;
    const quantita_precedente=quantita_precedenti[articolo.dataset.num] ;
    let prezzo=articolo.querySelector("#prezzo").textContent;
    prezzo=prezzo.substring(0, prezzo.length - 1);
    totale.textContent=(parseFloat(totale.textContent.substring(0, totale.textContent.length-1))-prezzo*quantita_precedente+prezzo*quantita).toFixed(2)+"€";
   
    fetch("cambiaQuantita.php?"+
    "&quantita="+encodeURIComponent(quantita)+
    "&user="+encodeURIComponent(user)+
    "&prodotto="+encodeURIComponent(prodotto)).then(onResponse1,onError).then(onText);
}

function OnDeconste(event)
{   const user=document.querySelector("a[href='Profilo.php']").textContent;
    const link=event.currentTarget.closest(".articolo").querySelector(".descrizione a").href;
    fetch("EliminazioneCarrello.php?"+
    "&user="+encodeURIComponent(user)+
    "&link="+encodeURIComponent(link)).then(onResponse1,onError).then(onText1);
    const articolo=event.currentTarget.closest(".articolo");
    const totale=document.querySelector(".totale em");
    let prezzo=articolo.querySelector("#prezzo").textContent;
    const quantita=articolo.querySelector("select").value;
    prezzo=prezzo.substring(0, prezzo.length - 1);
    totale.textContent=(totale.textContent.substring(0, totale.textContent.length-1)-prezzo*quantita).toFixed(2)+"€";
    articolo.remove();
    event.currentTarget.removeEventListener("click", OnDeconste,false);

}

function onPubblica(event)
{   event.preventDefault();
    const user=document.querySelector("a[href='Profilo.php']").textContent;
    const form=event.currentTarget;
    const titolo=form.querySelector("input[name='nome']").value;
    const descrizione=form.querySelector("textarea").value;
    let totale=document.querySelector(".totale em").textContent
    totale=totale.substring(0, totale.length-1);
    fetch("pubblica.php?"+
    "&user="+encodeURIComponent(user)+
    "&totale="+encodeURIComponent(totale)+
    "&titolo="+encodeURIComponent(titolo)+
    "&descrizione="+encodeURIComponent(descrizione)).then(onResponse1,onError).then(onRedirect);
    
}


let quantita_precedenti=[];
let cestini=document.querySelectorAll(".opzioni p");
let quantita=document.querySelectorAll("select");
let pubblica=document.querySelector(".pubblica form");
const controllo_profilo=document.querySelector("a[href='Profilo.php']");

for(let i=0;i<cestini.length;i++)
{
    cestini[i].addEventListener("click",OnDeconste);
}
for(let i=0;i<quantita.length;i++)
{
    quantita[i].addEventListener("input",onChange);
   
}
fetch("carrelloDati.php?username="+controllo_profilo.textContent).then(onResponse,onError).then(onJson);
pubblica.addEventListener("submit",onPubblica);
