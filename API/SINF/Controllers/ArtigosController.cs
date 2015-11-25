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
    public class ArtigosController : ApiController
    {
        //
        // GET: /Artigos/

        public IEnumerable<Lib_Primavera.Model.Artigo> Get()
        {
            HttpContext.Current.Response.AddHeader("Access-Control-Allow-Origin", LocalhostIP.localhostIP());
            return Lib_Primavera.PriIntegration.ListaArtigos();
        }


        // GET api/artigos/5    
        public Artigo Get(string id)
        {
            Lib_Primavera.Model.Artigo artigo = Lib_Primavera.PriIntegration.GetArtigo(id);
            if (artigo == null)
            {
                throw new HttpResponseException(
                  Request.CreateResponse(HttpStatusCode.NotFound));
            }
            else
            {
                HttpContext.Current.Response.AddHeader("Access-Control-Allow-Origin", LocalhostIP.localhostIP());
                return artigo;
            }
        }

        [System.Web.Http.HttpPost]
        public HttpResponseMessage Categoria(string id)
        {
            List<Artigo> produtosCategoria = Lib_Primavera.PriIntegration.GetArtigosCategoria(id);
            if (produtosCategoria == null)
            {
                return Request.CreateResponse(HttpStatusCode.Forbidden);
            }
            else
            {
                HttpContext.Current.Response.AddHeader("Access-Control-Allow-Origin", LocalhostIP.localhostIP());
                var json = new JavaScriptSerializer().Serialize(produtosCategoria);
                var response = Request.CreateResponse(HttpStatusCode.OK, json);
                return response;
            }
        }

        [System.Web.Http.HttpPost]
        public HttpResponseMessage SubCategoria(string id)
        {
            List<Artigo> produtosCategoria = Lib_Primavera.PriIntegration.GetArtigosSubCategoria(id);
            if (produtosCategoria == null)
            {
                return Request.CreateResponse(HttpStatusCode.Forbidden);
            }
            else
            {
                HttpContext.Current.Response.AddHeader("Access-Control-Allow-Origin", LocalhostIP.localhostIP());
                var json = new JavaScriptSerializer().Serialize(produtosCategoria);
                var response = Request.CreateResponse(HttpStatusCode.OK, json);
                return response;
            }
        }


        [System.Web.Http.HttpGet]
        public HttpResponseMessage Top(string number)
        {
            List<Lib_Primavera.Model.Artigo> artigos = Lib_Primavera.PriIntegration.Top_artigos(Int32.Parse(number), null);
            if (artigos == null)
            {
                return Request.CreateResponse(HttpStatusCode.Forbidden);
            }
            else
            {
                HttpContext.Current.Response.AddHeader("Access-Control-Allow-Origin", LocalhostIP.localhostIP());
                var json = new JavaScriptSerializer().Serialize(artigos);
                var response = Request.CreateResponse(HttpStatusCode.OK, json);
                return response;
            }
        }

        [System.Web.Http.HttpGet]
        public HttpResponseMessage Top(string id, string categoria)
        {
            List<Lib_Primavera.Model.Artigo> artigos = Lib_Primavera.PriIntegration.Top_artigos(Int32.Parse(id), categoria);
            if (artigos == null)
            {
                throw new HttpResponseException(
                  Request.CreateResponse(HttpStatusCode.Forbidden));
            }
            else
            {
                HttpContext.Current.Response.AddHeader("Access-Control-Allow-Origin", LocalhostIP.localhostIP());
                var json = new JavaScriptSerializer().Serialize(artigos);
                var response = Request.CreateResponse(HttpStatusCode.OK, json);
                return response;
            }
        }

    }
}

