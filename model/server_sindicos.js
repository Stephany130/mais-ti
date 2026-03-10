const express = require('express');
const mysql   = require('mysql2/promise');
/***
    Por meio da rota endereço_do_servidor:porta/moradores, o cliente pode:
    - GET /moradores: obter a lista de moradores
    - GET /moradores/:id: obter os detalhes de um morador específico
    - POST /moradores: criar um novo morador (enviando JSON com nome, telefone e cpf)
    - PUT /moradores/:id: atualizar um morador existente (enviando JSON com nome, telefone e cpf)
    - DELETE /moradores/:id: remover um morador
*/
module.exports = function(dbConfig) {
    const router = express.Router();
    const pool   = mysql.createPool(dbConfig);
    
    router.get('/', async (req, res) => {
        try {
            const [rows] = await pool.query('SELECT * FROM sindicos');
            res.json(rows);
        } catch (err) {
            res.status(500).json({ error: err.message });
        }
    });

    router.get('/:id', async (req, res) => {
        const id = parseInt(req.params.id, 10);
        try {
            const [rows] = await pool.query(
                'SELECT * FROM sindicos WHERE id_sindicos = ?',
                [id]
            );
            if (rows.length === 0)
                return res.status(404).json({ error: 'sindicos não encontrado' });
            res.json(rows[0]);
        } catch (err) {
            res.status(500).json({ error: err.message });
        }
    });

    router.post('/', express.json(), async (req, res) => {
        const { cpf, nome, senha, email } = req.body;
        try {
            const [result] = await pool.query(
                'INSERT INTO sindicos (cpf, nome, senha, email) VALUES (?,?,?)',
                [cpf, nome, senha, email]
            );
            const [rows] = await pool.query(
                'SELECT * FROM sindicos WHERE id_sindicos = ?',
                [result.insertId]
            );
            res.status(201).json(rows[0]);
        } catch (err) {
            res.status(500).json({ error: err.message });
        }
    });

    router.put('/:id', express.json(), async (req, res) => {
        const id = parseInt(req.params.id, 10);
        const { cpf, nome, senha, email } = req.body;
        try {
            const [result] = await pool.query(
                'UPDATE sindicos SET nome = ?, telefone = ?, cpf = ? WHERE id_sindicossss = ?',
                [cpf, nome, senha, email, id]
            );
            if (result.affectedRows === 0)
                return res.status(404).json({ error: 'sindicos não encontrado' });
            const [rows] = await pool.query(
                'SELECT * FROM sindicos WHERE id_sindicos = ?',
                [id]
            );
            res.json(rows[0]);
        } catch (err) {
            res.status(500).json({ error: err.message });
        }
    });

    router.delete('/:id', async (req, res) => {
        const id = parseInt(req.params.id, 10);
        try {
            const [result] = await pool.query(
                'DELETE FROM sindicos WHERE id_sindicos = ?',
                [id]
            );
            if (result.affectedRows === 0)
                return res.status(404).json({ error: 'sindicos não encontrado' });
            res.json({ message: 'Removido' });
        } catch (err) {
            res.status(500).json({ error: err.message });
        }
    });

    return router;
};