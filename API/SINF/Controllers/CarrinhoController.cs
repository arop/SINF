using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using SINF.Lib_Primavera.Model;
using System.Web.Script.Serialization;
using SINF.IP;


namespace SINF.Controllers
{
    public class CarrinhoController : ApiController
    {
        /**
         * este método devia ser GET, mas não consegui enviar ums lista por GET
         * por isso fica POST
         */
        [System.Web.Http.HttpPost]
        public HttpResponseMessage GetDetalheArtigosCarrinho(Carrinho id)
        {
            HttpContext.Current.Response.AddHeader("Access-Control-Allow-Origin", LocalhostIP.localhostIP());
            List<Artigo> produtos = Lib_Primavera.PriIntegration.GetArtigos(id);
            if (produtos == null)
            {
                return Request.CreateResponse(HttpStatusCode.Forbidden);
            }
            else
            {
                var json = new JavaScriptSerializer().Serialize(produtos);
                var response = Request.CreateResponse(HttpStatusCode.OK, json);
                return response;
            }
        }
    }
}
