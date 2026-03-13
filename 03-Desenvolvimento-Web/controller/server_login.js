const express = require('express');
const mysql   = require('mysql2/promise');

/***
 * Roteador de autenticação.
 * 
 * O cliente pode:
 * - GET /login?login=...&senha=...  – valida credenciais de síndico.
 *   redireciona para index.html ou volta para login.html com fail=1.
 * 
 * Obs.: recebe `dbConfig` para criação de pool; não há outras rotas.
 */
module.exports = function(dbConfig) {
    const router = express.Router();
    const pool   = mysql.createPool(dbConfig);

    /*
     * GET /login
     * verifica se existe um síndico com email+senha iguais aos fornecidos
     * nas query params; redireciona para index ou volta para o formulário.
     */
    router.get('/login', async (req, res) => {
        const { login, senha } = req.query;

        try {
            const [rows] = await pool.query(
                'SELECT * FROM sindicos WHERE email = ? AND senha = ?',
                [login, senha]
            );
            if (rows.length === 1) {
                return res.redirect('/index.html');
            }
            return res.redirect('/login.html?fail=1');
        } catch (err) {
            console.error(err);
            return res.status(500).send('Erro interno');
        }
    });

    return router;
};