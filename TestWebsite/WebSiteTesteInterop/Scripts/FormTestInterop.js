$(document).ready(function () {

    var sendInfo = '[{"CodArtigo":"A0001","DescArtigo":"Pentium D925 Dual Core"},{"CodArtigo":"A0002","DescArtigo":"Pentium 4 945+ Dual Core 3.4GHZ"}]';
    console.log("gg");

    $.ajax({
        type: "POST",
        url: 'http://localhost:49526/api/venda?callback=?',
        dataType: "jsonp",
        error: function(xhr, status, error) {
            var err = eval("(" + xhr.responseText + ")");
            $('#info').html(err);
            console.log(err);
            console.log("xhr status: " + xhr.status);
            console.log("thrownError: " + error);
            console.log("error");
        },
        success: function (msg) {
            if (msg) {
                $('#info').html(msg);
                console.log("adwd");
            } else {
                console.log("else");
            }
        },
        data: sendInfo
    });


});