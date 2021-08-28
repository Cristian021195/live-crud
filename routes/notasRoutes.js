const {Router} = require('express');
const {leerNotas,leerRangoNotas, leerNota, cargarNota, eliminarNota, editarNota} = require('../controllers/notasController');

const router = Router();

router.get('/',leerNotas)

router.get('/:id', leerNota)

router.get('/pagina/:rango', leerRangoNotas)

router.post('/cargar/', cargarNota)

router.delete('/eliminar/:id', eliminarNota)

router.put('/editar/:id', editarNota)


module.exports = router;