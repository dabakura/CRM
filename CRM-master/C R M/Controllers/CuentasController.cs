using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using C_R_M.Models;

namespace C_R_M.Controllers
{
    [PermisoAttribute]
    public class CuentasController : Controller
    {
        private CRMEntities db = new CRMEntities();

        // GET: Cuentas
        public ActionResult Index(int id,TipoConsulta tipo)
        {
            if (AccountController.Account.GetUser == null)
                return RedirectPermanent("Login/Index");
            var cuenta = db.Cuenta.Include(c => c.ServicioEmpresa).Include(s => s.ServicioEmpresa.Producto).Where(c=>c.Servicio_Empresa == id);
            ViewBag.Servicio = id;
            ViewBag.Tipo = tipo;
            ViewBag.Volver = (tipo == TipoConsulta.InternaCuenta) ? "ServiciosContratados" : "ServicioEmpresas";
            return View(cuenta.ToList());
        }

        // GET: Cuentas/Details/5
        public ActionResult Details(int? id, TipoConsulta tipo)
        {
            if (AccountController.Account.GetUser == null)
                return RedirectPermanent("Login/Index");
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Cuenta cuenta = db.Cuenta.Find(id);
            if (cuenta == null)
            {
                return HttpNotFound();
            }
            ViewBag.Tipo = tipo;
            return View(cuenta);
        }

        // GET: Cuentas/Create
        public ActionResult Create(int id)
        {
            if (AccountController.Account.GetUser == null)
                return RedirectPermanent("Login/Index");
            ViewBag.Servicio = id;
            ViewBag.Servicio_Empresa = new SelectList(db.ServicioEmpresa.Include( s=>s.Producto).Where(s=>s.Id_Servicio_Empresa == id).ToList(), "Id_Servicio_Empresa", "Producto.Nombre");
            Cuenta cuenta = new Cuenta { Fecha_Pago = DateTime.Now };
            return View(cuenta);
        }

        // POST: Cuentas/Create
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que desea enlazarse. Para obtener 
        // más información vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "Servicio_Empresa,Fecha_Pago,Monto_Abono,Monto_Pendiente,Descripcion")] Cuenta cuenta)
        {
            if (AccountController.Account.GetUser == null)
                return RedirectPermanent("Login/Index");
            if (ModelState.IsValid)
            {
                db.Cuenta.Add(cuenta);
                db.SaveChanges();
                return RedirectToAction("Index", new { id = cuenta.Servicio_Empresa, tipo = TipoConsulta.ActorizadaCuenta});
            }

            ViewBag.Servicio_Empresa = new SelectList(db.ServicioEmpresa.Where(s => s.Id_Servicio_Empresa == cuenta.Servicio_Empresa).ToList(), "Id_Servicio_Empresa", "Descripcion");
            return View(cuenta);
        }

        // GET: Cuentas/Edit/5
        public ActionResult Edit(int? id)
        {
            if (AccountController.Account.GetUser == null)
                return RedirectPermanent("Login/Index");
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Cuenta cuenta = db.Cuenta.Find(id);
            if (cuenta == null)
            {
                return HttpNotFound();
            }
            return View(cuenta);
        }

        // POST: Cuentas/Edit/5
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que desea enlazarse. Para obtener 
        // más información vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "Id_Cuenta,Servicio_Empresa,Fecha_Pago,Monto_Abono,Monto_Pendiente,Descripcion")] Cuenta cuenta)
        {
            if (AccountController.Account.GetUser == null)
                return RedirectPermanent("Login/Index");
            if (ModelState.IsValid)
            {
                db.Entry(cuenta).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index", new { id = cuenta.Servicio_Empresa, tipo = TipoConsulta.ActorizadaCuenta });
            }
            return View(cuenta);
        }

        // GET: Cuentas/Delete/5
        public ActionResult Delete(int? id)
        {
            if (AccountController.Account.GetUser == null)
                return RedirectPermanent("Login/Index");
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Cuenta cuenta = db.Cuenta.Find(id);
            if (cuenta == null)
            {
                return HttpNotFound();
            }
            return View(cuenta);
        }

        // POST: Cuentas/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            if (AccountController.Account.GetUser == null)
                return RedirectPermanent("Login/Index");
            Cuenta cuenta = db.Cuenta.Find(id);
            db.Cuenta.Remove(cuenta);
            db.SaveChanges();
            return RedirectToAction("Index", new { id = cuenta.Servicio_Empresa, tipo = TipoConsulta.ActorizadaCuenta });
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }
    }
}
