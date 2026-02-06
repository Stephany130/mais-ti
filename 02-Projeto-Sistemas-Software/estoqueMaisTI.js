const db = rquiere ('./datebase');
const prompt = require ('prompt-sync')();


cadastrar (nm , pc , qtde){
    
    const sql= `
    INSERT INTO produtos
    (nome, preco, qunatidade)
    VALUES(?,?,?)`;

    db.prepare (sql).run(nm, pc, qtde); //(nm, pc, qtde); vão ocutat o lugar das interrogações
    
}