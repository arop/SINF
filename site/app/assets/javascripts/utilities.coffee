@getProductContainer = (product, img_path) ->
    if (img_path == null)
        img_path = 'http://placehold.it/800x500'
    return '<div class="col-md-3 col-sm-6 hero-feature product-in-grid">'+'<div class="thumbnail">'+'<img src="'+img_path+'" alt="Foto de '+product.DescArtigo+'">'+'<div class="caption">'+'<h4>'+product.DescArtigo+'</h4>'+'<h5>'+product.PVP+'€</h5>'+'<p>'+'<a href="/product/'+product.CodArtigo+'" class="btn btn-primary">More Info</a>'+'</p>'+'</div>'+'</div>'+'</div>'

@getProductContainer2 = (product, img_path) ->
    return '<div class="item  col-xs-12 col-sm-4 col-lg-4">
            <div class="thumbnail">
                <img class="group list-group-image" src="http://placehold.it/400x250/000/fff" alt="" />
                <div class="caption">
                    <a href="/product/'+product.CodArtigo+'"><h4 class="group inner list-group-item-heading">'+
                        product.DescArtigo+'</h4></a>
                    <div class="container-fluid">
                        <div class="row">
                            <div class="col-xs-12 col-md-6">
                                <p class="lead">'+
                                    product.PVP+'€</p>
                            </div>

                            <div class="col-xs-12 col-md-6">
                                <a class="btn btn-success" href="/carrinho/adicionar/'+product.CodArtigo+'/1">Add to cart</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>'

`
//<div class="col-xs-6">Quantidade:<input class="form-control" step="1" min="1" max="150" required="required" type="number" value="1"></div>
$(document).ready(function() {
    console.log('gg');
    $('#list').click(function(event){event.preventDefault();$('#artigos-container .item').removeClass('grid-group-item');$('#artigos-container .item').addClass('list-group-item');});
    $('#grid').click(function(event){event.preventDefault();$('#artigos-container .item').removeClass('list-group-item');$('#artigos-container .item').addClass('grid-group-item');});
});

$('body').bind("DOMSubtreeModified",function(){
    $('#list').click(function(event){event.preventDefault();$('#artigos-container .item').removeClass('grid-group-item');$('#artigos-container .item').addClass('list-group-item');});
    $('#grid').click(function(event){event.preventDefault();$('#artigos-container .item').removeClass('list-group-item');$('#artigos-container .item').addClass('grid-group-item');});
});


botao_load = '<button class="btn btn-lg btn-warning"><span class="glyphicon glyphicon-refresh glyphicon-refresh-animate"></span> A carregar...</button>';

var dateFormat = function () {
    var token = /d{1,4}|m{1,4}|yy(?:yy)?|([HhMsTt])\1?|[LloSZ]|"[^"]*"|'[^']*'/g,
        timezone = /\b(?:[PMCEA][SDP]T|(?:Pacific|Mountain|Central|Eastern|Atlantic) (?:Standard|Daylight|Prevailing) Time|(?:GMT|UTC)(?:[-+]\d{4})?)\b/g,
        timezoneClip = /[^-+\dA-Z]/g,
        pad = function (val, len) {
            val = String(val);
            len = len || 2;
            while (val.length < len) val = "0" + val;
            return val;
        };

    // Regexes and supporting functions are cached through closure
    return function (date, mask, utc) {
        var dF = dateFormat;

        // You can't provide utc if you skip other args (use the "UTC:" mask prefix)
        if (arguments.length == 1 && Object.prototype.toString.call(date) == "[object String]" && !/\d/.test(date)) {
            mask = date;
            date = undefined;
        }

        // Passing date through Date applies Date.parse, if necessary
        date = date ? new Date(date) : new Date;
        if (isNaN(date)) throw SyntaxError("invalid date");

        mask = String(dF.masks[mask] || mask || dF.masks["default"]);

        // Allow setting the utc argument via the mask
        if (mask.slice(0, 4) == "UTC:") {
            mask = mask.slice(4);
            utc = true;
        }

        var _ = utc ? "getUTC" : "get",
            d = date[_ + "Date"](),
            D = date[_ + "Day"](),
            m = date[_ + "Month"](),
            y = date[_ + "FullYear"](),
            H = date[_ + "Hours"](),
            M = date[_ + "Minutes"](),
            s = date[_ + "Seconds"](),
            L = date[_ + "Milliseconds"](),
            o = utc ? 0 : date.getTimezoneOffset(),
            flags = {
                d:    d,
                dd:   pad(d),
                ddd:  dF.i18n.dayNames[D],
                dddd: dF.i18n.dayNames[D + 7],
                m:    m + 1,
                mm:   pad(m + 1),
                mmm:  dF.i18n.monthNames[m],
                mmmm: dF.i18n.monthNames[m + 12],
                yy:   String(y).slice(2),
                yyyy: y,
                h:    H % 12 || 12,
                hh:   pad(H % 12 || 12),
                H:    H,
                HH:   pad(H),
                M:    M,
                MM:   pad(M),
                s:    s,
                ss:   pad(s),
                l:    pad(L, 3),
                L:    pad(L > 99 ? Math.round(L / 10) : L),
                t:    H < 12 ? "a"  : "p",
                tt:   H < 12 ? "am" : "pm",
                T:    H < 12 ? "A"  : "P",
                TT:   H < 12 ? "AM" : "PM",
                Z:    utc ? "UTC" : (String(date).match(timezone) || [""]).pop().replace(timezoneClip, ""),
                o:    (o > 0 ? "-" : "+") + pad(Math.floor(Math.abs(o) / 60) * 100 + Math.abs(o) % 60, 4),
                S:    ["th", "st", "nd", "rd"][d % 10 > 3 ? 0 : (d % 100 - d % 10 != 10) * d % 10]
            };

        return mask.replace(token, function ($0) {
            return $0 in flags ? flags[$0] : $0.slice(1, $0.length - 1);
        });
    };
}();

// Some common format strings
dateFormat.masks = {
    "default":      "ddd mmm dd yyyy HH:MM:ss",
    shortDate:      "m/d/yy",
    mediumDate:     "mmm d, yyyy",
    longDate:       "mmmm d, yyyy",
    fullDate:       "dddd, mmmm d, yyyy",
    shortTime:      "h:MM TT",
    mediumTime:     "h:MM:ss TT",
    longTime:       "h:MM:ss TT Z",
    isoDate:        "yyyy-mm-dd",
    isoTime:        "HH:MM:ss",
    isoDateTime:    "yyyy-mm-dd'T'HH:MM:ss",
    isoUtcDateTime: "UTC:yyyy-mm-dd'T'HH:MM:ss'Z'"
};

// Internationalization strings
dateFormat.i18n = {
    dayNames: [
        "Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat",
        "Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"
    ],
    monthNames: [
        "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec",
        "January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"
    ]
};

// For convenience...
Date.prototype.format = function (mask, utc) {
    return dateFormat(this, mask, utc);
};


/*function getProductContainer(product, img_path){
    if (img_path == null)
        img_path = 'http://placehold.it/800x500';

    return 
        '<div class="col-md-3 col-sm-6 hero-feature">'+
            '<div class="thumbnail">'+
                '<img src="'+img_path+'" alt="Foto de '+product.DescArtigo+'">'+
                '<div class="caption">'+
                    '<h4>'+product.DescArtigo+'</h4>'+
                    //'<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit.</p>'+
                    '<h5>'+product.PVP+'€</h5>'+
                    '<p>'+
                        //'<a href="/product/'+product.CodArtigo+'" class="btn btn-primary">Buy Now!</a>' + 
                        '<a href="/product/'+product.CodArtigo+'" class="btn btn-default">More Info</a>'+
                    '</p>'+
                '</div>'+
            '</div>'+
        '</div>';
}*/


`



