
function controlloutente(event){
    let inserimento=utente.value;
    console.log(inserimento);

    if(inserimento.match("\W"))
        console.log("gg")
    else
    document.querySelector("#utente").classList.remove("hidden");
    event.preventDefault();

}

let utente=document.querySelector('input[name="utente"]');
console.log(utente);
document.querySelector('form').addEventListener("submit",controlloutente);
utente.addEventListener("submit",controlloutente);