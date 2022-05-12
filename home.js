function onResponse(response)
{
    return response.json();
}

function onError(error) 
{
    console.log('Error: ' + error);
}
   

function onJson(json)
{ console.log(json.inline_shopping_result[0].price)
    json.inline_shopping_result[0].title
    json.inline_shopping_result[0].thumbnail
    json.inline_shopping_result[0].link
    json.inline_shopping_result[0].link
    json.inline_shopping_result[0].source
}

function onResponse1(response)
{
    return response.text();
}
function onHtml(html)
{
    console.log(html);
    document.querySelector("article").innerHTML=html;
    console.log(document.querySelectorAll(".s-item__image-img"));
    console.log(document.querySelectorAll(".s-item__price"));

    
}


let key="ce417edb81d59a18af5d57047479121f8ce525ce8324f93df1d59ec6c8480d2d";
//https://cse.google.com/cse.js?cx=84d2e71cf8b11ad53
//let key="AIzaSyCBXoKNhUv3bVvUI4Pi1ilIGp5j7IsnVIQ";
//let url = 'https://www.googleapis.com/customsearch/v1?key='+key+'&cx=a12bc6b3761a14bdb&q=arduino';
url="https://serpapi.com/search.json?engine=google&q=arduino&tbm=shop&hl=it&gl=it&lr=it&google_domain=google.it&api_key="+key
let proxyUrl = "https://cors-anywhere.herokuapp.com/";
url1="https://www.bing.com/shop?q=arduino&qs=n&form=SHOPSB&sp=-1&pq=ardui&sc=8-5&sk=&cvid=44233F6F927D417E856A06B4E4F869C2"
id="marcofin-Pubblici-PRD-b6688d70a-c335bcb9";
url2="https://svcs.ebay.com/services/search/FindingService/v1?OPERATION-NAME=findItemsByKeywords&SERVICE-VERSION=1.0.0&SECURITY-APPNAME="+id+"&RESPONSE-DATA-FORMAT=JSON&REST-PAYLOAD&sortOrder=PricePlusShippingLowest&keywords=arduino"

//fetch(proxyUrl+url).then(onResponse,onError).then(onJson);
//fetch(proxyUrl+url1).then(onResponse1,onError).then(onHtml);









