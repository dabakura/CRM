using C_R_M.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
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
            Recuerdame = false;
            Modulos = new Modulo[] {
                new Modulo { Titulo = "Empresas", Action = "Index", Controller = "Empresas", Tipo ="Normal", Icono = "fa fa-building" },
                new Modulo { Titulo = "Servicios Vendidos", Action = "Index", Controller = "ServicioEmpresas", Tipo ="Normal", Icono = "fa fa-shopping-bag" },
                new Modulo { Titulo = "Servicios Adquiridos", Action = "Index", Controller = "ServiciosContratados", Tipo ="Normal", Icono = "fa fa-shopping-cart" },
                new Modulo { Titulo = "Contactos", Action = "Index", Controller = "Contactos", Tipo ="Normal", Icono = "fa fa-address-book" },
                new Modulo { Titulo = "Marketing", Action = "Index", Controller = "Marketings", Tipo ="Normal", Icono = "fa fa-comments" },
                new Modulo { Titulo = "Productos", Action = "Index", Controller = "Productos", Tipo ="Normal", Icono = "fa fa-product-hunt" },
                new Modulo { Titulo = "Publicidad", Action = "Index", Controller = "Publicidads", Tipo ="Normal", Icono = "fa fa-facebook-square" },
                new Modulo { Titulo = "Medio Publicitario", Action = "Index", Controller = "MedioPublicitarios", Tipo ="Normal", Icono = "fa fa-medium" },
                new Modulo { Titulo = "Recordatorios", Action = "Index", Controller = "Recordatorios", Tipo ="Normal", Icono = "fa fa-calendar" },
                new Modulo { Titulo = "Estado de Cuenta", Action = "Index", Controller = "EstadodeCuentas", Tipo ="Normal", Icono = "fa fa-th" },
                new Modulo { Titulo = "Roles y Permisos", Action = "Index", Controller = "Rols", Tipo ="Normal", Icono = "fa fa-lock" },
                new Modulo { Titulo = "Reportes", Action = "Index", Controller = "Report", Tipo ="Normal", Icono = "fa fa-file" },
                new Modulo { Titulo = "Movimientos", Action = "Index", Controller = "Movimientos", Tipo ="Proceso", Icono = "fa fa-bar-chart" },
                new Modulo { Titulo = "Usuarios", Action = "Index", Controller = "Usuarios", Tipo ="Proceso", Icono = "fa fa-users" }
            };
        }
        public static AccountController Account => accountController ?? (accountController = new AccountController());

        public Usuario GetUser { get { return (HttpContext.Current.Session["user"] == null) ? null : db.Usuario.ToList().Find(u => u.Id_Usuario == Convert.ToInt32(HttpContext.Current.Session["user"])); } }
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
            var User = db.Usuario.ToList().Find(u => u.Correo == login.Email && u.Contraseña == Seguridad.Encripta(login.Password));
            if (User != null)
                HttpContext.Current.Session["user"] = User.Id_Usuario;
            else
                HttpContext.Current.Session["user"] = null;
            Recuerdame = login.RememberMe;
            if (Recuerdame && User != null)
                HttpContext.Current.Session["userid"] = User.Id_Usuario;
            else
                HttpContext.Current.Session["userid"] = null;
            return User != null;
        }
        // GET: Account
        public void CerrarSesion()
        {
            HttpContext.Current.Session["user"] = null;
            if (!Recuerdame)
                HttpContext.Current.Session["userid"] = null;
        }

        public bool Registrado()
        {
            if (HttpContext.Current.Session["userid"] != null)
            {
                HttpContext.Current.Session["user"] = HttpContext.Current.Session["userid"];
                return true;
            }
            return false;
        }

        public LoginModel Model()
        {
            return new LoginModel
            {
                Email = GetUser.Correo,
                Password = Seguridad.Desencripta(GetUser.Contraseña),
                RememberMe = true
            };
        }
    }
}