function onResponse(response)
{
    return response.json();
}

function onError(error) 
{
    console.log( error);
}
function onResponse1(response)
{
    return response.text();
} 

function onText(text)
{
    console.log(text);
}
function onJson(json)
{ console.log(json);
    json.inline_shopping_result[0].price
    json.inline_shopping_result[0].title
    json.inline_shopping_result[0].thumbnail
    json.inline_shopping_result[0].link

    json.inline_shopping_result[0].source
}




fetch("Curl.php").then(onResponse1,onError).then(onText);