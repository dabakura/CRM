using C_R_M.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Helpers;
using System.Web.Mvc;

namespace C_R_M.Controllers
{
    public class AccountController
    {
        private CRMEntities db;

        private static AccountController accountController;
        private bool Recuerdame;

        private AccountController()
        {
            this.db = new CRMEntities();
            GetUser = null;
            Recuerdame = false;
            Modulos = new Modulo[] {
                new Modulo { Titulo = "Empresas", Action = "Index", Controller = "Empresas", Tipo ="Normal", Icono = "fa fa-table" },
                new Modulo { Titulo = "Servicios Vendidos", Action = "Index", Controller = "ServicioEmpresas", Tipo ="Normal", Icono = "fa fa-table" },
                new Modulo { Titulo = "Servicios Acquiridos", Action = "Index", Controller = "ServiciosContratados", Tipo ="Normal", Icono = "fa fa-table" },
                new Modulo { Titulo = "Contactos", Action = "Index", Controller = "Contactoes", Tipo ="Normal", Icono = "fa fa-table" },
                new Modulo { Titulo = "Marketing", Action = "Index", Controller = "Marketings", Tipo ="Normal", Icono = "fa fa-envelope" },
                new Modulo { Titulo = "Productos", Action = "Index", Controller = "Productoes", Tipo ="Normal", Icono = "fa fa-th" },
                new Modulo { Titulo = "Publicidad", Action = "Index", Controller = "Publicidads", Tipo ="Normal", Icono = "fa fa-archive" },
                new Modulo { Titulo = "Recordatorios", Action = "Index", Controller = "Recordatorios", Tipo ="Normal", Icono = "fa fa-calendar" },
                new Modulo { Titulo = "Estado de Cuenta", Action = "Index", Controller = "EstadodeCuentas", Tipo ="Normal", Icono = "fa fa-th" },
                new Modulo { Titulo = "Roles y Permisos", Action = "Index", Controller = "Rols", Tipo ="Normal", Icono = "fa fa-th" },
                new Modulo { Titulo = "Movimientos", Action = "Index", Controller = "Movimientoes", Tipo ="Proceso", Icono = "fa fa-circle-o" },
                new Modulo { Titulo = "Usuarios", Action = "Index", Controller = "Usuarios", Tipo ="Proceso", Icono = "fa fa-circle-o" },
                new Modulo { Titulo = "Recordatorios", Action = "Index", Controller = "Recordatorios", Tipo ="Proceso", Icono = "fa fa-circle-o" },
            };
        }
        public static AccountController Account => accountController ?? (accountController = new AccountController());

        public Usuario GetUser { get; set; }
        private Modulo[] Modulos { get; set; }

        public Modulo[] Get_Modulos(string tipo)
        {
            return Modulos.Where(m => PermisoFilter(tipo, m)).ToArray();
        }

        private bool PermisoFilter(string tipo, Modulo modulo)
        {
            if (modulo.Tipo == tipo)
                return FrontUser.TienePermiso(modulo.Controller +"-"+ modulo.Action, RolesPermisos.Permiso);
            return false;
        }
        public bool IniciarSesion(LoginModel login)
        {
            GetUser = db.Usuario.ToList().Find(u => u.Correo == login.Email && u.Contraseña == login.Password);
            Recuerdame = login.RememberMe;
            if (Recuerdame && GetUser != null)
                HttpContext.Current.Session["userid"] = GetUser.Id_Usuario;
            else
                HttpContext.Current.Session["userid"] = null;
            return GetUser != null;
        }
        // GET: Account
        public void CerrarSesion()
        {
            GetUser = null;
            if (!Recuerdame)
                HttpContext.Current.Session["userid"] = null;
        }

        public bool Registrado()
        {
            if (HttpContext.Current.Session["userid"] != null)
            {
                GetUser = db.Usuario.ToList().Find(u => u.Id_Usuario == (int)HttpContext.Current.Session["userid"]);
                return true;
            }
            return false;
        }

        public LoginModel Model()
        {
            return new LoginModel
            {
                Email = GetUser.Correo,
                Password = GetUser.Contraseña,
                RememberMe = true
            };
        }
    }
}