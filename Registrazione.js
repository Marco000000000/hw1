function onResponse1(response)
{
    return response.text();
}
function onText1(text)
{
    console.log(text);
    if(text==1)
    {
        window.location.replace("home.php");
    }
    else
    {
        document.querySelector("#errore_registrato").classList.remove("hidden");
    }
}
function contains(str,chars) {
    console.log([str,chars]);
    for(let i=0;i<chars.length;i++)
    {   
        if(str.includes(chars[i]))
        {
            return true
        }
    }
    return false;
  }


function controlloutente(event){
    const specialChars = "/ [`!@#$%^&*()_+\-=\[\]{};':\"\\|,.<>\/?~]/;"
    const num="0123456789";
    const letters="abcdefghijklmnopqrstuvwxyz";
    const inserimentoUtente=utente.value;
    const inserimentoPassword=password.value;
    const inserimentoConferma=conferma.value;
    const inserimentoEmail=email.value;
    const errori= [document.querySelector("#errore_utente"),document.querySelector("#errore_password"),document.querySelector("#errore_conferma"),document.querySelector("#errore_lunghezza"),document.querySelector("#errore_registrato")];
    event.preventDefault();
    for(let i=0;i<errori.length;i++)
    {
        if(!errori[i].classList.contains("hidden"))
        {
            errori[i].classList.add("hidden");
        }
    }
    console.log(inserimentoUtente);
    
    if(contains(inserimentoUtente,specialChars))
    {
    errori[0].classList.remove("hidden");
    return;
    }
    if((!contains(inserimentoPassword,num))||(!contains(inserimentoPassword.toLowerCase(),letters)))
    {
    errori[1].classList.remove("hidden");
    return;
    }

    if(inserimentoPassword!=inserimentoConferma)
    {
    errori[2].classList.remove("hidden");
    return;
    }
    if(inserimentoUtente.length>20||inserimentoPassword.length>30||inserimentoEmail.length>50)
    {
        errori[3].classList.remove("hidden");
        
        return; 
    }
    
    fetch("Validazione.php?utente="+encodeURIComponent(inserimentoUtente)+
    "&password="+encodeURIComponent(inserimentoPassword)+
    "&email="+encodeURIComponent(inserimentoEmail)).then(onResponse1).then(onText1);

    




}

let utente=document.querySelector('input[name="utente"]');
let password=document.querySelector('input[name="password"]')
let email=document.querySelector('input[name="email"]')
let conferma=document.querySelector('#conferma')
console.log(utente);
document.querySelector('form').addEventListener("submit",controlloutente);
