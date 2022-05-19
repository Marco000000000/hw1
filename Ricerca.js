function onResponse(response)
{
    return response.json();
}
function onResponse1(response)
{
    return response.text();
}

function onError(error) 
{
    console.log( error);
}


function onJson(json)
{ console.log(json);
    let article=document.querySelector("article");
    article.innerHTML="";
    for(let i=0;i<json.inline_shopping_results.length;i++)
    {
        let price=json.inline_shopping_results[i].extracted_price+"€";
        let title=json.inline_shopping_results[i].title;
        let thumbnail=json.inline_shopping_results[i].thumbnail;
        let link=json.inline_shopping_results[i].link;
        let source=json.inline_shopping_results[i].source;
        
        
/*
        let select=document.createElement("select");
        select.name="quantita";*/
        let option1=document.createElement("option");
        option1.selected=true;
        let p_prezzo=document.createElement("p");
        p_prezzo.textContent=price;
       
        let div_prezzo=document.createElement("div");
        let div_oggetto_sottostante=document.createElement("div");
        let p_oggetto=document.createElement("p");
        p_oggetto.textContent=(title);
        let img=document.createElement("img");
        img.src=thumbnail;
        let a=document.createElement("a");
        let div_descrizione=document.createElement("div");
        let div_oggetto=document.createElement("div");
        let p_opzioni=document.createElement("p");
        p_opzioni.classList.add("carrello");
        p_opzioni.textContent=( "🛒");
        p_opzioni.addEventListener("click",onClick);

        let div_opzioni=document.createElement("div");
        let p_venditore=document.createElement("p");
        p_venditore.textContent=(source);
        let div_venditore=document.createElement("div");
        let div_header=document.createElement("div");
        let section=document.createElement("section");
        let div_divisore=document.createElement("div");
         
        div_prezzo.classList.add("prezzo");
       
        div_prezzo.appendChild(p_prezzo);

        div_oggetto_sottostante.appendChild(p_oggetto);
        
        a.href=link;
        a.target="_blank";
        a.appendChild(img);

        div_descrizione.classList.add("descrizione");
        div_descrizione.appendChild(a);
        div_descrizione.appendChild(div_oggetto_sottostante);

        div_oggetto.classList.add("oggetto");
        div_oggetto.appendChild(div_descrizione);
        div_oggetto.appendChild(div_prezzo);

        div_opzioni.classList.add("opzioni");
        div_opzioni.appendChild(p_opzioni);

        div_venditore.classList.add("venditore");
        div_venditore.appendChild(p_venditore);

        div_header.classList.add("header");
        div_header.appendChild(div_venditore);
        div_header.appendChild(div_opzioni);
        
        section.classList.add("articolo");
        section.appendChild(div_header);
        section.appendChild(div_oggetto);

        div_divisore.classList.add("divisore");
        div_divisore.appendChild(section);
        article.appendChild(div_divisore);
    }
}
function onText(text)
{
console.log(text);
}

function onClick(event)
{   let target=event.currentTarget;
    target.textContent="✅";
    let prezzo=target.closest(".articolo ").querySelector(".prezzo p").textContent;
    let descrizione=target.closest(".articolo ").querySelector(".descrizione  div p").textContent;
    let venditore=target.closest(".articolo ").querySelector(".venditore p").textContent;
    let img=target.closest(".articolo ").querySelector("img").src;
    let link=target.closest(".articolo ").querySelector("a").href;
    let user=document.querySelector("a[href='Profilo.php']").textContent;
    fetch("InserimentoCarrello.php?"+"prezzo="+prezzo+"&descrizione="+descrizione+
    "&venditore="+venditore+
    "&img="+encodeURIComponent(img)+
    "&user="+encodeURIComponent(user)+
    "&link="+encodeURIComponent(link)).then(onResponse1,onError).then(onText);
    //closest("div")

}

fetch("Curl.php").then(onResponse,onError).then(onJson);


