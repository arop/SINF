using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Web.Script.Serialization;
using SINF.IP;

namespace SINF.Controllers
{
    public class VendaController : ApiController
    {
        //
        // GET: /Venda/

        public IEnumerable<Lib_Primavera.Model.Cliente> Get()
        {
            return null;
        }


        //http://localhost:49526/api/venda
        /*public HttpResponseMessage Post(Lib_Primavera.Model.DocVenda docVenda)
        {
            HttpContext.Current.Response.AddHeader("Access-Control-Allow-Origin", LocalhostIP.localhostIP());
            Lib_Primavera.Model.RespostaErro erro = Lib_Primavera.PriIntegration.Encomendas_New(docVenda);

            //erro = Lib_Primavera.PriIntegration.InsereClienteObj(artigos);
                       
            if (erro.Erro == 0)
            {
                var response = Request.CreateResponse(HttpStatusCode.Created);
                string uri = Url.Link("DefaultApi", );
                response.Headers.Location = new Uri(uri);
                return response;
            }

            else
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest);
            }
           
        }
        */
    }
}
