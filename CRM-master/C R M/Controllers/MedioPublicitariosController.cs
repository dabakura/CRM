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
    public class MedioPublicitariosController : Controller
    {
        private CRMEntities db = new CRMEntities();

        // GET: MedioPublicitarios
        public async Task<ActionResult> Index()
        {
            return View(await db.MedioPublicitario.ToListAsync());
        }

        // GET: MedioPublicitarios/Details/5
        public async Task<ActionResult> Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            MedioPublicitario medioPublicitario = await db.MedioPublicitario.FindAsync(id);
            if (medioPublicitario == null)
            {
                return HttpNotFound();
            }
            return View(medioPublicitario);
        }

        // GET: MedioPublicitarios/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: MedioPublicitarios/Create
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que desea enlazarse. Para obtener 
        // más información vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> Create([Bind(Include = "Id_Medio_Publicitario,Nombre")] MedioPublicitario medioPublicitario)
        {
            if (ModelState.IsValid)
            {
                db.MedioPublicitario.Add(medioPublicitario);
                await db.SaveChangesAsync();
                return RedirectToAction("Index");
            }

            return View(medioPublicitario);
        }

        // GET: MedioPublicitarios/Edit/5
        public async Task<ActionResult> Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            MedioPublicitario medioPublicitario = await db.MedioPublicitario.FindAsync(id);
            if (medioPublicitario == null)
            {
                return HttpNotFound();
            }
            return View(medioPublicitario);
        }

        // POST: MedioPublicitarios/Edit/5
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que desea enlazarse. Para obtener 
        // más información vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> Edit([Bind(Include = "Id_Medio_Publicitario,Nombre")] MedioPublicitario medioPublicitario)
        {
            if (ModelState.IsValid)
            {
                db.Entry(medioPublicitario).State = EntityState.Modified;
                await db.SaveChangesAsync();
                return RedirectToAction("Index");
            }
            return View(medioPublicitario);
        }

        // GET: MedioPublicitarios/Delete/5
        public async Task<ActionResult> Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            MedioPublicitario medioPublicitario = await db.MedioPublicitario.FindAsync(id);
            if (medioPublicitario == null)
            {
                return HttpNotFound();
            }
            return View(medioPublicitario);
        }

        // POST: MedioPublicitarios/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> DeleteConfirmed(int id)
        {
            MedioPublicitario medioPublicitario = await db.MedioPublicitario.FindAsync(id);
            db.MedioPublicitario.Remove(medioPublicitario);
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
