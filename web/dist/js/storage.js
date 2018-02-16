function showNewStorage(u_id, name, type){
    var xhttp;
    if (u_id == "") {
        alert("Keine gültige User-ID")
        return;
    }
    xhttp = new XMLHttpRequest();
    xhttp.onreadystatechange = function() {
        if (this.readyState == 4 && this.status == 200) {
            document.getElementById("storage_display_container").innerHTML = this.responseText;
        }
    };
    xhttp.open("GET", "getstorage.jsp?q="+u_id, true);
    xhttp.send();
}