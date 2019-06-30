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
using Newtonsoft.Json.Linq;
using Newtonsoft.Json;
using System.Web.Script.Serialization;

namespace C_R_M.Controllers
{
    public class RolsController : Controller
    {
        private CRMEntities db = new CRMEntities();

        // GET: Rols
        public async Task<ActionResult> Index()
        {
            return View(await db.Rol.ToListAsync());
        }

        // GET: Rols/Details/5
        public async Task<ActionResult> Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Rol rol = await db.Rol.FindAsync(id);
            if (rol == null)
            {
                return HttpNotFound();
            }
            return View(rol);
        }

        // GET: Rols/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: Rols/Create
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que desea enlazarse. Para obtener 
        // más información vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> Create([Bind(Include = "Nombre")] Rol rol)
        {
            if (ModelState.IsValid)
            {
                db.Rol.Add(rol);
                await db.SaveChangesAsync();
                ViewBag.Permisos = Permisos();
                ViewBag.Id = rol.Id;
                return View("CreatePermiso");
            }

            return View(rol);
        }

        // GET: Rols/Edit/5
        public async Task<ActionResult> Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Rol rol = await db.Rol.FindAsync(id);
            if (rol == null)
            {
                return HttpNotFound();
            }
            ViewBag.Permisos = Permisos(db.PermisoRol.Where(p => p.Id_Rol == id).ToList());
            return View(rol);
        }

        // POST: Rols/Edit/5
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que desea enlazarse. Para obtener 
        // más información vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> Edit([Bind(Include = "Id,Nombre")] Rol rol)
        {
            if (ModelState.IsValid)
            {
                db.Entry(rol).State = EntityState.Modified;
                await db.SaveChangesAsync();
                return RedirectToAction("Index");
            }
            ViewBag.Permisos = Permisos(db.PermisoRol.Where(p => p.Id_Rol == rol.Id).ToList());
            return View(rol);
        }

        // GET: Rols/Delete/5
        public async Task<ActionResult> Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Rol rol = await db.Rol.FindAsync(id);
            if (rol == null)
            {
                return HttpNotFound();
            }
            return View(rol);
        }

        // POST: Rols/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> DeleteConfirmed(int id)
        {
            Rol rol = await db.Rol.FindAsync(id);
            db.Rol.Remove(rol);
            await db.SaveChangesAsync();
            return RedirectToAction("Index");
        }

        [HttpPost]
        public JsonResult Update(string permisos, int id)
        {
            try
            {
                List<AsigPermiso> list = new JavaScriptSerializer().Deserialize<List<AsigPermiso>>(permisos);
                List<PermisoRol> listpermisos = new List<PermisoRol>();
                list.ForEach(p => { PermisoRol per = p.PermisoRol; per.Id_Rol = id; listpermisos.Add(per); });
                db.PermisoRol.RemoveRange(db.PermisoRol.Where(p => p.Id_Rol == id).ToList());
                db.PermisoRol.AddRange(listpermisos);
                db.SaveChanges();
                return Json("/Rols/Index", JsonRequestBehavior.AllowGet);
            }
            catch
            {
                return Json("/Rols/Index", JsonRequestBehavior.AllowGet);
            }
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }

        public static String TipoPermiso(PermisoRol permisorol)
        {
            Permiso per = permisorol.Permiso;
            String permiso = "Acciones permitidas: ";
            if (per.Crear && per.Editar && per.Eliminar && per.Mostrar)
                return "Autorizado";
            if (!per.Crear && !per.Editar && !per.Eliminar && !per.Mostrar)
                return "No Autorizado";
            if (per.Crear)
                permiso += "Crear ";
            if (per.Editar)
                permiso += "Editar ";
            if (per.Mostrar)
                permiso += "Mostrar ";
            if (per.Eliminar)
                permiso += "Eliminar ";
            return permiso.Trim();
        }

        [AllowAnonymous]
        private List<AsigPermiso> Permisos(List<PermisoRol> permisos = null)
        {
            if(permisos == null || permisos.Count < 1)
                return new List<AsigPermiso> {
                    new AsigPermiso("Empresas",false,false,false,false),
                    new AsigPermiso("Empresas","Index",false),
                    new AsigPermiso("Marketings",false,false,false,false),
                    new AsigPermiso("Marketings","Index",false),
                    new AsigPermiso("Productoes",false,false,false,false),
                    new AsigPermiso("Productoes","Index",false),
                    new AsigPermiso("Publicidads",false,false,false,false),
                    new AsigPermiso("Publicidads","Index",false),
                    new AsigPermiso("Recordatorios",false,false,false,false),
                    new AsigPermiso("Recordatorios","Index",false),
                    new AsigPermiso("Recordatorios","RecordatoriosDia",false),
                    new AsigPermiso("Rols",false,false,false,false),
                    new AsigPermiso("Rols","Index",false),
                    new AsigPermiso("Movimientoes",false,false,false,false),
                    new AsigPermiso("Movimientoes","Index",false),
                    new AsigPermiso("Usuarios",false,false,false,false),
                    new AsigPermiso("Usuarios","Index",false),
                    new AsigPermiso("EstadodeCuentas",false,false,false,false),
                    new AsigPermiso("Usuarios","Index",false),
                };
            List<AsigPermiso> list = new List<AsigPermiso>();
            permisos.ForEach(p => list.Add(new AsigPermiso(p)));
            return list;
        }
    }
}
