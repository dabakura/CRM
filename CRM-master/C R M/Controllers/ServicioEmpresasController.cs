using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Linq.Dynamic;
using System.Threading.Tasks;
using System.Net;
using System.Web;
using System.Web.Mvc;
using C_R_M.Models;

namespace C_R_M.Controllers
{
    [PermisoAttribute]
    public class ServicioEmpresasController : Controller
    {
        private CRMEntities db = new CRMEntities();

        // GET: ServicioEmpresas
        public ActionResult Index()
        {
            if (AccountController.Account.GetUser == null)
                return RedirectPermanent("Login/Index");
            return View();
        }

        // GET: ServicioEmpresas/Details/5
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

        // GET: ServicioEmpresas/Create
        public ActionResult Create()
        {
            if (AccountController.Account.GetUser == null)
                return RedirectPermanent("Login/Index");
            ViewBag.Empresa = new SelectList(db.Empresa, "Id_Empresa", "Nombre");
            ViewBag.Producto = new SelectList(db.Producto, "Id_Producto", "Nombre");
            return View();
        }

        // POST: ServicioEmpresas/Create
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que desea enlazarse. Para obtener 
        // más información vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> Create([Bind(Include = "Id_Servicio_Empresa,Id_Producto,Descripcion,Fecha_Creacion,Primer_Pago,Renovacion,Id_Empresa,Precio")] ServicioEmpresa servicioEmpresa)
        {
            if (AccountController.Account.GetUser == null)
                return RedirectPermanent("Login/Index");
            if (ModelState.IsValid)
            {
                db.ServicioEmpresa.Add(servicioEmpresa);
                await db.SaveChangesAsync();
                return RedirectToAction("Index");
            }

            ViewBag.Empresa = new SelectList(db.Empresa, "Id_Empresa", "Nombre");
            ViewBag.Producto = new SelectList(db.Producto, "Id_Producto", "Nombre");
            return View(servicioEmpresa);
        }

        // GET: ServicioEmpresas/Edit/5
        public async Task<ActionResult> Edit(int? id)
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
            ViewBag.Empresa = new SelectList(db.Empresa, "Id_Empresa", "Nombre", servicioEmpresa.Id_Empresa);
            ViewBag.Producto = new SelectList(db.Producto, "Id_Producto", "Nombre", servicioEmpresa.Id_Producto);
            return View(servicioEmpresa);
        }

        // POST: ServicioEmpresas/Edit/5
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que desea enlazarse. Para obtener 
        // más información vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> Edit([Bind(Include = "Id_Servicio_Empresa,Id_Producto,Descripcion,Fecha_Creacion,Primer_Pago,Renovacion,Empresa,Precio")] ServicioEmpresa servicioEmpresa)
        {
            if (AccountController.Account.GetUser == null)
                return RedirectPermanent("Login/Index");
            if (ModelState.IsValid)
            {
                db.Entry(servicioEmpresa).State = EntityState.Modified;
                await db.SaveChangesAsync();
                return RedirectToAction("Index");
            }
            ViewBag.Empresa = new SelectList(db.Empresa, "Id_Empresa", "Nombre", servicioEmpresa.Id_Empresa);
            ViewBag.Producto = new SelectList(db.Producto, "Id_Producto", "Nombre", servicioEmpresa.Id_Producto);
            return View(servicioEmpresa);
        }

        // GET: ServicioEmpresas/Delete/5
        public async Task<ActionResult> Delete(int? id)
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

        // POST: ServicioEmpresas/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> DeleteConfirmed(int id)
        {
            if (AccountController.Account.GetUser == null)
                return RedirectPermanent("Login/Index");
            ServicioEmpresa servicioEmpresa = await db.ServicioEmpresa.FindAsync(id);
            db.ServicioEmpresa.Remove(servicioEmpresa);
            await db.SaveChangesAsync();
            return RedirectToAction("Index");
        }

        [AllowAnonymous]
        public JsonResult LoadData()
        {
            try
            {
                //Creating instance of DatabaseContext class
                using (CRMEntities _context = new CRMEntities())
                {
                    var draw = Request.Form.GetValues("draw").FirstOrDefault();
                    var start = Request.Form.GetValues("start").FirstOrDefault();
                    var length = Request.Form.GetValues("length").FirstOrDefault();
                    var sortColumn = Request.Form.GetValues("columns[" + Request.Form.GetValues("order[0][column]").FirstOrDefault() + "][name]").FirstOrDefault();
                    var sortColumnDir = Request.Form.GetValues("order[0][dir]").FirstOrDefault();
                    var searchValue = Request.Form.GetValues("search[value]").FirstOrDefault();


                    //Paging Size (10,20,50,100)  
                    int pageSize = length != null ? Convert.ToInt32(length) : 0;
                    int skip = start != null ? Convert.ToInt32(start) : 0;
                    int recordsTotal = 0;

                    // Getting all Customer data  
                    var customerData = (from tempcustomer in _context.ServicioEmpresa
                                        select tempcustomer);

                    //Sorting  
                    if (!string.IsNullOrEmpty(sortColumn) && !string.IsNullOrEmpty(sortColumnDir))
                    {
                        customerData = customerData.OrderBy(sortColumn + " " + sortColumnDir);
                    }

                    //Search  
                    if (!string.IsNullOrEmpty(searchValue))
                    {
                        customerData = customerData.Where(m => m.Descripcion.Contains(searchValue)
                        || m.Producto.Nombre.Contains(searchValue) || m.Precio.ToString().Contains(searchValue) || m.Empresa.Nombre.Contains(searchValue));
                    }

                    //total number of rows count   
                    recordsTotal = customerData.Count();
                    //Paging   
                    var data = customerData.Skip(skip).Take(pageSize).ToList();
                    List<Servicio> list = new List<Servicio>();
                    foreach (var item in data)
                    {
                        list.Add(new Servicio
                        {
                            Descripcion = item.Descripcion,
                            Precio = item.Precio,
                            Fecha_Creacion = item.Fecha_Creacion.ToShortDateString(),
                            Primer_Pago = (item.Primer_Pago.HasValue) ?item.Primer_Pago.Value.ToShortDateString() : "",
                            Renovacion = item.Renovacion.ToShortDateString(),
                            Id_Servicio_Empresa = item.Id_Servicio_Empresa,
                            Empresa = new Empresa { Nombre = item.Empresa.Nombre },
                            Producto = new Producto { Nombre = item.Producto.Nombre },
                        });
                    }
                    //Returning Json Data  
                    return Json(new { draw = draw, recordsFiltered = recordsTotal, recordsTotal = recordsTotal, data = list });
                }
            }
            catch (Exception e)
            {
                System.Diagnostics.Debug.WriteLine(e.Message);
            }
            return Json(new { data = "error" }, JsonRequestBehavior.AllowGet);
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
