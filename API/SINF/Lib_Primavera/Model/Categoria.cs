using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SINF.Lib_Primavera.Model
{
    public class Categoria
    {
        public string CodCategoria
        {
            get;
            set;
        }

        public string DescCategoria
        {
            get;
            set;
        }
        public List<Categoria> SubCategorias
        {
            get;
            set;
        }
       
    }
}