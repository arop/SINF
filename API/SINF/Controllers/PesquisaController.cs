using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using SINF.Lib_Primavera.Model;
using System.Web.Script.Serialization;
using SINF.IP;

namespace SINF.Controllers
{
    public class PesquisaController : ApiController
    {

        [ActionName("artigos")]
        [System.Web.Http.HttpGet]
        public HttpResponseMessage Artigos(string id)
        {
            List<Artigo> resultado = Lib_Primavera.PriIntegration.ProcurarArtigos(id);
            if (resultado == null)
            {
                throw new HttpResponseException(
                  Request.CreateResponse(HttpStatusCode.Forbidden));
            }
            else
            {
                HttpContext.Current.Response.AddHeader("Access-Control-Allow-Origin", LocalhostIP.localhostIP());
                var json = new JavaScriptSerializer().Serialize(resultado);
                var response = Request.CreateResponse(HttpStatusCode.OK, json);
                return response;
            }
        }

    }
}
