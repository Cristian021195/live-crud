const { Sequelize, DataTypes } = require('sequelize');
const sequelize = require('../config/connect');
const Notas = sequelize.define("notas", {
    contenido: {
        type: DataTypes.TEXT,
        allowNull: false
    },
    usuario: {
        type: DataTypes.TEXT
    },
},{
    timestamps: false,
    createdAt: false,
    updatedAt: false
}
);
module.exports = Notas;