using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Threading.Tasks;
using System.Net;
using System.Web;
using System.Web.Mvc;
using C_R_M.Models;

namespace C_R_M.Controllers
{
    [PermisoAttribute]
    public class MovimientoesController : Controller
    {
        private CRMEntities db = new CRMEntities();

        // GET: Movimientoes
        public async Task<ActionResult> Index()
        {
            if (AccountController.Account.GetUser == null)
                return RedirectPermanent("Login/Index");
            return View(await db.Movimiento.ToListAsync());
        }

        // GET: Movimientoes/Details/5
        public async Task<ActionResult> Details(int? id)
        {
            if (AccountController.Account.GetUser == null)
                return RedirectPermanent("Login/Index");
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Movimiento movimiento = await db.Movimiento.FindAsync(id);
            if (movimiento == null)
            {
                return HttpNotFound();
            }
            return View(movimiento);
        }

        // GET: Movimientoes/Create
        public ActionResult Create()
        {
            if (AccountController.Account.GetUser == null)
                return RedirectPermanent("Login/Index");
            Movimiento movimiento = new Movimiento { Fecha = DateTime.Now };
            return View(movimiento);
        }

        // POST: Movimientoes/Create
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que desea enlazarse. Para obtener 
        // más información vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> Create([Bind(Include = "Id_Movimiento,Tipo,Monto,Detalle,Fecha")] Movimiento movimiento)
        {
            if (AccountController.Account.GetUser == null)
                return RedirectPermanent("Login/Index");
            if (ModelState.IsValid)
            {
               // movimiento.Fecha = DateTime.Now;
                db.Movimiento.Add(movimiento);
                await db.SaveChangesAsync();
                return RedirectToAction("Index");
            }

            return View(movimiento);
        }

        // GET: Movimientoes/Edit/5
        public async Task<ActionResult> Edit(int? id)
        {
            if (AccountController.Account.GetUser == null)
                return RedirectPermanent("Login/Index");
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Movimiento movimiento = await db.Movimiento.FindAsync(id);
            if (movimiento == null)
            {
                return HttpNotFound();
            }
            return View(movimiento);
        }

        // POST: Movimientoes/Edit/5
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que desea enlazarse. Para obtener 
        // más información vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> Edit([Bind(Include = "Id_Movimiento,Tipo,Monto,Detalle,Fecha")] Movimiento movimiento)
        {
            if (AccountController.Account.GetUser == null)
                return RedirectPermanent("Login/Index");
            if (ModelState.IsValid)
            {
                db.Entry(movimiento).State = EntityState.Modified;
                await db.SaveChangesAsync();
                return RedirectToAction("Index");
            }
            return View(movimiento);
        }

        // GET: Movimientoes/Delete/5
        public async Task<ActionResult> Delete(int? id)
        {
            if (AccountController.Account.GetUser == null)
                return RedirectPermanent("Login/Index");
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Movimiento movimiento = await db.Movimiento.FindAsync(id);
            if (movimiento == null)
            {
                return HttpNotFound();
            }
            return View(movimiento);
        }

        // POST: Movimientoes/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> DeleteConfirmed(int id)
        {
            if (AccountController.Account.GetUser == null)
                return RedirectPermanent("Login/Index");
            Movimiento movimiento = await db.Movimiento.FindAsync(id);
            db.Movimiento.Remove(movimiento);
            await db.SaveChangesAsync();
            return RedirectToAction("Index");
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
