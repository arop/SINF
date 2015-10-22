using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Net;
using System.Net.Http;
using System.Web.Http;

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
        //fazer post enviando este json (responde com numero de produtos no array)
        //[{"CodArtigo":"A0001","DescArtigo":"Pentium D925 Dual Core"},{"CodArtigo":"A0002","DescArtigo":"Pentium 4 945+ Dual Core 3.4GHZ"}]
        public HttpResponseMessage Post(List<Lib_Primavera.Model.Artigo> artigos)
        {
            Lib_Primavera.Model.RespostaErro erro = new Lib_Primavera.Model.RespostaErro();

            Console.WriteLine("asdfghjkl");

            //erro = Lib_Primavera.PriIntegration.InsereClienteObj(artigos);

            /*
            if (erro.Erro == 0)
            {
                var response = Request.CreateResponse(
                   HttpStatusCode.Created, artigos);
                string uri = Url.Link("DefaultApi", new { CodCliente = artigos.CodCliente });
                response.Headers.Location = new Uri(uri);
                return response;
            }

            else
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest);
            }
            */

            //var response = Request.CreateResponse(HttpStatusCode.OK, artigos.Count);
            var response = Request.CreateResponse(HttpStatusCode.OK, "[{\"CodArtigo\":\"A0001\",\"DescArtigo\":\"Pentium D925 Dual Core\"}]");

            return response;

        }

    }
}
