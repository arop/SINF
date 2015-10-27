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
        
            <div class="col-lg-6 col-md-6 col-sm-12 col-sm-12">
                <h3>Simulação de compra</h3>
                <div id="form1-container">
                    <form id="form1" runat="server">
                        <input type="submit" value="Obter produtos" />
                    </form>
                </div>
            </div>

            <div class="col-lg-6 col-md-6 col-sm-12 col-sm-12">
                <div id="search-container">
                    <h3>Pesquisa de artigos</h3>
                            
                    <form id="form2" >
                        <input type="text" />
                        <input type="submit" value="Procurar" />
                    </form>

                    <div id="search-results"></div>
                </div>
            </div>

        </div>
    </div>
</body>
     <script type="text/javascript" src="Scripts/jquery-1.10.2.js"></script>
    <script type="text/javascript" src="Scripts/bootstrap.min.js"></script>
     <script type="text/javascript" src="Scripts/FormTestInterop.js"></script>
</html>
