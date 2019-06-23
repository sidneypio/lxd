<html>
    <head>
	    <meta http-equiv="content-type" content="text/html; charset=utf-8"/>
        <title>Página exemplo de INF572</title>
    </head>

    <body>
        <h1>Página exemplo</h1>

        Dados da conexão: <br><br>
        IP de origem: <?php echo $_SERVER['REMOTE_ADDR'];?> <br>
        Brower de origem: <?php echo $_SERVER['HTTP_USER_AGENT'];?> <br>
        <hr>
        IP do servidor:  <?php echo $_SERVER['SERVER_ADDR'];?> <br>
        Servidor http: <?php echo $_SERVER['SERVER_SOFTWARE'];?> <br>
        Porta do servidor: <?php echo $_SERVER['SERVER_PORT'];?> <br>
        <hr>
    </body>
</html>