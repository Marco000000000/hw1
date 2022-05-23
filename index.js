function onResponse(response)
{
    return response.json();
}

function onError(error) 
{
    console.log('Error: ' + error);
}
   

function onJson(json)
{   console.log(json);
    let article=document.querySelector("article");
    article.innerHTML="";
    
    for(let i=0;i<json.length;i++ )
    {   let data=json[i];
        let section=document.createElement("section");
        section.dataset.num=data.carrello;
        let header=document.createElement("div");
        header.classList.add("header");
        let condivisore=document.createElement("div");
        condivisore.classList.add("condivisore");
        let immagineProfilo=document.createElement("img");
        immagineProfilo.src=data.ImmagineProfilo;
        let p_proprietario=document.createElement("p");
        let strong_propr=document.createElement("strong");
        strong_propr.textContent=data.proprietario;
        let em=document.createElement("em");
        let br=document.createElement("br");
        em.textContent=data.tempo;
        p_proprietario.appendChild(strong_propr);
        p_proprietario.appendChild(br);
        p_proprietario.appendChild(em);
        let strong_totale=document.createElement("strong");
        strong_totale.textContent=data.Totale+"€";
        condivisore.appendChild(immagineProfilo);
        condivisore.appendChild(p_proprietario);
        header.appendChild(condivisore);
        header.appendChild(strong_totale);
        let bordo=document.createElement("div");
        bordo.classList.add("bordo");
        let corpo=document.createElement("div");
        corpo.classList.add("Corpo");
        let p_nome=document.createElement("p");
        p_nome.textContent=data.Nome;
        corpo.appendChild(p_nome);
        let carrello=document.createElement("div");
        carrello.classList.add("carrello");
        for(let e=0;e<data.numElementi;e++)
        {
            let a=document.createElement("a");
            a.href=data.link["url"+e];
            a.target="_blank";
            let img=document.createElement("img");
            img.src=data.foto["img"+e];
            a.appendChild(img);
            carrello.appendChild(a);
        }

        bordo.appendChild(corpo);
        bordo.appendChild(carrello);
        let opzioni=document.createElement("div");
        opzioni.classList.add("opzioni");
        let like=document.createElement("div");
        like.classList.add("like");
        let p_like=document.createElement("p");
        p_like.textContent=data.likes;
        let hearth=document.createElement("p");
        hearth.classList.add("hearth");
        hearth.textContent=data.emoji;
        let schermo_intero=document.createElement("img");
        schermo_intero.classList.add("schermo_intero");
        schermo_intero.src="images/Schermo_Intero.png";
        schermo_intero.addEventListener("click",onClick);
        like.appendChild(p_like);
        like.appendChild(hearth);
        opzioni.appendChild(like);
        opzioni.appendChild(schermo_intero);
        section.appendChild(header);
        section.appendChild(bordo);
        section.appendChild(opzioni);
        article.appendChild(section);
    }
}

function onResponse1(response)
{
    return response.text();
}
function onSubmit(event)
{   let form=event.currentTarget;
    console.log(form);
    let input=form.querySelector("input");
    event.preventDefault();
    fetch("homedata.php?cerca="+input.value).then(onResponse,onError).then(onJson);
}
function onClose()
{
    let div=document.querySelector(".fixed-content");
    div.remove();
    document.querySelector(".stop").classList.remove("stop");

}
function onLike(event){
    let numlike=event.currentTarget.closest(".like").querySelector("p");
    let emoji=event.currentTarget;
    if(emoji.textContent=="🤍")
    {  
        emoji.textContent="❤️";
        numlike.textContent=parseInt(numlike.textContent)+1;
    }
    else
    {
        emoji.textContent="🤍";
        numlike.textContent=parseInt(numlike.textContent)-1;
    }
    let id=event.currentTarget.closest("section").dataset.num;
    fetch("modificaLike.php?carrello="+id).then(onResponse1,onError).then(onText1);
}
function onText1(text)
{
    console.log(text);
}


function onOverlay(json){
    console.log(json);
    let body=document.querySelector("body");
    div=document.createElement("div");
    body.querySelector("article").classList.add("stop");
    div.classList.add("fixed-content");
    let divisore=document.createElement("div");
    divisore.classList.add("divisore");

    for(let i=0;i<json.length;i++)
    { 
        data=json[i];
        let articolo=document.createElement("section");
        articolo.classList.add("articolo");
        let header=document.createElement("div");
        header.classList.add("header");
        let venditore=document.createElement("div");
        venditore.classList.add("venditore");
        let p_venditore=document.createElement("p");
        p_venditore.textContent=data.Venditore;
        venditore.appendChild(p_venditore);
        let opzioni=document.createElement("div");
        opzioni.classList.add("opzioni");
        let p_opzioni=document.createElement("p");
        p_opzioni.textContent="🛒";
        opzioni.appendChild(p_opzioni);
        header.appendChild(venditore);
        header.appendChild(opzioni);
        articolo.appendChild(header);
        let oggetto=document.createElement("div");
        oggetto.classList.add("oggetto");
        let descrizione=document.createElement("div");
        descrizione.classList.add("descrizione");
        let a=document.createElement("a");
        a.href=data.url;
        let img=document.createElement("img");
        img.src=data.UrlImg;
        a.appendChild(img);
        div_titolo=document.createElement("div");
        p_titolo=document.createElement("p");
        p_titolo.textContent=data.titolo;
        div_titolo.appendChild(p_titolo);
        descrizione.appendChild(a);
        descrizione.appendChild(div_titolo);
        let prezzo=document.createElement("div");
        prezzo.classList.add("prezzo");
        p_quantita=document.createElement("p");
        let em=document.createElement("em");
        em.textContent="quantità";
        let select=document.createElement("select");
        select.name="quantita";
        let option=document.createElement("option");
        option.value=data.quantita;
        option.textContent=data.quantita;
        select.appendChild(option);
        p_quantita.appendChild(em);
        p_quantita.appendChild(select);
        let p_prezzo=document.createElement("p");
        p_prezzo.setAttribute("id","prezzo");
        p_prezzo.textContent=data.prezzo+"€";
        prezzo.appendChild(p_quantita);
        prezzo.appendChild(p_prezzo);
        oggetto.appendChild(descrizione);
        oggetto.appendChild(prezzo);
        articolo.appendChild(oggetto);
        divisore.appendChild(articolo);
    }

    let div_totale=document.createElement("div");
    let totale=document.createElement("section");
    totale.classList.add("totale");
    let chiudi=document.createElement("div");
    chiudi.setAttribute("id","chiudi");
    chiudi.addEventListener("click",onClose);
    let p_chiudi=document.createElement("p");
    p_chiudi.textContent="X";
    chiudi.appendChild(p_chiudi);
    let info=document.createElement("div");
    info.classList.add("info");
    let h2=document.createElement("h2");
    h2.textContent=json.titolo;
    let p_descrizione=document.createElement("p");
    p_descrizione.textContent=json.descrizione;
    info.appendChild(h2);
    info.appendChild(p_descrizione);
    totale.appendChild(chiudi);
    totale.appendChild(info);
    let commenti=document.createElement("div");
    commenti.classList.add("commenti");
    for(let i=0;i<json.commenti.length;i++)
    {   
        let data=json.commenti[i];
        let commento=document.createElement("div");
        commento.classList.add("commento");
        let strong=document.createElement("strong");
        let p_commento=document.createElement("p");
        p_commento.textContent=data.commento;
        strong.textContent=data.mittente;
        commento.appendChild(strong);
        commento.appendChild(p_commento);
        commenti.appendChild(commento);
    }
    let nuovocommento=document.createElement("div");
    nuovocommento.classList.add("commento");
    nuovocommento.classList.add("nuovo");
    
    commenti.appendChild(nuovocommento);
    totale.appendChild(commenti);
    let somma=document.createElement("div");
    somma.setAttribute("id","totale");
    let p_somma=document.createElement("p");
    let strong_somma=document.createElement("strong");
    strong_somma.textContent="Totale: ";
    let em_somma=document.createElement("em");
    em_somma.textContent=json.totale;
    p_somma.appendChild(strong_somma);
    p_somma.appendChild(em_somma);
    somma.appendChild(p_somma);
    totale.appendChild(somma);
    div_totale.appendChild(totale);
    divisore.appendChild(div_totale);
    div.appendChild(divisore);
    body.appendChild(div);

}

function onCarrello(event)
{
    let target=event.currentTarget;
    target.textContent="✔";

    let link=target.closest(".articolo ").querySelector("a").href;
    let user=document.querySelector("a[href='Profilo.php']").textContent;
    fetch("InserimentoLocale.php?"+
    "&user="+encodeURIComponent(user)+
    "&link="+encodeURIComponent(link)).then(onResponse1,onError).then(onText1);
}
function onClick(event){
    let id=event.currentTarget.closest("section").dataset.num;
    carrelloAttuale=id;
    fetch("overlay.php?id="+id).then(onResponse,onError).then(onOverlay);
}
function onText(text)
{   
    console.log(text);
    if(text=="1")
    {
        alert("commento inserito correttamente");
        onClose();

        fetch("overlay.php?id="+carrelloAttuale).then(onResponse,onError).then(onOverlay);
    }
}

function onEnter(event){
    if(event.which === 13){
        let commento=event.currentTarget.value;
        console.log(commento);
        fetch("aggiungiCommento.php?commento="+commento+
        "&carrello="+carrelloAttuale).then(onResponse1,onError).then(onText);
    }
}

let carrelloAttuale;
let cerca=document.querySelector("nav form");
cerca.addEventListener("submit",onSubmit)
fetch("homedata.php").then(onResponse,onError).then(onJson);



//console.log(pulsanti);





