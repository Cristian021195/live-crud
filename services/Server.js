const express = require('express');
const cors = require('cors');
const sequelize = require('../config/connect');

//rutas
const notas = require('../routes/notasRoutes');


class Server{
    constructor(port){
        this.app = express();

        this.app.set('port', process.env.PORT || port)

        this.conectarDB()

        this.middlewares()

        this.routes()
    }
    async conectarDB(){
        try {
            await sequelize.authenticate();
            console.log('Connection has been established successfully.');          
        }catch(error){
            console.log('Error al conectar BBDD')
        }
    }
    middlewares(){
        this.app.use(express.json());
        this.app.use(cors());
    }

    routes(){
        this.app.use('/api/notas', notas)
    }

    listen(){
        this.app.listen(this.app.get('port'), ()=>{
            console.log('Servidor corriendo en puerto', this.app.get('port'));
        })
    }
}

module.exports = Server;