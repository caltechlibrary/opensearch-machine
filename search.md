
# Project Search

<link href="./pagefind/pagefind-ui.css" rel="stylesheet">

<script src="./pagefind/pagefind-ui.js" type="text/javascript"></script>

<div id="search"></div>

<script>
    window.addEventListener('DOMContentLoaded', (event) => {
        new PagefindUI({ 
            element: "#search",
            baseUrl: "https://caltechlibrary.github.io/opensearch-machine/"
        });
    });
</script>



