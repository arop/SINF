using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SINF.Lib_Primavera.Model
{
    public class Cliente
    {
        //public string Morada;

        /* Exemplo para POST e GET com valores específicos
         public string Morada
        {
            get
            {
                return "MORADA: " + _morada;
            }
            set
            {
                _morada = value;
            }
        }
    
*/
        public string CodCliente
        {
            get;
            set;
        }

        public string NomeCliente
        {
            get;
            set;
        }

        public string NumContribuinte
        {
            get;
            set;
        }

        public string Moeda
        {
            get;
            set;
        }

        public string Morada
        {
            get;
            set;
        }

        public string CodPostal
        {
            get;
            set;
        }

        public string Localidade
        {
            get;
            set;
        }

        public string CondicaoPag
        {
            get;
            set;
        }        

    }
}