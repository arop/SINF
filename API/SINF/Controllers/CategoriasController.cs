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
    public class CategoriasController : ApiController
    {
        //
        // GET: /categorias/
        public HttpResponseMessage Post()
        {
            HttpContext.Current.Response.AddHeader("Access-Control-Allow-Origin", LocalhostIP.localhostIP());
            List<Categoria> listaCategorias = Lib_Primavera.PriIntegration.ListaCategorias();

            /*for (int i = 0; i < listaCategorias.Count; i++)
            {
                List<Categoria> subs = Lib_Primavera.PriIntegration.GetSubCategorias(listaCategorias[i].CodCategoria);
                listaCategorias[i].SubCategorias = subs;
            }*/

            var json = new JavaScriptSerializer().Serialize(listaCategorias);
            var response = Request.CreateResponse(HttpStatusCode.OK, json);
            return response;
        }


        // GET api/categorias/H01   
        public HttpResponseMessage Get(string id)
        {
            Categoria categoria = Lib_Primavera.PriIntegration.GetCategoria(id);
            if (categoria == null)
            {
                var response = Request.CreateResponse(HttpStatusCode.NotFound);
                return response;
            }
            else
            {
                HttpContext.Current.Response.AddHeader("Access-Control-Allow-Origin", LocalhostIP.localhostIP());
                var json = new JavaScriptSerializer().Serialize(categoria);
                var response = Request.CreateResponse(HttpStatusCode.OK, json);
                return response;
            }
        }

        /**
         *  Obter subcategorias de uma categoria
         */
        [System.Web.Http.HttpGet]
        public HttpResponseMessage Subcategorias(string id)
        {
            List<Categoria> categorias = Lib_Primavera.PriIntegration.GetSubCategorias(id);
            if (categorias == null)
            {
                var response = Request.CreateResponse(HttpStatusCode.NotFound);
                return response;
            }
            else
            {
                HttpContext.Current.Response.AddHeader("Access-Control-Allow-Origin", LocalhostIP.localhostIP());
                var json = new JavaScriptSerializer().Serialize(categorias);
                var response = Request.CreateResponse(HttpStatusCode.OK, json);
                return response;
            }
        }

        /**
         *  Obter subcategoria
         */
        [System.Web.Http.HttpGet]
        public HttpResponseMessage Subcategoria(string id)
        {
            Categoria categoria = Lib_Primavera.PriIntegration.GetSubCategoria(id);
            if (categoria == null)
            {
                var response = Request.CreateResponse(HttpStatusCode.NotFound);
                return response;
            }
            else
            {
                HttpContext.Current.Response.AddHeader("Access-Control-Allow-Origin", LocalhostIP.localhostIP());
                var json = new JavaScriptSerializer().Serialize(categoria);
                var response = Request.CreateResponse(HttpStatusCode.OK, json);
                return response;
            }
        }
        
    }
}

