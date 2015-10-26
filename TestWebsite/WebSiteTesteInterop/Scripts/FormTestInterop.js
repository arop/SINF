var categorias = [];
var artigos = [];
var carrinho = [];
var clientes = [];
var cliente;

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
            //artigos = "erro";
        },

        success: function (msg) {
            if (msg) {
                //$('#info').html("Response: " + msg);
                var artigosTemp = $.parseJSON(msg);
                //$("#info").append("<form>")

                replaceForm("Escolher produtos");
                        
                //inserir produtos da categoria
                for (var i in artigosTemp) {
                    //$("#info").append("<p>"+artigo['CodArtigo']+"</p>");
                    $("#form1 input[type='submit']").before("<input type=\"checkbox\" name=\"prod_group[]\" value=\"" +
                        artigosTemp[i].CodArtigo + "\"/>" + artigosTemp[i].DescArtigo + " - " + artigosTemp[i].PVP + "<br />");
                    artigos[artigosTemp[i].CodArtigo] = artigosTemp[i];
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
                var clientesTemp = $.parseJSON(msg);


                replaceForm("Finalizar processo");

                for (var i in clientesTemp) {
                    $("#form1 input[type='submit']").before("<input type=\"radio\" name=\"cli_group[]\" value=\"" +
                        clientesTemp[i].CodCliente + "\"/>" + clientesTemp[i].CodCliente + " - " + clientesTemp[i].NomeCliente + "<br />");
                    clientes[clientesTemp[i].CodCliente] = clientesTemp[i];
                }

                //alterar texto do botao de submit
                $("input[type='submit']").attr("value", "Finalizar");

                //console.log(artigos);

                //nova acção no submit do form
                $("#form1").submit(function (e) {
                    e.preventDefault();

                    var selected = $("input[type='radio']:checked");
                    if (selected.length > 0) {
                        cliente = selected.val();
                            
                        enviarVenda();
                    }

                    console.log(carrinho);

                    //2 - mostrar novo form. inserir dados cliente, ou escolher cliente existente de lista (?) 
                    //para já acho que fica só escolher da lista

                    getListaClientes();

                });
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

function enviarVenda() {

    var linhasDocVenda = [];

    console.log("carrinho:");
    console.log(carrinho);

    console.log("Artigos:");
    console.log(artigos);

    for (var i in carrinho) {
        console.log("i: " + i + ", carrinho[i]: " + carrinho[i]);
        var artigo = artigos[carrinho[i]];
        var linhaDocVenda = [];
        linhaDocVenda['CodArtigo'] = artigo['CodArtigo'];
        //linhaDocVenda['DescArtigo'] = artigo['DescArtigo'];
        var quantidade = 1;
        linhaDocVenda['Quantidade'] = quantidade;
        //linhaDocVenda['Unidade'] = artigo['UnidadeBase'];
        linhaDocVenda['Desconto'] = 0;
        linhaDocVenda['PrecoUnitario'] = artigo['PVP'];

        //var preco = artigo['PVP'] * quantidade;

        //linhaDocVenda['TotalIliquido'] = preco;
        //linhaDocVenda['TotalLiquido'] = preco * 1.23; //assumit este IVA por default. ver dps o IVA real.

        linhasDocVenda.push(linhaDocVenda);
    }

    var docVenda = [];
    docVenda['LinhasDoc'] = linhasDocVenda;
    docVenda['Entidade'] = cliente['CodCliente'];
    docVenda['Serie'] = "TESTE_INTEROP";

    $.ajax({

        type: "POST",
        url: 'http://localhost:49526/api/docvenda',
        dataType: "json",
        crossDomain: true,

        data: JSON.stringify(docVenda),

        error: function (xhr, status, error) {
            console.log("Error: " + error);
        },

        success: function (msg) {
            if (msg) {

                clearForm();
                $("#form1 input[type='submit']").prepend("Created: " + msg);
            }
            else {
                console.log("msg not good in send docVenda")
            }

        }


    });

};

function replaceForm(buttonText) {
    $("#form1").remove();
    $("body").html("<form id=\"form1\" ><input type=\"submit\" value=\""+ buttonText +"\" /><form />");
}