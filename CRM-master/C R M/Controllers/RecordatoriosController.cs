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
    public class RecordatoriosController : Controller
    {
        private CRMEntities db = new CRMEntities();

        // GET: Recordatorios
        public async Task<ActionResult> Index()
        {
            var recordatorio = db.Recordatorio.Include(r => r.Empresa);
            return View(await recordatorio.ToListAsync());
        }

        // GET: Recordatorios/Details/5
        public async Task<ActionResult> Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Recordatorio recordatorio = await db.Recordatorio.Include(r => r.Empresa).FirstAsync(r=>r.Id_Recordatorio == id.Value);
            if (recordatorio == null)
            {
                return HttpNotFound();
            }
            return View(recordatorio);
        }

        // GET: Recordatorios/Create
        public ActionResult Create()
        {
            ViewBag.Empresa = new SelectList(db.Empresa, "Id_Empresa", "Nombre");
            return View();
        }

        // POST: Recordatorios/Create
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que desea enlazarse. Para obtener 
        // más información vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> Create([Bind(Include = "Id_Recordatorio,Tipo,Fecha,Hora,Minutos,Abreviatura,Detalle,Id_empresa,Mensaje")] Recordatorio recordatorio)
        {
            if (ModelState.IsValid)
            {
                db.Recordatorio.Add(recordatorio);
                await db.SaveChangesAsync();
                return RedirectToAction("Index");
            }

            ViewBag.Empresa = new SelectList(db.Empresa, "Id_Empresa", "Nombre", recordatorio.Id_empresa);
            return View(recordatorio);
        }

        // GET: Recordatorios/Edit/5
        public async Task<ActionResult> Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Recordatorio recordatorio = await db.Recordatorio.FindAsync(id);
            if (recordatorio == null)
            {
                return HttpNotFound();
            }
            ViewBag.Empresa = new SelectList(db.Empresa, "Id_Empresa", "Nombre", recordatorio.Id_empresa);
            return View(recordatorio);
        }

        // POST: Recordatorios/Edit/5
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que desea enlazarse. Para obtener 
        // más información vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> Edit([Bind(Include = "Id_Recordatorio,Tipo,Fecha,Hora,Minutos,Abreviatura,Detalle,Id_empresa,Mensaje")] Recordatorio recordatorio)
        {
            if (ModelState.IsValid)
            {
                db.Entry(recordatorio).State = EntityState.Modified;
                await db.SaveChangesAsync();
                return RedirectToAction("Index");
            }
            ViewBag.Empresa = new SelectList(db.Empresa, "Id_Empresa", "Nombre", recordatorio.Id_empresa);
            return View(recordatorio);
        }

        // GET: Recordatorios/Delete/5
        public async Task<ActionResult> Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Recordatorio recordatorio = await db.Recordatorio.FindAsync(id);
            if (recordatorio == null)
            {
                return HttpNotFound();
            }
            return View(recordatorio);
        }

        // POST: Recordatorios/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> DeleteConfirmed(int id)
        {
            Recordatorio recordatorio = await db.Recordatorio.FindAsync(id);
            db.Recordatorio.Remove(recordatorio);
            await db.SaveChangesAsync();
            return RedirectToAction("Index");
        }

        public async Task<ActionResult> RecordatoriosDia()
        {
            var recordatorio = await db.Recordatorio.Include(r => r.Empresa).ToListAsync();
            return View(recordatorio.FindAll(r => r.Fecha.Date == DateTime.Now.Date));
        }

        public static int RecordatoriosCount()
        {
            CRMEntities db = new CRMEntities();
            var recordatorio = db.Recordatorio.ToList();
            return recordatorio.FindAll(r => r.Fecha.Date == DateTime.Now.Date).Count;
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
