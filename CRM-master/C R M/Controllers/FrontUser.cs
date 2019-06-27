using C_R_M.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.Entity;

namespace C_R_M.Controllers
{
    public class FrontUser
    {
        public static bool TienePermiso(String Modulo, RolesPermisos valor)
        {
            try
            {
                var usuario = FrontUser.Get();
                switch (valor)
                {
                    case RolesPermisos.Crear_Registro:
                        return usuario.Rol.PermisoRol.Where(x => x.Modulo.Equals(Modulo) && x.Permiso.Crear).Any();
                    case RolesPermisos.Eliminar_Registro:
                        return usuario.Rol.PermisoRol.Where(x => x.Modulo.Equals(Modulo) && x.Permiso.Eliminar).Any();
                    case RolesPermisos.Visualizar_Registro:
                        return usuario.Rol.PermisoRol.Where(x => x.Modulo.Equals(Modulo) && x.Permiso.Mostrar).Any();
                    case RolesPermisos.Editar_Registro:
                        return usuario.Rol.PermisoRol.Where(x => x.Modulo.Equals(Modulo) && x.Permiso.Editar).Any();
                    case RolesPermisos.Permiso:
                        return usuario.Rol.PermisoRol.Where(x => x.Modulo.Equals(Modulo) && x.Permiso.Crear && x.Permiso.Editar && x.Permiso.Mostrar && x.Permiso.Eliminar).Any();
                    default:
                        return false;
                }
            }
            catch 
            {
                return false;
            }
        }
        public static Usuario Get()
        {
            CRMEntities db = new CRMEntities();
            return db.Usuario.Include(u => u.Rol).Include(u => u.Rol.PermisoRol).Include(u => u.Rol.PermisoRol)
                .First(u => u.Id_Usuario == AccountController.Account.GetUser.Id_Usuario);
        }
    }

}