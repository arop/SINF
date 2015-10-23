using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace SINF.IP
{
    public class LocalhostIP : Controller
    {
        //
        // GET: /LocalhostIP/

        public ActionResult Index()
        {
            return View();
        }

        public static String localhostIP()
        {
            return "http://localhost:50664";
        }

    }
}
