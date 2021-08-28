const {request:req, response:res} = require('express');
//const {genSaltSync, hashSync} = require('bcryptjs');
const Notas = require('../models/notas');

async function leerNotas(req, res){
    //const notas = await Notas.findAll({attributes: [`id`, `contenido`, `usuario`]});//fuerza a que creemos los campos createdAt y updatedAt
    //const notas = await Notas.findAll({attributes: { exclude: ['createdAt', 'updatedAt'] }});
    try {
        const notas = await Notas.findAll();    
        res.send({
            notas
        });    
    } catch (error) {
        res.send({
            error
        });
    }
    
}

async function leerRangoNotas(req, res){
    let rango = req.params.rango.split('-').map(e=>parseInt(e));
    try {
        const notas = await Notas.findAll({ offset: rango[0], limit: rango[1] });
        res.send({
            notas: notas.length === 0 ? {error:'Rango incorrecto'} : notas
        });    
    } catch (error) {
        res.send({
            error
        });
    }
    
}//Project.findAll({ offset: 5, limit: 5 });

async function leerNota(req, res){
    try {
        const nota = await Notas.findAll({
            where:{
                id:req.params.id
            }
        });
        res.send({
            nota: nota.length === 1 ? nota[0] : {error:'No existe dicha nota'}
        });
    } catch (error) {
        res.send({
            error
        });
    }
}

async function cargarNota(req, res){
    try {
        const data = await Notas.create({ attributes: { exclude: ['createdAt', 'updatedAt'] },contenido: req.body.contenido, usuario: req.body.usuario });
        res.send({
            data,
        });
    } catch (error) {
        res.send({
            error
        });
    }
        
}

async function eliminarNota(req,res){
    try {
        let data = await Notas.destroy({
            where: {
                id: req.body.id
            }
        });
        res.send({
            data
        });    
    } catch (error) {
        res.send({
            error
        });
    }
    
}

async function editarNota(req, res){
    try {
        let data = await Notas.update(
            {
                contenido: req.body.contenido,
                usuario: req.body.usuario 
            },
            {
                where: {
                    id: req.params.id,
                }
            }
        );
        res.send({
            data: data[0] === 0 ? 'Error al editar' : 'ok'
        });
    } catch (error) {
        res.send({
            error
        });
    }    
}

module.exports = {
    leerNotas,
    leerRangoNotas,
    leerNota,
    cargarNota,
    eliminarNota,
    editarNota
};