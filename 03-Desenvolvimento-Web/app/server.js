// servidor principal que importa e "cola" os roteadores de cada entidade

const express = require('express');
const path = require('path');

// carregando credenciais do banco a partir de secrets/db-config.js
const dbConfig = require('../secrets/db-config');

// os routers residem em ../back em relação a este ficheiro
const loginRouter      = require('../controller/server_login')(dbConfig);       // trata /login
const moradoresRouter  = require('../model/server_moradores')(dbConfig); // trata /moradores
//const sindicosRouter   = require('../model/server_sindicos')(dbConfig); // trata /sindicos
//const prediosRouter    = require('../model/server_predios')(dbConfig); // trata /predios
//const apartamentosRouter = require('../model/server_apartamentos')(dbConfig); // trata /apartamentos
//const receitasRouter   = require('../model/server_receitas')(dbConfig); // trata /receitas
//const contatosRouter   = require('../model/server_contatos')(dbConfig); // trata /contatos
//const documentosRouter = require('../model/server_documentos')(dbConfig); // trata /documentos
//const despesasRouter   = require('../model/server_despesas')(dbConfig); // trata /despesas

const app = express();
const port = 3001;

// serve arquivos estáticos (HTML, CSS, JS) a partir da pasta view
app.use(express.static(path.join(__dirname, '..', 'view')));

// encaminha as rotas para os módulos correspondentes
app.use('/', loginRouter);
app.use('/moradores', moradoresRouter);
//app.use('/sindicos', sindicosRouter);
//app.use('/predios', prediosRouter);
//app.use('/apartamentos', apartamentosRouter);
//app.use('/receitas', receitasRouter);
//app.use('/contatos', contatosRouter);
//app.use('/documentos', documentosRouter);
//app.use('/despesas', despesasRouter);

app.listen(port, () => {
    console.log(`Servidor rodando em http://localhost:${port}`);
});
