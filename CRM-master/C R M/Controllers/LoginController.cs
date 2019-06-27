using C_R_M.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace C_R_M.Controllers
{
    public class LoginController : Controller
    {
        // GET: Login
        [HttpGet]
        public ActionResult Index()
        {
            if (AccountController.Account.Registrado())
            {
                return View(AccountController.Account.Model());
            }
            return View();
        }

        [HttpPost]
        public ActionResult Index([Bind(Include = "Email,Password,RememberMe")] LoginModel model)
        {
            if (ModelState.IsValid)
            {
                if (AccountController.Account.IniciarSesion(model))
                {
                    return RedirectToAction("Index", "Home");
                }
                ModelState.AddModelError("", "Intento de inicio de sesión no válido.");
            }
            return View();
        }

        // GET: Logout
        [HttpGet]
        public ActionResult Logout()
        {
            AccountController.Account.CerrarSesion();
            return RedirectToAction("Index");
        }

    }
}