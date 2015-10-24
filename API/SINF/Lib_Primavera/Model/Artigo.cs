using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SINF.Lib_Primavera.Model
{
    public class Artigo
    {
        public string Moeda
        {
            get;
            set;
        }
        
        public string CodArtigo
        {
            get;
            set;
        }

        public string DescArtigo
        {
            get;
            set;
        }
        public double PVP
        {
            get;
            set;
        }
        public string UnidadeBase
        {
            get;
            set;
        }
        public string Marca
        {
            get;
            set;
        }
        public string Modelo
        {
            get;
            set;
        }
        public double Peso
        {
            get;
            set;
        }

    }
}