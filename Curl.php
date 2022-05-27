<?php
        $key="6ba0804b4e289ee35b3b2b36ad31ac7464eb0ae17d5e0cdb1015454fd8bed479";
        session_start();
        $url="https://serpapi.com/search.json?location=italy&engine=google&q=".urlencode($_SESSION["cerca"])."&tbm=shop&hl=it&gl=it&lr=it&google_domain=google.it&api_key=".$key;
        $curl = curl_init();
        curl_setopt($curl, CURLOPT_URL, $url);
        curl_setopt($curl, CURLOPT_RETURNTRANSFER, 1);
        
        $result = curl_exec($curl);

        curl_close($curl);
        echo $result;

       ?>