$(document).ready(function () {
    var categorias = [];
    var artigos = [];

    
    $.ajax({
        type: "POST",
        url: 'http://localhost:49526/api/categorias',
        dataType: "json",
        crossDomain: true,

        error: function (xhr, status, error) {
            console.log("Error: " + error);
        },

        success: function (msg) {
            if (msg) {
                //$('#info').html("Response: " + msg);
                categorias = $.parseJSON(msg);
                for (var i in categorias) {
                    //$("#info").append("<p>"+artigo['CodArtigo']+"</p>");
                    $("#form1").append("<input type=\"radio\" name=\"cat_group[]\" value=\"" +
                        categorias[i].CodCategoria + "\"/>" + categorias[i].CodCategoria + " - " + categorias[i].DescCategoria + "<br />");
                }
                $("#form1").after($('<input type="button" value="Obter produtos">'));

            } else {
                console.log("msg not good");
            }
        }
    });

    $("#form1").submit(function () {
        
    });
    



    /*

    var sendInfo = '[{"CodArtigo":"A0001","DescArtigo":"Pentium D925 Dual Core"},{"CodArtigo":"A0002","DescArtigo":"Pentium 4 945+ Dual Core 3.4GHZ"}]';
    console.log("gg");

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

function getProductsOfCategory(codCat) {
    //get products of category

    var urlCat = 'http://localhost:49526/api/artigos/' + codCat;

    $.ajax({
        type: "POST",
        url: urlCat,
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
                    $("#form1").append("<input type=\"checkbox\" name=\"prod_group[]\" value=\"" +
                        artigos[i].CodArtigo + "\"/>" + artigos[i].DescArtigo + " - " + artigos[i].PVP + "<br />");
                }

            } else {
                console.log("msg not good");
            }
        },

        data: sendInfo
    });
}