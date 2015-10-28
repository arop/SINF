<%@ Page Language="C#" AutoEventWireup="true" CodeFile="FormArtigos.aspx.cs" Inherits="FormArtigos" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link rel="stylesheet" href="Content/bootstrap.min.css" />
</head>
<body>
    <div class="container">

        <div class="row">

            <div class="col-lg-12 col-md-12 col-sm-12 col-sm-12">
                <h3>Adicionar artigo </h3>
                <div id="formNovoArtigo-container">
                    <form id="formNovoArtigo" runat="server" method="POST">
                        <label> Categoria Artigo:  </label> <br/>
                        <input type="text" name="catArtigo" /> <br/>
                        <label> Descrição Artigo:  </label> <br/>
                        <input type="text" name="descArtigo" /> <br/>
                        <label> Preço Artigo: </label> <br/>
                        <input type="number" step="any" name="pvpArtigo" /> <br/>
                        <label> Marca Artigo: </label> <br/>
                        <input type="text" name="marcaArtigo" /> <br/>
                        <label> Modelo Artigo: </label> <br/>
                        <input type="text" name="modeloArtigo" /> <br/>
                        <label> Peso Artigo: </label> <br/>
                        <input type="number" step="any" name="pesoArtigo" /> <br/><br />
                        <input type="submit" value="Adicionar" />
                    </form>
                </div>
            </div>



        </div>
    </div>
</body>
<script type="text/javascript" src="Scripts/jquery-1.10.2.js"></script>
<script type="text/javascript" src="Scripts/bootstrap.min.js"></script>
<script type="text/javascript" src="Scripts/FormAdicionarArtigo.js"></script>

</html>
