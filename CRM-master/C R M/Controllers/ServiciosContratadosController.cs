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
    public class ServiciosContratadosController : Controller
    {
        private CRMEntities db = new CRMEntities();

        // GET: ServiciosContratados
        public async Task<ActionResult> Index()
        {
            if (AccountController.Account.GetUser == null)
                return RedirectPermanent("Login/Index");
            int? id = AccountController.Account.GetUser.Id_Empresa;
            List<ServicioEmpresa> servicios = new List<ServicioEmpresa>();
            if (id != null)
                servicios = await db.ServicioEmpresa.Include(s => s.Empresa).Include(s => s.Producto).Where(s=>s.Id_Empresa == id.Value).ToListAsync();
            return View(servicios);
        }

        // GET: ServiciosContratados/Details/5
        public async Task<ActionResult> Details(int? id)
        {
            if (AccountController.Account.GetUser == null)
                return RedirectPermanent("Login/Index");
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            ServicioEmpresa servicioEmpresa = await db.ServicioEmpresa.FindAsync(id);
            if (servicioEmpresa == null)
            {
                return HttpNotFound();
            }
            return View(servicioEmpresa);
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
