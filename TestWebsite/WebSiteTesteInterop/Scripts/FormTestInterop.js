$(document).ready(function () {
    var artigos = [];

    var sendInfo = '[{"CodArtigo":"A0001","DescArtigo":"Pentium D925 Dual Core"},{"CodArtigo":"A0002","DescArtigo":"Pentium 4 945+ Dual Core 3.4GHZ"}]';
    console.log("gg");

    //get products of category
    $.ajax({
        type: "POST",
        url: 'http://localhost:49526/api/artigos/H01',
        dataType: "json",
        crossDomain: true,

        error: function (xhr, status, error) {
            console.log("Error: " + error);
        },

        success: function (msg) {
            if (msg) {
                //$('#info').html("Response: " + msg);
                artigos = $.parseJSON(msg);
                $("#info").append("<form>")
                for (var i in artigos) {
                    //$("#info").append("<p>"+artigo['CodArtigo']+"</p>");
                    $("#form1").append("<input type=\"checkbox\" name=\"prod_group[]\" value=\""+
                        artigos[i].CodArtigo + "\"/>" + artigos[i].DescArtigo + " - " + artigos[i].PVP + "<br />");
                }

            } else {
                console.log("msg not good");
            }
        },

        data: sendInfo
    });



    /*
    $.ajax({
        type: "POST",
        url: 'http://localhost:49526/api/venda',
        dataType: "json",
        crossDomain: true,

        error: function (xhr, status, error) {
            console.log("Error: " + error);
        },

        success: function (msg) {
            if (msg) {
                $('#info').html("Response: " + msg);                 
            } else {
                console.log("msg not good");
            }
        },

        data: sendInfo
    });*/


});