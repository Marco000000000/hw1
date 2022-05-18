<?php
        $key="ce417edb81d59a18af5d57047479121f8ce525ce8324f93df1d59ec6c8480d2d";

        $url="https://serpapi.com/search.json?location=italy&engine=google&q=".$_COOKIE["prodotto"]."&tbm=shop&hl=it&gl=it&lr=it&google_domain=google.it&api_key=".$key;
         //andare al link e richiedere richiesta temporanea (https://cors-anywhere.herokuapp.com/corsdemo)
        $curl = curl_init();
        curl_setopt($curl, CURLOPT_URL, $url);
        curl_setopt($curl, CURLOPT_RETURNTRANSFER, 1);
        
        $result = curl_exec($curl);

        //print_r($result);
        curl_close($curl);
        echo $result;

       ?>