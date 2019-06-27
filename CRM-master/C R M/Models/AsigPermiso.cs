using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace C_R_M.Models
{
    public class AsigPermiso
    {

        public AsigPermiso(PermisoRol permiso)
        {
            if(permiso.Modulo.Split('-').Length > 1){
                Tipo = "Metodo";
                Modulo = permiso.Modulo.Split('-')[0];
                Accion = permiso.Modulo.Split('-')[1];
                Autorizado = permiso.Permiso.Crear && permiso.Permiso.Editar && permiso.Permiso.Eliminar && permiso.Permiso.Mostrar;
            }
            else
            {
                Tipo = "Recurso";
                Modulo = permiso.Modulo;
                Accion = "";
                Crear = permiso.Permiso.Crear;
                Editar = permiso.Permiso.Editar;
                Eliminar = permiso.Permiso.Eliminar;
                Mostrar = permiso.Permiso.Mostrar;
            }

        }

        public AsigPermiso(string modulo, bool crear, bool editar, bool eliminar, bool mostrar)
        {
            Modulo = modulo;
            Accion = "";
            Tipo = "Recurso";
            Autorizado = false;
            Crear = crear;
            Editar = editar;
            Eliminar = eliminar;
            Mostrar = mostrar;
        }

        public AsigPermiso(string modulo, string accion, bool autorizado)
        {
            Modulo = modulo;
            Accion = accion;
            Tipo = "Metodo";
            Autorizado = autorizado;
            Crear = false;
            Editar = false;
            Eliminar = false;
            Mostrar = false;
        }

        public String Modulo { get; set; }

        public String Accion { get; set; }

        public String Tipo { get; set; }

        public bool Autorizado { get; set; }
        public bool Crear { get; set; }
        public bool Editar { get; set; }
        public bool Eliminar { get; set; }
        public bool Mostrar { get; set; }
    }
}