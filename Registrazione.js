
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
    const specialChars = "/[`!@#$%^&*()_+\-=\[\]{};':\"\\|,.<>\/?~]/;"
    const num="0123456789";
    const letters="abcdefghijklmnopqrstuvwxyz";
    let inserimentoUtente=utente.value;
    let inserimentoPassword=password.value;
    let inserimentoConferma=conferma.value;
    const errori= [document.querySelector("#errore_utente"),document.querySelector("#errore_password"),document.querySelector("#errore_conferma")];
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
    event.preventDefault();
    }
    if((!contains(inserimentoPassword.toLowerCase(),num))||(!contains(inserimentoPassword.toLowerCase(),letters)))
    {
    errori[1].classList.remove("hidden");
    event.preventDefault();
    }

    if(inserimentoPassword!=inserimentoConferma)
    {
    errori[2].classList.remove("hidden");
    event.preventDefault();
    }


    




}

let utente=document.querySelector('input[name="utente"]');
let password=document.querySelector('input[name="password"]')
let conferma=document.querySelector('#conferma')
console.log(utente);
document.querySelector('form').addEventListener("submit",controlloutente);
