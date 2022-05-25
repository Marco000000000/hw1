function onSubmit(event)
{   event.preventDefault();
    const form=event.currentTarget;
    console.log(form);
    const opzione=document.querySelector("div.selected").id;
    console.log(opzione);
    const input=form.querySelector("input");
    console.log(input.value);
    fetch("profiloData.php?cerca="+input.value+
    "&opzione="+opzione).then(onResponse,onError).then(onJson);
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
function onEnter(event){
    if(event.which === 13){
        const commento=event.currentTarget.value;
        console.log(commento);
        fetch("aggiungiCommento.php?commento="+commento+
        "&carrello="+carrelloAttuale).then(onResponse1,onError).then(onText2);
    }
}

function onClose()
{
    const div=document.querySelector(".fixed-content");
    div.remove();
    document.querySelector(".stop").classList.remove("stop");

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
    {   data=json[i];
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
function onClick(event){
    const id=event.currentTarget.closest("section").dataset.num;
    carrelloAttuale=id;
    fetch("overlay.php?id="+id).then(onResponse,onError).then(onOverlay);
}
function onError(error) 
{
    console.log('Error: ' + error);
}
function onSession(event)
{
    window.sessionStorage.setItem("profilo",event.currentTarget.dataset.profilo);
}  

function onJson(json)
{   console.log(json);
    if(json==0)
        return;
    const immagine=document.querySelector("form img");
     username=document.querySelector(".dati h1");
    const controllo_profilo=document.querySelector("a[href='Profilo.php']");
     const follower=document.querySelector(".segui p");
    const button=document.querySelector(".segui button");
    const article=document.querySelector("article");
    article.innerHTML="";
    
    follower.textContent=json.follower+" seguaci";
    username.textContent=json.username;
    if(json.imgProfilo!=null)
    {
        immagine.src=json.imgProfilo;
        imgsrc=json.imgProfilo;
    }
        
    else{
        imgsrc="images/profilo-vuoto.png";
        immagine.src="images/profilo-vuoto.png";
    }
        
    if(user!=json.username||controllo_profilo.textContent!=user)
    {   if(input!=null)
           { img.removeEventListener("mouseover",onHover);
            input.remove();
    }
    button.classList.remove("hidden");
    }
    else{
        button.classList.add("hidden");
    }

    if(json.followed)
    {
        button.classList.add("selected");
    }
    else{
        
        button.classList.remove("selected");
    }
    
    for(let i=0;i<json.length;i++ )
    {   const data=json[i];
        const section=document.createElement("section");
        section.dataset.num=data.carrello;
        const header=document.createElement("div");
        header.classList.add("header");
        const condivisore=document.createElement("div");
        condivisore.classList.add("condivisore");
        const link=document.createElement("a");
        link.dataset.profilo=data.proprietario;
        link.href="Profilo.php";
        link.addEventListener("click",onSession);
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
        link.appendChild(immagineProfilo);
        condivisore.appendChild(link);
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
    return response.json();
}
function onResponse1(response)
{
    return response.text();
}
function onText1(text)
{
    console.log(text);
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
function onText2(text)
{   
    console.log(text);
    if(text=="1")
    {
        // alert("commento inserito correttamente");
        onClose();

        fetch("overlay.php?id="+carrelloAttuale).then(onResponse,onError).then(onOverlay);
    }
}

function uploadFile(event) {

    const files = event.currentTarget.files;
 
    if(files.length > 0 ){
 
        const formData = new FormData();
       formData.append("file", files[0]);
 
 

        fetch("uploadPhoto.php",{
            method:"post",
            body:formData
        }).then(onResponse1).then(onText);

 
    }else{
       alert("Please select a file");
    }
 
 }

function onSelect(event){

    pub.classList.remove("selected");
    like.classList.remove("selected");
    follow.classList.remove("selected");

    event.currentTarget.classList.add("selected");
    opzioni=event.currentTarget.id;
    fetch("profiloData.php?cerca="+username.textContent+
    "&opzione="+opzioni).then(onResponse,onError).then(onJson);
}
function onButtonClick(event)
{       const follower=document.querySelector(".segui p");
    
    const button=event.currentTarget;
    const seguito=button.closest(".profilo").querySelector(".dati h1").textContent;
    if(!button.classList.contains("selected"))
    { 
    follower.textContent=(parseInt(follower.textContent)+1)+" seguaci";
        button.classList.add("selected");
        fetch("cambiaFollow.php?seguito="+seguito).then(onResponse,onError).then(onText1);
    }
    else{
        follower.textContent=(parseInt(follower.textContent)-1)+" seguaci";
        button.classList.remove("selected")
        fetch("cambiaFollow.php?seguito="+seguito).then(onResponse,onError).then(onText1);

    }

}
function onAnnulla(event){
    event.preventDefault();
}


let carrelloAttuale;
const cerca=document.querySelector("nav form");
cerca.addEventListener("input",onSubmit)
cerca.addEventListener("submit",onAnnulla)
const pub=document.querySelector("#pub");
const like=document.querySelector("#like");
const button=document.querySelector("Button");
button.addEventListener("click",onButtonClick)
const follow=document.querySelector("#follow");
pub.addEventListener("click",onSelect);
like.addEventListener("click",onSelect);
follow.addEventListener("click",onSelect);

const input=document.querySelector("input[name=foto]");
input.addEventListener("input",uploadFile);
const img=document.querySelector(".profilo img");
let imgsrc=img.src;
img.addEventListener("mouseover",onHover);
let user;
if(window.sessionStorage.getItem("profilo")!=null)
{
     user=window.sessionStorage.getItem("profilo");
    window.sessionStorage.removeItem("profilo");

}
else
{
     user=document.querySelector("a[href='Profilo.php']").textContent;

}

let username;
fetch("profiloData.php?cerca="+user+
    "&opzione=pub").then(onResponse,onError).then(onJson);

