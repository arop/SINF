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


namespace SINF.Controllers
{
    public class CategoriasController : ApiController
    {
        //
        // GET: /categorias/
        public HttpResponseMessage Post()
        {
            HttpContext.Current.Response.AddHeader("Access-Control-Allow-Origin", "http://localhost:49192");
            var json = new JavaScriptSerializer().Serialize(Lib_Primavera.PriIntegration.ListaCategorias());
            var response = Request.CreateResponse(HttpStatusCode.OK, json);
            return response;
        }


        // GET api/categorias/H01   
        /*public HttpResponseMessage Get(string id)
        {
            Categoria categoria = Lib_Primavera.PriIntegration.GetCategoria(id);
            if (categoria == null)
            {
                throw new HttpResponseException(
                  Request.CreateResponse(HttpStatusCode.NotFound));
            }
            else
            {
                HttpContext.Current.Response.AddHeader("Access-Control-Allow-Origin", "http://localhost:49192");
                var json = new JavaScriptSerializer().Serialize(categoria);
                var response = Request.CreateResponse(HttpStatusCode.OK, json);
                return response;
            }
        }*/


        /*[System.Web.Http.HttpPost]
        public HttpResponseMessage Categoria(string id)
        {
            
        }
        */
    }
}

