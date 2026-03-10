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
            const [rows] = await pool.query('SELECT * FROM moradores');
            res.json(rows);
        } catch (err) {
            res.status(500).json({ error: err.message });
        }
    });

    router.get('/:id', async (req, res) => {
        const id = parseInt(req.params.id, 10);
        try {
            const [rows] = await pool.query(
                'SELECT * FROM moradores WHERE id_morador = ?',
                [id]
            );
            if (rows.length === 0)
                return res.status(404).json({ error: 'Morador não encontrado' });
            res.json(rows[0]);
        } catch (err) {
            res.status(500).json({ error: err.message });
        }
    });

    router.post('/', express.json(), async (req, res) => {
        const { nome, telefone, cpf } = req.body;
        try {
            const [result] = await pool.query(
                'INSERT INTO moradores (nome, telefone, cpf) VALUES (?,?,?)',
                [nome, telefone, cpf]
            );
            const [rows] = await pool.query(
                'SELECT * FROM moradores WHERE id_morador = ?',
                [result.insertId]
            );
            res.status(201).json(rows[0]);
        } catch (err) {
            res.status(500).json({ error: err.message });
        }
    });

    router.put('/:id', express.json(), async (req, res) => {
        const id = parseInt(req.params.id, 10);
        const { nome, telefone, cpf } = req.body;
        try {
            const [result] = await pool.query(
                'UPDATE moradores SET nome = ?, telefone = ?, cpf = ? WHERE id_morador = ?',
                [nome, telefone, cpf, id]
            );
            if (result.affectedRows === 0)
                return res.status(404).json({ error: 'Morador não encontrado' });
            const [rows] = await pool.query(
                'SELECT * FROM moradores WHERE id_morador = ?',
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
                'DELETE FROM moradores WHERE id_morador = ?',
                [id]
            );
            if (result.affectedRows === 0)
                return res.status(404).json({ error: 'Morador não encontrado' });
            res.json({ message: 'Removido' });
        } catch (err) {
            res.status(500).json({ error: err.message });
        }
    });

    return router;
};