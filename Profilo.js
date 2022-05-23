function onSubmit(event)
{   event.preventDefault();
    let form=event.currentTarget;
    console.log(form);
    let opzione=document.querySelector("div.selected").id;
    console.log(opzione);
    let input=form.querySelector("input");
    console.log(input.value);
    fetch("profiloData.php?cerca="+input.value+
    "&opzione="+opzione).then(onResponse,onError).then(onJson);
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
function onEnter(event){
    if(event.which === 13){
        let commento=event.currentTarget.value;
        console.log(commento);
        fetch("aggiungiCommento.php?commento="+commento+
        "&carrello="+carrelloAttuale).then(onResponse1,onError).then(onText);
    }
}

function onClose()
{
    let div=document.querySelector(".fixed-content");
    div.remove();
    document.querySelector(".stop").classList.remove("stop");

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
    {   data=json[i];
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
        p_opzioni.addEventListener("click",onCarrello);
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
    let strong_com=document.createElement("strong");
    strong_com.textContent="Nuovo commento:";
    let textarea=document.createElement("textarea");
    textarea.addEventListener("keyup",onEnter);
    nuovocommento.appendChild(strong_com);
    nuovocommento.appendChild(textarea);
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
function onClick(event){
    let id=event.currentTarget.closest("section").dataset.num;
    carrelloAttuale=id;
    fetch("overlay.php?id="+id).then(onResponse,onError).then(onOverlay);
}
function onError(error) 
{
    console.log('Error: ' + error);
}
   
function onJson(json)
{   console.log(json);
    
    let immagine=document.querySelector("form img");
     username=document.querySelector(".dati h1");

    let follower=document.querySelector(".segui p");
    let button=document.querySelector(".segui button");
    let article=document.querySelector("article");
    article.innerHTML="";
    imgsrc=json.imgProfilo;
    follower.textContent=json.follower+" seguaci";
    username.textContent=json.username;
    immagine.src=json.imgProfilo;
    if(user!=json.username)
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
        hearth.addEventListener("click",onLike);
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

function uploadFile(event) {

    let files = event.currentTarget.files;
 
    if(files.length > 0 ){
 
       let formData = new FormData();
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
{       let follower=document.querySelector(".segui p");
    
    let button=event.currentTarget;
    let seguito=button.closest(".profilo").querySelector(".dati h1").textContent;
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
let cerca=document.querySelector("nav form");

console.log(cerca);
cerca.addEventListener("submit",onSubmit);
let pub=document.querySelector("#pub");
let like=document.querySelector("#like");
let button=document.querySelector("Button");
button.addEventListener("click",onButtonClick)
let follow=document.querySelector("#follow");
pub.addEventListener("click",onSelect);
like.addEventListener("click",onSelect);
follow.addEventListener("click",onSelect);

let input=document.querySelector("input[name=foto]");
input.addEventListener("input",uploadFile);
let img=document.querySelector(".profilo img");
let imgsrc=img.src;
img.addEventListener("mouseover",onHover);
let user=document.querySelector("a[href='Profilo.php']").textContent;

let username;
fetch("profiloData.php?cerca="+user+
    "&opzione=pub").then(onResponse,onError).then(onJson);

