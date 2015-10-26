var categorias = [];
var artigos = null;
var carrinho = [];

$(document).ready(function () {
    
    
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
                console.log(msg);
                
                artigos = $.parseJSON(msg);
                clearForm();
                        
                //inserir produtos da categoria
                for (var i in artigos) {
                    //$("#info").append("<p>"+artigo['CodArtigo']+"</p>");
                    $("#form1 input[type='submit']").before("<input type=\"checkbox\" name=\"prod_group[]\" value=\"" +
                        artigos[i].CodArtigo + "\"/>" + artigos[i].DescArtigo + " - " + artigos[i].PVP + "€<br />");
                }

                //alterar texto do botao de submit
                $("input[type='submit']").attr("value", "Comprar");

                //console.log(artigos);

                //nova acção no submit do form
                $("#form1").submit(function (e) {
                    e.preventDefault();

                    //1 - guardar produtos escolhidos em array
                    $('#form1 input:checked').each(function () {
                        carrinho.push($(this).attr('value'));
                    });

                    console.log(carrinho);

                    //2 - mostrar novo form. inserir dados cliente, ou escolher cliente existente de lista (?) 
                    //para já acho que fica só escolher da lista

                    getListaClientes();

                });

            } else {
                console.log("msg not good");
            }
        }
    });
}

function getListaClientes() {
    $.ajax({
        type: "GET",
        url: 'http://localhost:49526/api/clientes',
        dataType: "json",
        crossDomain: true,

        error: function (xhr, status, error) {
            console.log("Error: " + error);
            artigos = "erro";
        },

        success: function (msg) {
            if (msg) {
                clientes = $.parseJSON(msg);

                clearForm();

                for (var i in clientes) {
                    //$("#info").append("<p>"+artigo['CodArtigo']+"</p>");
                    $("#form1 input[type='submit']").before("<input type=\"radio\" name=\"cli_group[]\" value=\"" +
                        clientes[i].CodCliente + "\"/>" + clientes[i].CodCliente + " - " + clientes[i].NomeCliente + "<br />");
                }
            }
            else {
                console.log("msg not good in get clientes")
            }

        }

    });

}


function clearForm() {
    //clear all elements in form, except the submit button
    $("#form1 input[type='radio']").remove(); //remover categorias/clientes
    $("#form1 input[type='checkbox']").remove(); //remover produtos
    $("#form1 br").remove();//remover breaks
    $("#form1").contents().filter(function () { //remover texto
        return this.nodeType === 3;
    }).remove();
}