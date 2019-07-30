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
    public class PublicidadsController : Controller
    {
        private CRMEntities db = new CRMEntities();

        // GET: Publicidads
        public async Task<ActionResult> Index()
        {
            if (AccountController.Account.GetUser == null)
                return RedirectPermanent("Login/Index");
            var publicidad = db.Publicidad.Include(p => p.Empresa).Include(p => p.Empresa.EstadodeCuenta).Include(p => p.MedioPublicitario);
            return View(await publicidad.ToListAsync());
        }

        // GET: Publicidads/Details/5
        public async Task<ActionResult> Details(int? id)
        {
            if (AccountController.Account.GetUser == null)
                return RedirectPermanent("Login/Index");
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Publicidad publicidad = await db.Publicidad.Include(p => p.Empresa).Include(p => p.Empresa.EstadodeCuenta).Include(p => p.MedioPublicitario).FirstAsync(p => p.Id_Publicidad == id.Value);
            if (publicidad == null)
            {
                return HttpNotFound();
            }
            return View(publicidad);
        }

        // GET: Publicidads/Create
        public ActionResult Create()
        {
            if (AccountController.Account.GetUser == null)
                return RedirectPermanent("Login/Index");
            ViewBag.Empresa = new SelectList(db.Empresa, "Id_Empresa", "Nombre");
            ViewBag.Medio = new SelectList(db.MedioPublicitario, "Id_Medio_Publicitario", "Nombre");
            Publicidad publicidad = new Publicidad { Fecha_Caducidad = DateTime.Now, Fecha_Inicio = DateTime.Now };
            return View(publicidad);
        }

        // POST: Publicidads/Create
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que desea enlazarse. Para obtener 
        // más información vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> Create([Bind(Include = "Id_Publicidad,Medio,Id_empresa,Fecha_Inicio,Fecha_Caducidad,Costo")] Publicidad publicidad)
        {
            if (AccountController.Account.GetUser == null)
                return RedirectPermanent("Login/Index");
            if (ModelState.IsValid)
            {
                db.Publicidad.Add(publicidad);
                EstadodeCuenta est = null;
                try
                {
                    est = await db.EstadodeCuenta.FirstAsync(es => es.Id_Empresa == publicidad.Id_empresa);
                }
                catch 
                {
                    est = null;
                }
                
                if (est == null)
                    db.EstadodeCuenta.Add(new EstadodeCuenta { Id_Empresa = publicidad.Id_empresa, Credito_Disponible = ((decimal)((publicidad.Costo != null) ? (0 - publicidad.Costo.Value) : 0)) });
                else
                {
                    est.Credito_Disponible = Decimal.Round(est.Credito_Disponible - (decimal)(publicidad.Costo.HasValue ? publicidad.Costo.Value : 0), 2);
                }
                await db.SaveChangesAsync();
                return RedirectToAction("Index");
            }
            ViewBag.Empresa = new SelectList(db.Empresa, "Id_Empresa", "Nombre", publicidad.Empresa);
            ViewBag.Medio = new SelectList(db.MedioPublicitario, "Id_Medio_Publicitario", "Nombre", publicidad.Medio);
            return View(publicidad);
        }

        // GET: Publicidads/Edit/5
        public async Task<ActionResult> Edit(int? id)
        {
            if (AccountController.Account.GetUser == null)
                return RedirectPermanent("Login/Index");
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Publicidad publicidad = await db.Publicidad.FindAsync(id);
            if (publicidad == null)
            {
                return HttpNotFound();
            }
            ViewBag.Medio = new SelectList(db.MedioPublicitario, "Id_Medio_Publicitario", "Nombre", publicidad.Medio);
            return View(publicidad);
        }

        // POST: Publicidads/Edit/5
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que desea enlazarse. Para obtener 
        // más información vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> Edit([Bind(Include = "Id_Publicidad,Medio,Id_empresa,Fecha_Inicio,Fecha_Caducidad,Costo")] Publicidad publicidad)
        {
            if (AccountController.Account.GetUser == null)
                return RedirectPermanent("Login/Index");
            if (ModelState.IsValid)
            {
                Publicidad publicidadtem = await db.Publicidad.FindAsync(publicidad.Id_Publicidad);
                EstadodeCuenta est = await db.EstadodeCuenta.FirstAsync(es => es.Id_Empresa == publicidad.Id_empresa);
                if (publicidadtem.Costo != null)
                    est.Credito_Disponible += (decimal)publicidadtem.Costo;
                est.Credito_Disponible -= (decimal)((publicidad.Costo != null) ? (publicidad.Costo.Value) : 0);
                publicidadtem.Costo = publicidad.Costo;
                publicidadtem.Medio = publicidad.Medio;
                publicidadtem.Fecha_Caducidad = publicidad.Fecha_Caducidad;
                publicidadtem.Fecha_Inicio = publicidad.Fecha_Inicio;
                await db.SaveChangesAsync();
                return RedirectToAction("Index");
            }
            ViewBag.Medio = new SelectList(db.MedioPublicitario, "Id_Medio_Publicitario", "Nombre", publicidad.Medio);
            return View(publicidad);
        }

        // GET: Publicidads/Delete/5
        public async Task<ActionResult> Delete(int? id)
        {
            if (AccountController.Account.GetUser == null)
                return RedirectPermanent("Login/Index");
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Publicidad publicidad = await db.Publicidad.Include(p => p.Empresa).Include(p => p.Empresa.EstadodeCuenta).Include(p => p.MedioPublicitario).FirstAsync(p => p.Id_Publicidad == id.Value);
            if (publicidad == null)
            {
                return HttpNotFound();
            }
            return View(publicidad);
        }

        // POST: Publicidads/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> DeleteConfirmed(int id)
        {
            if (AccountController.Account.GetUser == null)
                return RedirectPermanent("Login/Index");
            Publicidad publicidad = await db.Publicidad.FindAsync(id);
            EstadodeCuenta est = await db.EstadodeCuenta.FirstAsync(es => es.Id_Empresa == publicidad.Id_empresa);
            if (publicidad.Costo != null)
                est.Credito_Disponible += (decimal)publicidad.Costo;
            db.Publicidad.Remove(publicidad);
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
