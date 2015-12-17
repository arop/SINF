using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Interop.ErpBS800;
using Interop.StdPlatBS800;
using Interop.StdBE800;
using Interop.GcpBE800;
using ADODB;
using Interop.IGcpBS800;
//using Interop.StdBESql800;
//using Interop.StdBSSql800;

namespace SINF.Lib_Primavera
{
    public class PriIntegration
    {


        # region Cliente

        public static List<Model.Cliente> ListaClientes()
        {


            StdBELista objList;

            List<Model.Cliente> listClientes = new List<Model.Cliente>();

            if (PriEngine.InitializeCompany(SINF.Properties.Settings.Default.Company.Trim(), SINF.Properties.Settings.Default.User.Trim(), SINF.Properties.Settings.Default.Password.Trim()) == true)
            {

                //objList = PriEngine.Engine.Comercial.Clientes.LstClientes();

                objList = PriEngine.Engine.Consulta("SELECT Cliente, Nome, Moeda, NumContrib as NumContribuinte, Fac_Mor AS campo_exemplo FROM  CLIENTES");


                while (!objList.NoFim())
                {
                    listClientes.Add(new Model.Cliente
                    {
                        CodCliente = objList.Valor("Cliente"),
                        NomeCliente = objList.Valor("Nome"),
                        Moeda = objList.Valor("Moeda"),
                        NumContribuinte = objList.Valor("NumContribuinte"),
                        Morada = objList.Valor("campo_exemplo")
                    });
                    objList.Seguinte();

                }

                return listClientes;
            }
            else
                return null;
        }

        public static Lib_Primavera.Model.Cliente GetCliente(string codCliente)
        {


            GcpBECliente objCli = new GcpBECliente();


            Model.Cliente myCli = new Model.Cliente();

            if (PriEngine.InitializeCompany(SINF.Properties.Settings.Default.Company.Trim(), SINF.Properties.Settings.Default.User.Trim(), SINF.Properties.Settings.Default.Password.Trim()) == true)
            {

                if (PriEngine.Engine.Comercial.Clientes.Existe(codCliente) == true)
                {
                    objCli = PriEngine.Engine.Comercial.Clientes.Edita(codCliente);
                    myCli.CodCliente = objCli.get_Cliente();
                    myCli.NomeCliente = objCli.get_Nome();
                    myCli.Moeda = objCli.get_Moeda();
                    myCli.NumContribuinte = objCli.get_NumContribuinte();
                    myCli.Morada = objCli.get_Morada();
                    return myCli;
                }
                else
                {
                    return null;
                }
            }
            else
                return null;
        }

        public static Lib_Primavera.Model.RespostaErro UpdCliente(Lib_Primavera.Model.Cliente cliente)
        {
            Lib_Primavera.Model.RespostaErro erro = new Model.RespostaErro();


            GcpBECliente objCli = new GcpBECliente();

            try
            {

                if (PriEngine.InitializeCompany(SINF.Properties.Settings.Default.Company.Trim(), SINF.Properties.Settings.Default.User.Trim(), SINF.Properties.Settings.Default.Password.Trim()) == true)
                {

                    if (PriEngine.Engine.Comercial.Clientes.Existe(cliente.CodCliente) == false)
                    {
                        erro.Erro = 1;
                        erro.Descricao = "O cliente não existe";
                        return erro;
                    }
                    else
                    {

                        objCli = PriEngine.Engine.Comercial.Clientes.Edita(cliente.CodCliente);
                        objCli.set_EmModoEdicao(true);

                        objCli.set_Nome(cliente.NomeCliente);
                        objCli.set_NumContribuinte(cliente.NumContribuinte);
                        objCli.set_Moeda(cliente.Moeda);
                        objCli.set_Morada(cliente.Morada);

                        PriEngine.Engine.Comercial.Clientes.Actualiza(objCli);

                        erro.Erro = 0;
                        erro.Descricao = "Sucesso";
                        return erro;
                    }
                }
                else
                {
                    erro.Erro = 1;
                    erro.Descricao = "Erro ao abrir a empresa";
                    return erro;

                }

            }

            catch (Exception ex)
            {
                erro.Erro = 1;
                erro.Descricao = ex.Message;
                return erro;
            }

        }


        public static Lib_Primavera.Model.RespostaErro DelCliente(string codCliente)
        {

            Lib_Primavera.Model.RespostaErro erro = new Model.RespostaErro();
            GcpBECliente objCli = new GcpBECliente();


            try
            {

                if (PriEngine.InitializeCompany(SINF.Properties.Settings.Default.Company.Trim(), SINF.Properties.Settings.Default.User.Trim(), SINF.Properties.Settings.Default.Password.Trim()) == true)
                {
                    if (PriEngine.Engine.Comercial.Clientes.Existe(codCliente) == false)
                    {
                        erro.Erro = 1;
                        erro.Descricao = "O cliente não existe";
                        return erro;
                    }
                    else
                    {

                        PriEngine.Engine.Comercial.Clientes.Remove(codCliente);
                        erro.Erro = 0;
                        erro.Descricao = "Sucesso";
                        return erro;
                    }
                }

                else
                {
                    erro.Erro = 1;
                    erro.Descricao = "Erro ao abrir a empresa";
                    return erro;
                }
            }

            catch (Exception ex)
            {
                erro.Erro = 1;
                erro.Descricao = ex.Message;
                return erro;
            }

        }



        public static Lib_Primavera.Model.RespostaErro InsereClienteObj(Model.Cliente cli)
        {

            Lib_Primavera.Model.RespostaErro erro = new Model.RespostaErro();


            GcpBECliente myCli = new GcpBECliente();

            try
            {
                if (PriEngine.InitializeCompany(SINF.Properties.Settings.Default.Company.Trim(), SINF.Properties.Settings.Default.User.Trim(), SINF.Properties.Settings.Default.Password.Trim()) == true)
                {

                    myCli.set_Cliente(cli.CodCliente);
                    myCli.set_Nome(cli.NomeCliente);
                    myCli.set_NumContribuinte(cli.NumContribuinte);
                    myCli.set_Moeda(cli.Moeda);
                    myCli.set_Morada(cli.Morada);
                    myCli.set_CodigoPostal(cli.CodPostal);
                    myCli.set_Localidade(cli.Localidade);
                    myCli.set_LocalidadeCodigoPostal(cli.Localidade);
                    myCli.set_CondPag(cli.CondicaoPag);

                    PriEngine.Engine.Comercial.Clientes.Actualiza(myCli);

                    erro.Erro = 0;
                    erro.Descricao = "Sucesso";
                    return erro;
                }
                else
                {
                    erro.Erro = 1;
                    erro.Descricao = "Erro ao abrir empresa";
                    return erro;
                }
            }

            catch (Exception ex)
            {
                erro.Erro = 1;
                erro.Descricao = ex.Message;
                return erro;
            }


        }



        #endregion Cliente;   // -----------------------------  END   CLIENTE    -----------------------


        #region Artigo

        public static Lib_Primavera.Model.Artigo GetArtigo(string codArtigo)
        {
            StdBELista objListLin;
            Lib_Primavera.Model.Artigo artigo = new Lib_Primavera.Model.Artigo();

            if (PriEngine.InitializeCompany(SINF.Properties.Settings.Default.Company.Trim(), SINF.Properties.Settings.Default.User.Trim(), SINF.Properties.Settings.Default.Password.Trim()) == true)
            {
                string query = "SELECT a.*, m.*, f.Descricao as familiaDesc, i.Taxa "+
                    "FROM Artigo as a, ArtigoMoeda as m, Familias as f, Iva as i "+
                    "where a.Artigo = m.Artigo AND a.Artigo='" + codArtigo+"' "+
                    "AND a.Familia = f.Familia AND i.Iva = a.Iva";

                objListLin = PriEngine.Engine.Consulta(query);

                if (!objListLin.NoFim())
                {
                    artigo.CodArtigo = objListLin.Valor("Artigo");
                    artigo.DescArtigo = objListLin.Valor("Descricao");
                    artigo.Categoria = objListLin.Valor("Familia");
                    artigo.SubCategoria = objListLin.Valor("SubFamilia");

                    artigo.CategoriaDesc = objListLin.Valor("familiaDesc");
                    
                    artigo.PVP = objListLin.Valor("PVP1");
                    artigo.Moeda = objListLin.Valor("Moeda");
                    artigo.UnidadeBase = objListLin.Valor("UnidadeBase");
                    artigo.Marca = objListLin.Valor("Marca");
                    artigo.Modelo = objListLin.Valor("Modelo");
                    artigo.Peso = objListLin.Valor("Peso");
                    artigo.IVA = objListLin.Valor("Taxa");

                    if (artigo.SubCategoria != "") {
                        string querySubFamilia = "SELECT * FROM SubFamilias WHERE SubFamilias.SubFamilia = '" + artigo.SubCategoria + "'";
                        StdBELista subfam = PriEngine.Engine.Consulta(querySubFamilia);
                        if(!subfam.NoFim())
                            artigo.SubCategoriaDesc = subfam.Valor("Descricao");
                    }
                    if (artigo.Marca != "")
                    {
                        string queryMarca = "SELECT Descricao FROM Marcas WHERE Marcas.Marca = '" + artigo.Marca + "'";
                        StdBELista marca = PriEngine.Engine.Consulta(queryMarca);
                        if (!marca.NoFim())
                            artigo.MarcaDesc = marca.Valor("Descricao");
                    }
                }
                else return null;

            }

            return artigo;
        }


        public static List<Lib_Primavera.Model.Artigo> GetArtigos(Lib_Primavera.Model.Carrinho car)
        {
            StdBELista objListLin;
            List<Lib_Primavera.Model.Artigo> artigos = new List<Lib_Primavera.Model.Artigo>();

            if (PriEngine.InitializeCompany(SINF.Properties.Settings.Default.Company.Trim(), SINF.Properties.Settings.Default.User.Trim(), SINF.Properties.Settings.Default.Password.Trim()) == true)
            {
                foreach(String codArtigo in car.Produtos_id){
                    Lib_Primavera.Model.Artigo artigo = new Lib_Primavera.Model.Artigo();

                    string query = "SELECT a.*, m.*, f.Descricao as familiaDesc, i.Taxa, i.Iva " +
                    "FROM Artigo as a, ArtigoMoeda as m, Familias as f, Iva as i " +
                    "where a.Artigo = m.Artigo AND a.Artigo='" + codArtigo + "' " +
                    "AND a.Familia = f.Familia AND i.Iva = a.Iva";

                    objListLin = PriEngine.Engine.Consulta(query);

                    if (!objListLin.NoFim())
                    {
                        artigo.CodArtigo = objListLin.Valor("Artigo");
                        artigo.DescArtigo = objListLin.Valor("Descricao");
                        artigo.Categoria = objListLin.Valor("Familia");
                        artigo.SubCategoria = objListLin.Valor("SubFamilia");

                        artigo.CategoriaDesc = objListLin.Valor("familiaDesc");

                        artigo.PVP = objListLin.Valor("PVP1");
                        artigo.Moeda = objListLin.Valor("Moeda");
                        artigo.UnidadeBase = objListLin.Valor("UnidadeBase");
                        artigo.Marca = objListLin.Valor("Marca");
                        artigo.Modelo = objListLin.Valor("Modelo");
                        artigo.Peso = objListLin.Valor("Peso");
                        artigo.IVA = objListLin.Valor("Taxa");

                        if (artigo.SubCategoria != "")
                        {
                            string querySubFamilia = "SELECT * FROM SubFamilias WHERE SubFamilias.SubFamilia = '" + artigo.SubCategoria + "'";
                            StdBELista subfam = PriEngine.Engine.Consulta(querySubFamilia);
                            if (!subfam.NoFim())
                                artigo.SubCategoriaDesc = subfam.Valor("Descricao");
                        }
                        if (artigo.Marca != "")
                        {
                            string queryMarca = "SELECT Descricao FROM Marcas WHERE Marcas.Marca = '" + artigo.Marca + "'";
                            StdBELista marca = PriEngine.Engine.Consulta(queryMarca);
                            if (!marca.NoFim())
                                artigo.MarcaDesc = marca.Valor("Descricao");
                        }
                    }
                    else artigo = null;

                    artigos.Add(artigo);
                }

            }
            return artigos;
        }

        public static List<Model.Artigo> ListaArtigos()
        {

            StdBELista objList;

            Model.Artigo art = new Model.Artigo();
            List<Model.Artigo> listArts = new List<Model.Artigo>();

            if (PriEngine.InitializeCompany(SINF.Properties.Settings.Default.Company.Trim(), SINF.Properties.Settings.Default.User.Trim(), SINF.Properties.Settings.Default.Password.Trim()) == true)
            {

                objList = PriEngine.Engine.Comercial.Artigos.LstArtigos();

                while (!objList.NoFim())
                {
                    art = new Model.Artigo();
                    art.CodArtigo = objList.Valor("artigo");
                    art.DescArtigo = objList.Valor("descricao");

                    listArts.Add(art);
                    objList.Seguinte();
                }

                return listArts;

            }
            else
            {
                return null;

            }

        }



        public static List<Model.Artigo> GetArtigosCategoria(string categoria)
        {


            StdBELista objList;

            List<Model.Artigo> listArtigos = new List<Model.Artigo>();

            if (PriEngine.InitializeCompany(SINF.Properties.Settings.Default.Company.Trim(), SINF.Properties.Settings.Default.User.Trim(), SINF.Properties.Settings.Default.Password.Trim()) == true)
            {

                //objList = PriEngine.Engine.Comercial.Clientes.LstClientes();
                string query = "SELECT a.*," +
                        " m.*, i.Taxa " +
                        " FROM Artigo AS a JOIN ArtigoMoeda AS m ON a.Artigo = m.Artigo JOIN Iva as i ON a.Iva = i.Iva WHERE a.Familia = '" + categoria + "' AND a.TipoArtigo = 3";
                objList = PriEngine.Engine.Consulta(query);


                while (!objList.NoFim())
                {
                    listArtigos.Add(new Model.Artigo
                    {
                        CodArtigo = objList.Valor("Artigo"),
                        DescArtigo = objList.Valor("Descricao"),
                        PVP = objList.Valor("PVP1"),
                        Moeda = objList.Valor("Moeda"),
                        UnidadeBase = objList.Valor("UnidadeBase"),
                        Marca = objList.Valor("Marca"),
                        Modelo = objList.Valor("Modelo"),
                        Peso = objList.Valor("Peso"),
                        IVA = objList.Valor("Taxa")
                    });
                    objList.Seguinte();

                }

                return listArtigos;
            }
            else
                return null;
        }

        public static List<Model.Artigo> GetArtigosSubCategoria(string categoria)
        {
            StdBELista objList;

            List<Model.Artigo> listArtigos = new List<Model.Artigo>();

            if (PriEngine.InitializeCompany(SINF.Properties.Settings.Default.Company.Trim(), SINF.Properties.Settings.Default.User.Trim(), SINF.Properties.Settings.Default.Password.Trim()) == true)
            {

                //objList = PriEngine.Engine.Comercial.Clientes.LstClientes();
                string query = "SELECT a.Artigo, a.Descricao, a.Marca, a.Modelo, a.Peso, a.UnidadeBase, a.Iva, " +
                        " m.PVP1, m.Moeda, i.Taxa" +
                        " FROM Artigo AS a JOIN ArtigoMoeda AS m ON a.Artigo = m.Artigo JOIN Iva as i ON a.Iva = i.Iva  WHERE a.SubFamilia = '" + categoria + "' AND a.TipoArtigo = 3";
                objList = PriEngine.Engine.Consulta(query);


                while (!objList.NoFim())
                {
                    listArtigos.Add(new Model.Artigo
                    {
                        CodArtigo = objList.Valor("Artigo"),
                        DescArtigo = objList.Valor("Descricao"),
                        PVP = objList.Valor("PVP1"),
                        Moeda = objList.Valor("Moeda"),
                        UnidadeBase = objList.Valor("UnidadeBase"),
                        Marca = objList.Valor("Marca"),
                        Modelo = objList.Valor("Modelo"),
                        Peso = objList.Valor("Peso"),
                        IVA = objList.Valor("Taxa")
                    });
                    objList.Seguinte();

                }

                return listArtigos;
            }
            else
                return null;
        }

        public static List<Model.Artigo> ProcurarArtigos(string termoProcura)
        {

            StdBELista objList;
            List<Model.Artigo> resultado = new List<Model.Artigo>();
            if (PriEngine.InitializeCompany(SINF.Properties.Settings.Default.Company.Trim(), SINF.Properties.Settings.Default.User.Trim(), SINF.Properties.Settings.Default.Password.Trim()) == true)
            {

                //objList = PriEngine.Engine.Comercial.Clientes.LstClientes();
                string query = "SELECT a.Artigo, a.Descricao, a.Marca, a.Modelo, a.Peso, a.UnidadeBase, a.Familia, a.SubFamilia, a.CodIva, i.Taxa, " +
                        " m.PVP1, m.Moeda" +
                        " FROM Artigo AS a JOIN ArtigoMoeda AS m ON a.Artigo = m.Artigo JOIN Iva as i ON a.CodIva = i.Iva WHERE a.Artigo LIKE '%" + termoProcura + "%' OR " +
                        " a.Descricao LIKE '%" + termoProcura + "%' AND a.TipoArtigo = 3";
                objList = PriEngine.Engine.Consulta(query);


                while (!objList.NoFim())
                {
                    resultado.Add(new Model.Artigo
                    {
                        CodArtigo = objList.Valor("Artigo"),
                        DescArtigo = objList.Valor("Descricao"),
                        Categoria = objList.Valor("Familia"),
                        SubCategoria = objList.Valor("SubFamilia"),
                        PVP = objList.Valor("PVP1"),
                        Moeda = objList.Valor("Moeda"),
                        UnidadeBase = objList.Valor("UnidadeBase"),
                        Marca = objList.Valor("Marca"),
                        Modelo = objList.Valor("Modelo"),
                        Peso = objList.Valor("Peso"),
                        IVA = objList.Valor("Taxa")
                    });
                    objList.Seguinte();

                }

                return resultado;
            }
            else
                return null;
        }

        public static List<Lib_Primavera.Model.Artigo> Top_artigos(int quantidade , string categoria)
        {

            StdBELista objListLin;
            List<Lib_Primavera.Model.Artigo> listArtigos = new List<Lib_Primavera.Model.Artigo>();

            if (PriEngine.InitializeCompany(SINF.Properties.Settings.Default.Company.Trim(), SINF.Properties.Settings.Default.User.Trim(), SINF.Properties.Settings.Default.Password.Trim()) == true)
            {
                string query = "SELECT TOP " + quantidade + " a.Artigo, a.Descricao, a.Marca, a.Modelo, a.Peso, a.UnidadeBase, m.PVP1, m.moeda, a.Familia, a.SubFamilia, v.itemcount, a.Iva, i.Taxa" +
                                        " FROM Artigo as a JOIN (SELECT Artigo, COUNT(*) as itemcount" +
                                                                " FROM  LinhasDoc" +
                                                                " GROUP BY Artigo) as v" +
                                        " ON a.Artigo = v.Artigo JOIN ArtigoMoeda AS m ON a.Artigo = m.Artigo JOIN Iva as i ON a.Iva = i.Iva" +
                                        ((categoria == null) ? " " : " WHERE a.Familia = '" + categoria + "'") + 
                                        ((categoria == null) ? " WHERE " : " AND ") + " a.TipoArtigo = 3 "+ //3 -> Mercadoria
                                        " ORDER BY itemcount DESC";

                //       objListLin = PriEngine.Engine.Consulta("SELECT TOP 20 Artigo, COUNT(*) as itemcount from LinhasDoc JOIN Artigo ON Artigo.Artigo GROUP BY Artigo ORDER BY itemcount");

                objListLin = PriEngine.Engine.Consulta(query);

                while (!objListLin.NoFim())
                {
                    string Artigo = objListLin.Valor("Artigo") + " # " + objListLin.Valor("Descricao") + " # " + objListLin.Valor("itemcount");
                    listArtigos.Add(new Model.Artigo
                    {
                        CodArtigo = objListLin.Valor("Artigo"),
                        DescArtigo = objListLin.Valor("Descricao"),
                        Categoria = objListLin.Valor("Familia"),
                        SubCategoria = objListLin.Valor("SubFamilia"),
                        PVP = objListLin.Valor("PVP1"),
                        Moeda = objListLin.Valor("Moeda"),
                        UnidadeBase = objListLin.Valor("UnidadeBase"),
                        Marca = objListLin.Valor("Marca"),
                        Modelo = objListLin.Valor("Modelo"),
                        Peso = objListLin.Valor("Peso"),
                        IVA = objListLin.Valor("Taxa")
                    });

                    objListLin.Seguinte();
                }

            }
            return listArtigos;
        }



        #endregion Artigo

        #region Categoria

        public static List<Model.Categoria> ListaCategorias()
        {

            StdBELista objList;

            List<Model.Categoria> listCategorias = new List<Model.Categoria>();

            if (PriEngine.InitializeCompany(SINF.Properties.Settings.Default.Company.Trim(), SINF.Properties.Settings.Default.User.Trim(), SINF.Properties.Settings.Default.Password.Trim()) == true)
            {

                //objList = PriEngine.Engine.Comercial.Clientes.LstClientes();

                objList = PriEngine.Engine.Consulta("SELECT Familia, Descricao FROM Familias");


                while (!objList.NoFim())
                {

                    StdBELista objList2 = PriEngine.Engine.Consulta("SELECT SubFamilia, Descricao FROM SubFamilias WHERE Familia = '" + objList.Valor("Familia") + "'");
                   
                    
                    if (objList2.NoFim())
                    {
                        listCategorias.Add(new Model.Categoria
                        {
                            CodCategoria = objList.Valor("Familia"),
                            DescCategoria = objList.Valor("Descricao")
                        });
                    }
                    else
                    {
                        List<Model.Categoria> subs = new List<Model.Categoria>();
                       
                        while (!objList2.NoFim())
                        {
                            Model.Categoria categoria = new Model.Categoria
                            {
                                CodCategoria = objList2.Valor("SubFamilia"),
                                DescCategoria = objList2.Valor("Descricao")
                            };
                            subs.Add(categoria);
                            objList2.Seguinte();
                        }

                        listCategorias.Add(new Model.Categoria
                        {
                            CodCategoria = objList.Valor("Familia"),
                            DescCategoria = objList.Valor("Descricao"),
                            SubCategorias = subs
                        });


                    }  




                    
                    objList.Seguinte();

                }

                return listCategorias;
            }
            else
                return null;
        }

        public static List<Model.Categoria> GetSubCategorias(string idCategoria)
        {

            StdBELista objList;

            List<Model.Categoria> listCategorias = new List<Model.Categoria>();

            if (PriEngine.InitializeCompany(SINF.Properties.Settings.Default.Company.Trim(), SINF.Properties.Settings.Default.User.Trim(), SINF.Properties.Settings.Default.Password.Trim()) == true)
            {

                //objList = PriEngine.Engine.Comercial.Clientes.LstClientes();

                objList = PriEngine.Engine.Consulta("SELECT SubFamilia, Descricao FROM SubFamilias WHERE Familia = '" + idCategoria + "'");


                while (!objList.NoFim())
                {
                    listCategorias.Add(new Model.Categoria
                    {
                        CodCategoria = objList.Valor("SubFamilia"),
                        DescCategoria = objList.Valor("Descricao")
                    });
                    objList.Seguinte();

                }

                return listCategorias;
            }
            else
                return null;
        }


        public static Model.Categoria GetCategoria(string cod)
        {

            StdBELista objList;

            if (PriEngine.InitializeCompany(SINF.Properties.Settings.Default.Company.Trim(), SINF.Properties.Settings.Default.User.Trim(), SINF.Properties.Settings.Default.Password.Trim()) == true)
            {

                //objList = PriEngine.Engine.Comercial.Clientes.LstClientes();

                objList = PriEngine.Engine.Consulta("SELECT Familia, Descricao FROM Familias WHERE Familia = '" + cod + "'");
                if (!objList.NoFim())
                {
                    Model.Categoria categoria = new Model.Categoria
                    {
                        CodCategoria = objList.Valor("Familia"),
                        DescCategoria = objList.Valor("Descricao")
                    };
                    objList.Seguinte();

                    return categoria;
                }
                return null;

            }
            else
                return null;
        }


        public static Model.Categoria GetSubCategoria(string idCategoria)
        {

            StdBELista objList;

            if (PriEngine.InitializeCompany(SINF.Properties.Settings.Default.Company.Trim(), SINF.Properties.Settings.Default.User.Trim(), SINF.Properties.Settings.Default.Password.Trim()) == true)
            {

                //objList = PriEngine.Engine.Comercial.Clientes.LstClientes();

                objList = PriEngine.Engine.Consulta("SELECT SubFamilia, Descricao FROM SubFamilias WHERE SubFamilia = '" + idCategoria + "'");

                if (objList.NoFim())
                {
                    return null;
                }
                else
                {
                    Model.Categoria categoria = new Model.Categoria
                    {
                        CodCategoria = objList.Valor("SubFamilia"),
                        DescCategoria = objList.Valor("Descricao")
                    };

                    return categoria;
                }  
                
            }
            else
                return null;
        }



        #endregion Categoria


        #region DocCompra


        public static List<Model.DocCompra> VGR_List()
        {

            StdBELista objListCab;
            StdBELista objListLin;
            Model.DocCompra dc = new Model.DocCompra();
            List<Model.DocCompra> listdc = new List<Model.DocCompra>();
            Model.LinhaDocCompra lindc = new Model.LinhaDocCompra();
            List<Model.LinhaDocCompra> listlindc = new List<Model.LinhaDocCompra>();

            if (PriEngine.InitializeCompany(SINF.Properties.Settings.Default.Company.Trim(), SINF.Properties.Settings.Default.User.Trim(), SINF.Properties.Settings.Default.Password.Trim()) == true)
            {
                objListCab = PriEngine.Engine.Consulta("SELECT id, NumDocExterno, Entidade, DataDoc, NumDoc, TotalMerc, Serie From CabecCompras where TipoDoc='VGR'");
                while (!objListCab.NoFim())
                {
                    dc = new Model.DocCompra();
                    dc.id = objListCab.Valor("id");
                    dc.NumDocExterno = objListCab.Valor("NumDocExterno");
                    dc.Entidade = objListCab.Valor("Entidade");
                    dc.NumDoc = objListCab.Valor("NumDoc");
                    dc.Data = objListCab.Valor("DataDoc");
                    dc.TotalMerc = objListCab.Valor("TotalMerc");
                    dc.Serie = objListCab.Valor("Serie");
                    objListLin = PriEngine.Engine.Consulta("SELECT idCabecCompras, Artigo, Descricao, Quantidade, Unidade, PrecUnit, Desconto1, TotalILiquido, PrecoLiquido, Armazem, Lote from LinhasCompras where IdCabecCompras='" + dc.id + "' order By NumLinha");
                    listlindc = new List<Model.LinhaDocCompra>();

                    while (!objListLin.NoFim())
                    {
                        lindc = new Model.LinhaDocCompra();
                        lindc.IdCabecDoc = objListLin.Valor("idCabecCompras");
                        lindc.CodArtigo = objListLin.Valor("Artigo");
                        lindc.DescArtigo = objListLin.Valor("Descricao");
                        lindc.Quantidade = objListLin.Valor("Quantidade");
                        lindc.Unidade = objListLin.Valor("Unidade");
                        lindc.Desconto = objListLin.Valor("Desconto1");
                        lindc.PrecoUnitario = objListLin.Valor("PrecUnit");
                        lindc.TotalILiquido = objListLin.Valor("TotalILiquido");
                        lindc.TotalLiquido = objListLin.Valor("PrecoLiquido");
                        lindc.Armazem = objListLin.Valor("Armazem");
                        lindc.Lote = objListLin.Valor("Lote");

                        listlindc.Add(lindc);
                        objListLin.Seguinte();
                    }

                    dc.LinhasDoc = listlindc;

                    listdc.Add(dc);
                    objListCab.Seguinte();
                }
            }
            return listdc;
        }


        public static Model.RespostaErro VGR_New(Model.DocCompra dc)
        {
            Lib_Primavera.Model.RespostaErro erro = new Model.RespostaErro();


            GcpBEDocumentoCompra myGR = new GcpBEDocumentoCompra();
            GcpBELinhaDocumentoCompra myLin = new GcpBELinhaDocumentoCompra();
            GcpBELinhasDocumentoCompra myLinhas = new GcpBELinhasDocumentoCompra();

            PreencheRelacaoCompras rl = new PreencheRelacaoCompras();
            List<Model.LinhaDocCompra> lstlindv = new List<Model.LinhaDocCompra>();

            try
            {
                if (PriEngine.InitializeCompany(SINF.Properties.Settings.Default.Company.Trim(), SINF.Properties.Settings.Default.User.Trim(), SINF.Properties.Settings.Default.Password.Trim()) == true)
                {
                    // Atribui valores ao cabecalho do doc
                    //myEnc.set_DataDoc(dv.Data);
                    myGR.set_Entidade(dc.Entidade);
                    myGR.set_NumDocExterno(dc.NumDocExterno);
                    myGR.set_Serie(dc.Serie);
                    myGR.set_Tipodoc("VGR");
                    myGR.set_TipoEntidade("F");
                    // Linhas do documento para a lista de linhas
                    lstlindv = dc.LinhasDoc;
                    PriEngine.Engine.Comercial.Compras.PreencheDadosRelacionados(myGR, rl);
                    foreach (Model.LinhaDocCompra lin in lstlindv)
                    {
                        PriEngine.Engine.Comercial.Compras.AdicionaLinha(myGR, lin.CodArtigo, lin.Quantidade, lin.Armazem, "", lin.PrecoUnitario, lin.Desconto);
                    }


                    PriEngine.Engine.IniciaTransaccao();
                    PriEngine.Engine.Comercial.Compras.Actualiza(myGR, "Teste");
                    PriEngine.Engine.TerminaTransaccao();
                    erro.Erro = 0;
                    erro.Descricao = "Sucesso";
                    return erro;
                }
                else
                {
                    erro.Erro = 1;
                    erro.Descricao = "Erro ao abrir empresa";
                    return erro;

                }

            }
            catch (Exception ex)
            {
                PriEngine.Engine.DesfazTransaccao();
                erro.Erro = 1;
                erro.Descricao = ex.Message;
                return erro;
            }
        }


        #endregion DocCompra


        #region DocsVenda

        public static Model.RespostaErro Encomendas_New(ref Model.DocVenda dv)
        {
            Lib_Primavera.Model.RespostaErro erro = new Model.RespostaErro();
            GcpBEDocumentoVenda myEnc = new GcpBEDocumentoVenda();

            GcpBELinhaDocumentoVenda myLin = new GcpBELinhaDocumentoVenda();

            GcpBELinhasDocumentoVenda myLinhas = new GcpBELinhasDocumentoVenda();

            PreencheRelacaoVendas rl = new PreencheRelacaoVendas();
            List<Model.LinhaDocVenda> lstlindv = new List<Model.LinhaDocVenda>();

            bool iniciouTransaccao = false;
            try
            {
                if (PriEngine.InitializeCompany(SINF.Properties.Settings.Default.Company.Trim(), SINF.Properties.Settings.Default.User.Trim(), SINF.Properties.Settings.Default.Password.Trim()) == true)
                {
                    // Atribui valores ao cabecalho do doc
                    //myEnc.set_DataDoc(dv.Data);
                    myEnc.set_Entidade(dv.Entidade);
                    myEnc.set_Serie("A");
                    
                    myEnc.set_Tipodoc("ECL"); //encomenda cliente
                    myEnc.set_TipoEntidade("C");
                    // Linhas do documento para a lista de linhas
                    lstlindv = dv.LinhasDoc;
                    PriEngine.Engine.Comercial.Vendas.PreencheDadosRelacionados(myEnc, rl);
                    dv.Data = myEnc.get_DataDoc();
                    dv.id = myEnc.get_ID();
                    
                    foreach (Model.LinhaDocVenda lin in lstlindv)
                    {
                        PriEngine.Engine.Comercial.Vendas.AdicionaLinha(myEnc, lin.CodArtigo, lin.Quantidade, "", "", lin.PrecoUnitario, lin.Desconto);
                    }

                    // PriEngine.Engine.Comercial.Compras.TransformaDocumento(

                    
                    /*GcpBEDocumentoVenda myFac = new GcpBEDocumentoVenda();
                    myFac.set_Entidade(dv.Entidade);
                    myFac.set_Serie("A");
                    myEnc.set_Tipodoc("FS"); //factura simplificada
                    myFac.set_TipoEntidade("C");
                    myFac.set_IdDocOrigem(dv.id);
                    PriEngine.Engine.Comercial.Vendas.PreencheDadosRelacionados(myFac, rl);
                    foreach (Model.LinhaDocVenda lin in lstlindv)
                    {
                        PriEngine.Engine.Comercial.Vendas.AdicionaLinha(myFac, lin.CodArtigo, lin.Quantidade, "", "", lin.PrecoUnitario, lin.Desconto);
                    }*/


                    PriEngine.Engine.IniciaTransaccao();
                    iniciouTransaccao = true;
                    PriEngine.Engine.Comercial.Vendas.Actualiza(myEnc, "Teste");
                    //PriEngine.Engine.Comercial.Vendas.Actualiza(myFac, "Teste");
                    PriEngine.Engine.TerminaTransaccao();
                    iniciouTransaccao = false;

                    //dv.IdFactura = myFac.get_ID();

                    erro.Erro = 0;
                    erro.Descricao = "Sucesso";
                    return erro;
                }
                else
                {
                    erro.Erro = 1;
                    erro.Descricao = "Erro ao abrir empresa";
                    return erro;

                }

            }
            catch (Exception ex)
            {
                if(iniciouTransaccao)
                    PriEngine.Engine.DesfazTransaccao();
                erro.Erro = 1;
                erro.Descricao = ex.Message;
                return erro;
            }
        }

     
        public static List<Model.DocVenda> Encomendas_List(int mes, int ano)
        {

            StdBELista objListCab;
            StdBELista objListLin;
            Model.DocVenda dv = new Model.DocVenda();
            List<Model.DocVenda> listdv = new List<Model.DocVenda>();
            Model.LinhaDocVenda lindv = new Model.LinhaDocVenda();
            List<Model.LinhaDocVenda> listlindv = new
            List<Model.LinhaDocVenda>();

            if (PriEngine.InitializeCompany(SINF.Properties.Settings.Default.Company.Trim(), SINF.Properties.Settings.Default.User.Trim(), SINF.Properties.Settings.Default.Password.Trim()) == true)
            {
                if (mes < 0 || ano < 0)
                    objListCab = PriEngine.Engine.Consulta("SELECT id, Entidade, Data, NumDoc, TotalMerc, TotalIva, Serie From CabecDoc where TipoDoc='ECL' ORDER BY Data DESC, NumDoc DESC");
                else objListCab = PriEngine.Engine.Consulta("SELECT id, Entidade, Data, NumDoc, TotalMerc, TotalIva, Serie From CabecDoc where TipoDoc='ECL' AND MONTH(Data) = " + mes + " AND YEAR(Data) = " + ano + " ORDER BY Data DESC, NumDoc DESC");
                while (!objListCab.NoFim())
                {
                    dv = new Model.DocVenda();
                    dv.id = objListCab.Valor("id");
                    dv.Entidade = objListCab.Valor("Entidade");
                    dv.NumDoc = objListCab.Valor("NumDoc");
                    dv.Data = objListCab.Valor("Data");
                    dv.TotalMerc = objListCab.Valor("TotalMerc");
                    dv.TotalIva = objListCab.Valor("TotalIva");
                    dv.Serie = objListCab.Valor("Serie");
                    objListLin = PriEngine.Engine.Consulta("SELECT * from LinhasDoc where IdCabecDoc='" + dv.id + "' order By NumLinha");
                    listlindv = new List<Model.LinhaDocVenda>();

                   /* while (!objListLin.NoFim())
                    {
                        lindv = new Model.LinhaDocVenda();
                        lindv.IdCabecDoc = objListLin.Valor("idCabecDoc");
                        lindv.CodArtigo = objListLin.Valor("Artigo");
                        lindv.DescArtigo = objListLin.Valor("Descricao");
                        lindv.Quantidade = objListLin.Valor("Quantidade");
                        lindv.Unidade = objListLin.Valor("Unidade");
                        lindv.Desconto = objListLin.Valor("Desconto1");
                        lindv.PrecoUnitario = objListLin.Valor("PrecUnit");
                        lindv.TotalILiquido = objListLin.Valor("TotalILiquido");
                        lindv.TotalLiquido = objListLin.Valor("PrecoLiquido");
                        lindv.IVA = objListLin.Valor("IVA");

                        listlindv.Add(lindv);
                        objListLin.Seguinte();
                    }*/

                    dv.LinhasDoc = listlindv;
                    listdv.Add(dv);
                    objListCab.Seguinte();
                }
            }
            return listdv;
        }

        public static Model.DocVenda Encomenda_Get(string numdoc)
        {
            StdBELista objListCab;
            StdBELista objListLin;
            Model.DocVenda dv = new Model.DocVenda();
            Model.LinhaDocVenda lindv = new Model.LinhaDocVenda();
            List<Model.LinhaDocVenda> listlindv = new List<Model.LinhaDocVenda>();

            if (PriEngine.InitializeCompany(SINF.Properties.Settings.Default.Company.Trim(), SINF.Properties.Settings.Default.User.Trim(), SINF.Properties.Settings.Default.Password.Trim()) == true)
            {


                string st = "SELECT id, Entidade, Data, NumDoc, TotalMerc, TotalIva Serie From CabecDoc where TipoDoc='ECL' and NumDoc='" + numdoc + "'";
                objListCab = PriEngine.Engine.Consulta(st);
                dv = new Model.DocVenda();
                dv.id = objListCab.Valor("id");
                dv.Entidade = objListCab.Valor("Entidade");
                dv.NumDoc = objListCab.Valor("NumDoc");
                dv.Data = objListCab.Valor("Data");
                dv.TotalMerc = objListCab.Valor("TotalMerc");
                dv.TotalIva = objListCab.Valor("TotalIva");
                dv.Serie = objListCab.Valor("Serie");
                objListLin = PriEngine.Engine.Consulta("SELECT LinhasDoc.*, Iva.* from LinhasDoc JOIN Iva ON Iva.Iva = LinhasDoc.CodIva where IdCabecDoc='" + dv.id + "' order By NumLinha");
                listlindv = new List<Model.LinhaDocVenda>();

                while (!objListLin.NoFim())
                {
                    lindv = new Model.LinhaDocVenda();
                    lindv.IdCabecDoc = objListLin.Valor("LinhasDoc.idCabecDoc");
                    lindv.CodArtigo = objListLin.Valor("LinhasDoc.Artigo");
                    lindv.DescArtigo = objListLin.Valor("LinhasDoc.Descricao");
                    lindv.Quantidade = objListLin.Valor("LinhasDoc.Quantidade");
                    lindv.Unidade = objListLin.Valor("LinhasDoc.Unidade");
                    lindv.Desconto = objListLin.Valor("LinhasDoc.Desconto1");
                    lindv.PrecoUnitario = objListLin.Valor("LinhasDoc.PrecUnit");
                    lindv.TotalILiquido = objListLin.Valor("LinhasDoc.TotalILiquido");
                    lindv.TotalLiquido = objListLin.Valor("LinhasDoc.PrecoLiquido");
                    lindv.IVA = objListLin.Valor("Iva.Taxa");
                    listlindv.Add(lindv);
                    objListLin.Seguinte();
                }

                dv.LinhasDoc = listlindv;
                return dv;
            }
            return null;
        }

        //retorna lista de encomendas feitas por um cliente
        public static List<Model.DocVenda> Encomendas_List(string clienteID)
        {

            StdBELista objListCab;
            StdBELista objListLin;
            Model.DocVenda dv = new Model.DocVenda();
            List<Model.DocVenda> listdv = new List<Model.DocVenda>();
            Model.LinhaDocVenda lindv = new Model.LinhaDocVenda();
            List<Model.LinhaDocVenda> listlindv = new
            List<Model.LinhaDocVenda>();

            if (PriEngine.InitializeCompany(SINF.Properties.Settings.Default.Company.Trim(), SINF.Properties.Settings.Default.User.Trim(), SINF.Properties.Settings.Default.Password.Trim()) == true)
            {
                objListCab = PriEngine.Engine.Consulta("SELECT id, Entidade, Data, NumDoc, TotalMerc, TotalIva, Serie From CabecDoc where TipoDoc='ECL' AND Entidade = '" + clienteID + "' ORDER BY Data DESC, NumDoc DESC");
                while (!objListCab.NoFim())
                {
                    dv = new Model.DocVenda();
                    dv.id = objListCab.Valor("id");
                    dv.Entidade = objListCab.Valor("Entidade");
                    dv.NumDoc = objListCab.Valor("NumDoc");
                    dv.Data = objListCab.Valor("Data");
                    dv.TotalMerc = objListCab.Valor("TotalMerc");
                    dv.Serie = objListCab.Valor("Serie");
                    dv.TotalIva = objListCab.Valor("TotalIva");
                    
                    objListLin = PriEngine.Engine.Consulta("SELECT idCabecDoc, Artigo, Descricao, Quantidade, Unidade, PrecUnit, Desconto1, TotalILiquido, PrecoLiquido from LinhasDoc where IdCabecDoc='" + dv.id + "' order By NumLinha");
                    listlindv = new List<Model.LinhaDocVenda>();

                   /* while (!objListLin.NoFim())
                    {
                        lindv = new Model.LinhaDocVenda();
                        lindv.IdCabecDoc = objListLin.Valor("idCabecDoc");
                        lindv.CodArtigo = objListLin.Valor("Artigo");
                        lindv.DescArtigo = objListLin.Valor("Descricao");
                        lindv.Quantidade = objListLin.Valor("Quantidade");
                        lindv.Unidade = objListLin.Valor("Unidade");
                        lindv.Desconto = objListLin.Valor("Desconto1");
                        lindv.PrecoUnitario = objListLin.Valor("PrecUnit");
                        lindv.TotalILiquido = objListLin.Valor("TotalILiquido");
                        lindv.TotalLiquido = objListLin.Valor("PrecoLiquido");

                        listlindv.Add(lindv);
                        objListLin.Seguinte();
                    }

                    dv.LinhasDoc = listlindv;*/
                    listdv.Add(dv);
                    objListCab.Seguinte();
                }
            }
            return listdv;
        }


        //retorna encomenda feita por um cliente
        public static Model.DocVenda Encomenda_Cliente(string clienteId, string docVendaId)
        {

            StdBELista objListCab;
            StdBELista objListLin;
            Model.DocVenda dv = null;            
            Model.LinhaDocVenda lindv = new Model.LinhaDocVenda();
            List<Model.LinhaDocVenda> listlindv = new List<Model.LinhaDocVenda>();

            if (PriEngine.InitializeCompany(SINF.Properties.Settings.Default.Company.Trim(), SINF.Properties.Settings.Default.User.Trim(), SINF.Properties.Settings.Default.Password.Trim()) == true)
            {
                objListCab = PriEngine.Engine.Consulta("SELECT * From CabecDoc where TipoDoc='ECL' AND Entidade = '" + clienteId + "' AND id='"+docVendaId+"'");
                if (!objListCab.NoFim())
                {
                    dv = new Model.DocVenda();
                    dv.id = objListCab.Valor("id");
                    dv.Entidade = objListCab.Valor("Entidade");
                    dv.NumDoc = objListCab.Valor("NumDoc");
                    dv.Data = objListCab.Valor("Data");
                    dv.TotalMerc = objListCab.Valor("TotalMerc");
                    dv.Serie = objListCab.Valor("Serie");

                    objListLin = PriEngine.Engine.Consulta("SELECT ld.idCabecDoc, ld.Artigo, ld.Descricao, ld.Quantidade, ld.Unidade, ld.Desconto1, ld.PrecUnit, ld.TotalILiquido, ld.PrecoLiquido, i.Taxa from LinhasDoc as ld JOIN Iva as i ON i.Iva = ld.CodIva where ld.IdCabecDoc='" + dv.id + "' order By ld.NumLinha");
                    listlindv = new List<Model.LinhaDocVenda>();

                    while (!objListLin.NoFim())
                    {
                        lindv = new Model.LinhaDocVenda();
                        lindv.IdCabecDoc = objListLin.Valor("idCabecDoc");
                        lindv.CodArtigo = objListLin.Valor("Artigo");
                        lindv.DescArtigo = objListLin.Valor("Descricao");
                        lindv.Quantidade = objListLin.Valor("Quantidade");
                        lindv.Unidade = objListLin.Valor("Unidade");
                        lindv.Desconto = objListLin.Valor("Desconto1");
                        lindv.PrecoUnitario = objListLin.Valor("PrecUnit");
                        lindv.TotalILiquido = objListLin.Valor("TotalILiquido");
                        lindv.TotalLiquido = objListLin.Valor("PrecoLiquido");
                        lindv.IVA = objListLin.Valor("Taxa");

                        listlindv.Add(lindv);
                        objListLin.Seguinte();
                    }

                    dv.LinhasDoc = listlindv;
                    return dv;
                }
                else return null;
            }
            return null;

        }

        #endregion DocsVenda


    }
}