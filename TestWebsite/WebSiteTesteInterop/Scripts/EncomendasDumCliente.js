var cliente; //cliente escolhido
var clientes = []; //todos os clientes
var encomendas = []; //todas as encomendas
var codigoCliente;

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
                        codigoCliente = selected.val();
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
    getEncomendasDoCliente();
}

function getEncomendasDoCliente() {
    $.ajax({
        type: "GET",
        url: 'http://localhost:49526/api/clientes/' + codigoCliente + '/encomendas',
        dataType: "json",
        crossDomain: true,

        error: function (xhr, status, error) {
            console.log("Error: " + error);
            artigos = "erro";
        },

        success: function (msg) {
            if (msg) {
                var encomendasTemp = $.parseJSON(msg);
                $('#ordersTable').remove();

                if (encomendasTemp.length > 0) {
                    // id, Entidade, Data, NumDoc, TotalMerc, Serie
                    $("#ordersFromClientForm").after("<table border='1' id='ordersTable'> <tr> " +
                        "<th> ID </th> <th> Entidade </th> <th> Data </th> <th> NumDoc </th> <th> TotalMerc </th> <th> Serie </th> </tr></table>")

                    for (var i in encomendasTemp) {
                        var dateTemp = encomendasTemp[i].Data;
                        dateTemp = dateTemp.substr(6);

                        var dateTemp1 = new Date(parseInt(dateTemp));

                        var day = dateTemp1.getDate();
                        var monthIndex = dateTemp1.getMonth() + 1;
                        var year = dateTemp1.getFullYear();
                        var date = day + "-" + monthIndex + "-" + year;

                        $("#ordersTable").append("<tr><td>" + encomendasTemp[i].id + "</td><td>" + encomendasTemp[i].Entidade + "</td><td>"
                            + date + "</td><td>" + encomendasTemp[i].NumDoc + "</td><td>" + encomendasTemp[i].TotalMerc + "</td><td>" + encomendasTemp[i].Serie + "</td></tr>");
                        encomendas[encomendasTemp[i].id] = encomendasTemp[i];
                    }
                }
                else $("#ordersFromClientForm").after("<div id='ordersTable'> Nao possuir compras efetuadas! </div>");
            }
        }
    });
}