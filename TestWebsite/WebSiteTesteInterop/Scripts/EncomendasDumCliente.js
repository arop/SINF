var cliente; //cliente escolhido
var clientes = []; //todos os clientes
var encomendas = []; //todas as encomendas

$(document).ready(function () {
    getListaClientes();
});

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
                //get clientes
                var clientesTemp = $.parseJSON(msg);

                $('#loadingClientsMsg').remove();

                //show clientes on form
                for (var i in clientesTemp) {
                    $("#ordersFromClientForm input[type='submit']").before("<input type=\"radio\" name=\"cli_group[]\" value=\"" +
                        clientesTemp[i].CodCliente + "\"/>" + clientesTemp[i].CodCliente + " - " + clientesTemp[i].NomeCliente + "<br />");
                    clientes[clientesTemp[i].CodCliente] = clientesTemp[i];
                }

                $("#ordersFromClientForm").submit(function (e) {
                    e.preventDefault();

                    var selected = $("input[type='radio']:checked");
                    if (selected.length > 0) {
                        cliente = clientes[selected.val()];
                    }

                    //apos escolher cliente, mostrar as suas orders
                    showEncomendasDoCliente();
                });
            }
            else {
                console.log("msg not good in get clientes")
            }
        }
    });

}

function showEncomendasDoCliente() {
    //$("#ordersFromClientForm").html("hello");
    getEncomendasDoCliente();
}

function getEncomendasDoCliente() {
    $.ajax({
        type: "GET",
        url: 'http://localhost:49526/api/clientes/' + cliente.CodCliente + '/encomendas',
        dataType: "json",
        crossDomain: true,

        error: function (xhr, status, error) {
            console.log("Error: " + error);
            artigos = "erro";
        },

        success: function (msg) {
            if (msg) {
                var encomendasTemp = $.parseJSON(msg);
                // id, Entidade, Data, NumDoc, TotalMerc, Serie
                for (var i in encomendasTemp) {
                    $("#ordersFromClientForm").after("<div>" + encomendasTemp[i].id + " - " + encomendasTemp[i].Entidade + "-"
                        + encomendasTemp[i].Data + "-" + encomendasTemp[i].NumDoc + "-" + encomendasTemp[i].TotalMerc + "-" + encomendasTemp[i].Serie + "<div/>");
                    encomendas[encomendasTemp[i].id] = encomendasTemp[i];
                }
            }
        }
    });
}