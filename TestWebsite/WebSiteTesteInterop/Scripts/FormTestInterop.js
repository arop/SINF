$(document).ready(function () {
    var categorias = [];
    var artigos = null;

    
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
                    $("#form1 input[type='submit']").before("<input type=\"radio\" name=\"cat_group[]\" value=\"" +
                        categorias[i].CodCategoria + "\"/>" + categorias[i].CodCategoria + " - " + categorias[i].DescCategoria + "<br />");
                }

            } else {
                console.log("msg not good");
            }
        }
    });

    $("#form1").submit(function (e) {
        e.preventDefault();
        console.log("submiting form?");
        var selected = $("input[type='radio']:checked");
        if (selected.length > 0) {
            selectedCategory = selected.val();
            getProductsOfCategory(selectedCategory);
        }
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

    var urlCat = 'http://localhost:49526/api/artigos/categoria/' + codCat;
    console.log(urlCat);

    $.ajax({
        type: "POST",
        url: urlCat,
        dataType: "json",
        crossDomain: true,

        error: function (xhr, status, error) {
            console.log("Error: " + error);
            artigos = "erro";
        },

        success: function (msg) {
            if (msg) {
                //$('#info').html("Response: " + msg);
                artigos = $.parseJSON(msg);
                //$("#info").append("<form>")
                $("#form1 input[type='radio']").remove();
                for (var i in artigos) {
                    //$("#info").append("<p>"+artigo['CodArtigo']+"</p>");
                    $("#form1 input[type='submit']").before("<input type=\"checkbox\" name=\"prod_group[]\" value=\"" +
                        artigos[i].CodArtigo + "\"/>" + artigos[i].DescArtigo + " - " + artigos[i].PVP + "<br />");
                }

                console.log(artigos);

            } else {
                console.log("msg not good");
                artigos = "erro";
            }
        }
    });
}