const Database = require ('better-sqlite3') // avisa que está usando 

class ConexaoBarco{
    constructor(){ // avisa oq vai usar
        this.db = new Database('loja.db'); //o que está criando um novo objeto
        this_criarTabela();
    }
        _criarTabela(){
            const sql=`
                CREATE TABLE IF NOT EXISTS produto(
                    id Interege PRIMARY KEY AUTOINCREMENT,
                    nome TEXT NOT NULL,
                    preco REAL NOT,
                    quantidade INTERGER NOT NULL
                )` // USAR A CRASE NO INÍCIO E FINAL DO TEXTO   
                ;
                 this.db.prepare(sql).run(); //manda o comando para o banco    executa o comando preparado 
        }
    }
    // Exportamos a conexão ára ser usada nos outros arquivos, envia o que estiver escrito depois do = para o estoque, nesse caso a variavel db
    module.export = new ConexaoBarco().db;
