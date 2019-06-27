using C_R_M.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;

namespace C_R_M.Controllers
{
    public class PermisoAttribute : ActionFilterAttribute
    {
        public RolesPermisos Permiso { get; set; }
        public String Modulo { get; set; }
        public override void OnActionExecuting(ActionExecutingContext filterContext)
        {
            base.OnActionExecuting(filterContext);
            if (Permiso == RolesPermisos.None)
            {
                switch (filterContext.ActionDescriptor.ActionName)
                {
                    case "Create":
                        Permiso = RolesPermisos.Crear_Registro;
                        break;
                    case "Details":
                        Permiso = RolesPermisos.Visualizar_Registro;
                        break;
                    case "Edit":
                        Permiso = RolesPermisos.Editar_Registro;
                        break;
                    case "Delete":
                        Permiso = RolesPermisos.Eliminar_Registro;
                        break;
                    default:
                        Modulo = filterContext.ActionDescriptor.ControllerDescriptor.ControllerName + "-" + filterContext.ActionDescriptor.ActionName;
                        Permiso = RolesPermisos.Permiso;
                        break;
                }
            }
            if (!FrontUser.TienePermiso(Modulo ?? filterContext.ActionDescriptor.ControllerDescriptor.ControllerName, Permiso))
            {
                filterContext.Result = new RedirectToRouteResult(new RouteValueDictionary(new
                {
                    controller = "Login",
                    action = "Index"
                }));
            }
            Permiso = RolesPermisos.None;
        }
    }

}