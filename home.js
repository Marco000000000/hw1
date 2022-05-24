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
    const article=document.querySelector("article");
    article.innerHTML="";
    
    for(let i=0;i<json.length;i++ )
    {   const data=json[i];
        const section=document.createElement("section");
        section.dataset.num=data.carrello;
        const header=document.createElement("div");
        header.classList.add("header");
        const condivisore=document.createElement("div");
        condivisore.classList.add("condivisore");
        const immagineProfilo=document.createElement("img");
        if(data.ImmagineProfilo!=null)
        {
            immagineProfilo.src=data.ImmagineProfilo;
            
        }
            
        else{
            immagineProfilo.src="images/profilo-vuoto.png";
          
        }
        
        const p_proprietario=document.createElement("p");
        const strong_propr=document.createElement("strong");
        strong_propr.textContent=data.proprietario;
        const em=document.createElement("em");
        const br=document.createElement("br");
        em.textContent=data.tempo;
        p_proprietario.appendChild(strong_propr);
        p_proprietario.appendChild(br);
        p_proprietario.appendChild(em);
        const strong_totale=document.createElement("strong");
        strong_totale.textContent=data.Totale+"€";
        condivisore.appendChild(immagineProfilo);
        condivisore.appendChild(p_proprietario);
        header.appendChild(condivisore);
        header.appendChild(strong_totale);
        const bordo=document.createElement("div");
        bordo.classList.add("bordo");
        const corpo=document.createElement("div");
        corpo.classList.add("Corpo");
        const p_nome=document.createElement("p");
        p_nome.textContent=data.Nome;
        corpo.appendChild(p_nome);
        const carrello=document.createElement("div");
        carrello.classList.add("carrello");
        for(let e=0;e<data.numElementi;e++)
        {
            const a=document.createElement("a");
            a.href=data.link["url"+e];
            a.target="_blank";
            const img=document.createElement("img");
            img.src=data.foto["img"+e];
            a.appendChild(img);
            carrello.appendChild(a);
        }

        bordo.appendChild(corpo);
        bordo.appendChild(carrello);
        const opzioni=document.createElement("div");
        opzioni.classList.add("opzioni");
        const like=document.createElement("div");
        like.classList.add("like");
        const p_like=document.createElement("p");
        p_like.textContent=data.likes;
        const hearth=document.createElement("p");
        hearth.classList.add("hearth");
        hearth.textContent=data.emoji;
        hearth.addEventListener("click",onLike);
        const schermo_intero=document.createElement("img");
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
{   const form=event.currentTarget;
    console.log(form);
    const input=form.querySelector("input");
    event.preventDefault();
    fetch("homedata.php?cerca="+input.value).then(onResponse,onError).then(onJson);
}
function onClose()
{
    const div=document.querySelector(".fixed-content");
    div.remove();
    document.querySelector(".stop").classList.remove("stop");

}
function onLike(event){
    const numlike=event.currentTarget.closest(".like").querySelector("p");
    const emoji=event.currentTarget;
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
    const id=event.currentTarget.closest("section").dataset.num;
    fetch("modificaLike.php?carrello="+id).then(onResponse1,onError).then(onText1);
}
function onText1(text)
{
    console.log(text);
}


function onOverlay(json){
    console.log(json);
    const body=document.querySelector("body");
    div=document.createElement("div");
    body.querySelector("article").classList.add("stop");
    div.classList.add("fixed-content");
    const divisore=document.createElement("div");
    divisore.classList.add("divisore");

    for(let i=0;i<json.length;i++)
    { 
        data=json[i];
        const articolo=document.createElement("section");
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
        p_opzioni.textContent="🛒";
        p_opzioni.addEventListener("click",onCarrello);
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
        p_quantita=document.createElement("p");
        const em=document.createElement("em");
        em.textContent="quantità";
        const select=document.createElement("select");
        select.name="quantita";
        const option=document.createElement("option");
        option.value=data.quantita;
        option.textContent=data.quantita;
        select.appendChild(option);
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

    const div_totale=document.createElement("div");
    const totale=document.createElement("section");
    totale.classList.add("totale");
    const chiudi=document.createElement("div");
    chiudi.setAttribute("id","chiudi");
    chiudi.addEventListener("click",onClose);
    const p_chiudi=document.createElement("p");
    p_chiudi.textContent="X";
    chiudi.appendChild(p_chiudi);
    const info=document.createElement("div");
    info.classList.add("info");
    const h2=document.createElement("h2");
    h2.textContent=json.titolo;
    const p_descrizione=document.createElement("p");
    p_descrizione.textContent=json.descrizione;
    info.appendChild(h2);
    info.appendChild(p_descrizione);
    totale.appendChild(chiudi);
    totale.appendChild(info);
    const commenti=document.createElement("div");
    commenti.classList.add("commenti");
    for(let i=0;i<json.commenti.length;i++)
    {   
        const data=json.commenti[i];
        const commento=document.createElement("div");
        commento.classList.add("commento");
        const strong=document.createElement("strong");
        const p_commento=document.createElement("p");
        p_commento.textContent=data.commento;
        strong.textContent=data.mittente;
        commento.appendChild(strong);
        commento.appendChild(p_commento);
        commenti.appendChild(commento);
    }
    const nuovocommento=document.createElement("div");
    nuovocommento.classList.add("commento");
    nuovocommento.classList.add("nuovo");
    const strong_com=document.createElement("strong");
    strong_com.textContent="Nuovo commento:";
    const textarea=document.createElement("textarea");
    textarea.addEventListener("keyup",onEnter);
    nuovocommento.appendChild(strong_com);
    nuovocommento.appendChild(textarea);
    commenti.appendChild(nuovocommento);
    totale.appendChild(commenti);
    const somma=document.createElement("div");
    somma.setAttribute("id","totale");
    const p_somma=document.createElement("p");
    const strong_somma=document.createElement("strong");
    strong_somma.textContent="Totale: ";
    const em_somma=document.createElement("em");
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
    const target=event.currentTarget;
    target.textContent="✔";

    const link=target.closest(".articolo ").querySelector("a").href;
    const user=document.querySelector("a[href='Profilo.php']").textContent;
    fetch("InserimentoLocale.php?"+
    "&user="+encodeURIComponent(user)+
    "&link="+encodeURIComponent(link)).then(onResponse1,onError).then(onText1);
}
function onClick(event){
    const id=event.currentTarget.closest("section").dataset.num;
    carrelloAttuale=id;
    fetch("overlay.php?id="+id).then(onResponse,onError).then(onOverlay);
}
function onText(text)
{   
    console.log(text);
    if(text=="1")
    {
        // alert("commento inserito correttamente");
        onClose();

        fetch("overlay.php?id="+carrelloAttuale).then(onResponse,onError).then(onOverlay);
    }
}

function onEnter(event){
    if(event.which === 13){
        const commento=event.currentTarget.value;
        console.log(commento);
        fetch("aggiungiCommento.php?commento="+commento+
        "&carrello="+carrelloAttuale).then(onResponse1,onError).then(onText);
    }
}
function onAnnulla(event){
    event.preventDefault();
}

let carrelloAttuale;
const cerca=document.querySelector("nav form");
cerca.addEventListener("input",onSubmit)
cerca.addEventListener("submit",onAnnulla)
fetch("homedata.php").then(onResponse,onError).then(onJson);



//console.log(pulsanti);





