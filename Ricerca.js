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
    const results=json.shopping_results;
    const article=document.querySelector("article");
    article.innerHTML="";
    for(let i=0;i<results.length;i++)
    {
        const price=results[i].extracted_price+"€";
        const title=results[i].title;
        const thumbnail=results[i].thumbnail;
        const link=results[i].link;
        const source=results[i].source;
        
        
/*
        const select=document.createElement("select");
        select.name="quantita";*/
        const option1=document.createElement("option");
        option1.selected=true;
        const p_prezzo=document.createElement("p");
        p_prezzo.textContent=price;
       
        const div_prezzo=document.createElement("div");
        const div_oggetto_sottostante=document.createElement("div");
        const p_oggetto=document.createElement("p");
        p_oggetto.textContent=(title);
        const img=document.createElement("img");
        img.src=thumbnail;
        const a=document.createElement("a");
        const div_descrizione=document.createElement("div");
        const div_oggetto=document.createElement("div");
        const p_opzioni=document.createElement("p");
        p_opzioni.classList.add("carrello");
        p_opzioni.textContent=( "🛒");
        p_opzioni.addEventListener("click",onClick);

        const div_opzioni=document.createElement("div");
        const p_venditore=document.createElement("p");
        p_venditore.textContent=(source);
        const div_venditore=document.createElement("div");
        const div_header=document.createElement("div");
        const section=document.createElement("section");
        const div_divisore=document.createElement("div");
         
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
{   const target=event.currentTarget;
    target.textContent="✔";
    const prezzo=target.closest(".articolo ").querySelector(".prezzo p").textContent;
    const descrizione=target.closest(".articolo ").querySelector(".descrizione  div p").textContent;
    const venditore=target.closest(".articolo ").querySelector(".venditore p").textContent;
    const img=target.closest(".articolo ").querySelector("img").src;
    const link=target.closest(".articolo ").querySelector("a").href;
    const user=document.querySelector("a[href='Profilo.php']").textContent;
    fetch("InserimentoCarrello.php?"+"prezzo="+prezzo+"&descrizione="+descrizione+
    "&venditore="+venditore+
    "&img="+encodeURIComponent(img)+
    "&user="+encodeURIComponent(user)+
    "&link="+encodeURIComponent(link)).then(onResponse1,onError).then(onText);
    //closest("div")

}

fetch("Curl.php").then(onResponse,onError).then(onJson);


