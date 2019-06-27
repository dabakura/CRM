using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace C_R_M.Models
{
    public enum RolesPermisos
    {
        #region Permisos
        None = 0,
        Crear_Registro = 1,
        Eliminar_Registro = 2,
        Visualizar_Registro = 3,
        Editar_Registro = 4,
        Permiso = 5
        #endregion
    }
}