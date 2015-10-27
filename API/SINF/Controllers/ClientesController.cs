using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using SINF.Lib_Primavera.Model;
using SINF.IP;
using System.Web.Script.Serialization;

namespace SINF.Controllers
{
    public class ClientesController : ApiController
    {
        //
        // GET: /Clientes/

        public HttpResponseMessage Get()
        {
            IEnumerable<Lib_Primavera.Model.Cliente> listaClientes = Lib_Primavera.PriIntegration.ListaClientes();

            if (listaClientes == null)
            {
                throw new HttpResponseException(
                  Request.CreateResponse(HttpStatusCode.Forbidden));
            }
            else
            {
                HttpContext.Current.Response.AddHeader("Access-Control-Allow-Origin", LocalhostIP.localhostIP());
                var json = new JavaScriptSerializer().Serialize(listaClientes);
                var response = Request.CreateResponse(HttpStatusCode.OK, json);
                return response;
            }
        }

        // GET api/cliente/5    
        public Cliente Get(string id)
        {
            Lib_Primavera.Model.Cliente cliente = Lib_Primavera.PriIntegration.GetCliente(id);
            if (cliente == null)
            {
                throw new HttpResponseException(
                        Request.CreateResponse(HttpStatusCode.NotFound));

            }
            else
            {
                return cliente;
            }
        }

        public HttpResponseMessage Post(Lib_Primavera.Model.Cliente cliente)
        {
            Lib_Primavera.Model.RespostaErro erro = new Lib_Primavera.Model.RespostaErro();
            erro = Lib_Primavera.PriIntegration.InsereClienteObj(cliente);

            if (erro.Erro == 0)
            {
                var response = Request.CreateResponse(
                   HttpStatusCode.Created, cliente);
                string uri = Url.Link("DefaultApi", new { CodCliente = cliente.CodCliente });
                response.Headers.Location = new Uri(uri);
                return response;
            }

            else
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest);
            }

        }

        public HttpResponseMessage Put(string id, Lib_Primavera.Model.Cliente cliente)
        {

            Lib_Primavera.Model.RespostaErro erro = new Lib_Primavera.Model.RespostaErro();

            try
            {
                erro = Lib_Primavera.PriIntegration.UpdCliente(cliente);
                if (erro.Erro == 0)
                {
                    return Request.CreateResponse(HttpStatusCode.OK, erro.Descricao);
                }
                else
                {
                    return Request.CreateResponse(HttpStatusCode.NotFound, erro.Descricao);
                }
            }

            catch (Exception exc)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, erro.Descricao);
            }
        }

        public HttpResponseMessage Delete(string id)
        {
            Lib_Primavera.Model.RespostaErro erro = new Lib_Primavera.Model.RespostaErro();

            try
            {

                erro = Lib_Primavera.PriIntegration.DelCliente(id);

                if (erro.Erro == 0)
                {
                    return Request.CreateResponse(HttpStatusCode.OK, erro.Descricao);
                }
                else
                {
                    return Request.CreateResponse(HttpStatusCode.NotFound, erro.Descricao);
                }

            }

            catch (Exception exc)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest, erro.Descricao);

            }

        }

        // get all orders
        // api/clientes/id/encomendas
        public HttpResponseMessage Get(string id, string encomendas)
        {
            Console.Write("entrou no bom");

            if (encomendas.Equals("encomendas"))
            {
                IEnumerable<Lib_Primavera.Model.DocVenda> listaEncomendas = Lib_Primavera.PriIntegration.Encomendas_List(id);

                if (listaEncomendas == null)
                {

                    //throw new HttpResponseException(
                    //Request.CreateResponse(HttpStatusCode.Forbidden));
                    HttpContext.Current.Response.AddHeader("Access-Control-Allow-Origin", LocalhostIP.localhostIP());
                    var response = Request.CreateResponse(HttpStatusCode.OK, "it worked");
                    return response;
                }
                else
                {
                    HttpContext.Current.Response.AddHeader("Access-Control-Allow-Origin", LocalhostIP.localhostIP());
                    var json = new JavaScriptSerializer().Serialize(listaEncomendas);
                    var response = Request.CreateResponse(HttpStatusCode.OK, json);
                    return response;
                }
            }
            else
            {   
                //throw new HttpResponseException(
                //  Request.CreateResponse(HttpStatusCode.Forbidden));
                HttpContext.Current.Response.AddHeader("Access-Control-Allow-Origin", LocalhostIP.localhostIP());
                var response1 = Request.CreateResponse(HttpStatusCode.OK, "forbidden");
                return response1;
            }
        }
    }
}
