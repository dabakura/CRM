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
    public class MarketingsController : Controller
    {
        private CRMEntities db = new CRMEntities();

        // GET: Marketings
        public ActionResult Index()
        {
            if (AccountController.Account.GetUser == null)
                return RedirectPermanent("Login/Index");
            var marketing = db.ServicioEmpresa.Include(m => m.Empresa).Include(m => m.Producto);
            List<Servicio> list = new List<Servicio>();
            foreach (var item in marketing)
            {
                if (!list.Exists(lis => lis.Empresa.Id_Empresa == item.Id_Empresa && lis.Producto.Id_Producto == item.Producto.Id_Producto))
                {
                    list.Add(new Servicio
                    {
                        Id_Empresa = item.Id_Empresa,
                        Id_Servicio_Empresa = item.Id_Servicio_Empresa,
                        Empresa = new Empresa { Nombre = item.Empresa.Nombre, Correo = item.Empresa.Correo, Cedula = item.Empresa.Cedula },
                        Producto = new Producto { Nombre = item.Producto.Nombre, Id_Producto = item.Producto.Id_Producto},
                    });
                }
            }
            ViewBag.Productos = new SelectList(db.Producto, "Id_Producto", "Nombre");
            return View(list);
        }

        // GET: Marketings/Details/
        public async Task<ActionResult> Details()
        {
            if (AccountController.Account.GetUser == null)
                return RedirectPermanent("Login/Index");
            var marketing = await db.Marketing.Include(m => m.Empresa).Include(m => m.Producto).Include(s => s.Producto1).ToListAsync();
            return View(marketing);
        }
        

        // POST: Marketings/Create
        [HttpPost]
        public async Task<JsonResult> Create()
        {
            var servicios = Request.Form.GetValues("servicios").FirstOrDefault().Split(',');
            var sugerido =  Convert.ToInt32(Request.Form.GetValues("sugerido").FirstOrDefault());
            var url = Request.Form.GetValues("url").FirstOrDefault();
            foreach (var item in servicios)
            {
                if (!String.IsNullOrEmpty(item))
                {
                    int id = Convert.ToInt32(item);
                    ServicioEmpresa servi = await db.ServicioEmpresa.FindAsync(id);
                    db.Marketing.Add(new Marketing { Id_Empresa= servi.Id_Empresa, Id_Producto = servi.Id_Producto, Sugerencia_Producto = sugerido, URL = url});
                    await db.SaveChangesAsync();
                }
            }
            return Json("hola",JsonRequestBehavior.AllowGet);
        }
        

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
                    var customerData = (from tempcustomer in _context.Marketing
                                        select tempcustomer);

                    customerData = customerData.OrderBy(sortColumn + " " + sortColumnDir);
                    //Sorting  
                    if (!string.IsNullOrEmpty(sortColumn) && !string.IsNullOrEmpty(sortColumnDir))
                    {
                        customerData = customerData.OrderBy("Id_Marketing desc");
                    }

                    //Search  
                    if (!string.IsNullOrEmpty(searchValue))
                    {
                        customerData = customerData.Where(m => m.Producto1.Nombre.Contains(searchValue)
                        || m.Producto.Nombre.Contains(searchValue) || m.Empresa.Correo.Contains(searchValue) || m.Empresa.Nombre.Contains(searchValue));
                    }

                    //total number of rows count   
                    recordsTotal = customerData.Count();
                    //Paging   
                    var data = customerData.Skip(skip).Take(pageSize).ToList();
                    List<Sugeridos> list = new List<Sugeridos>();
                    foreach (var item in data)
                    {
                        list.Add(new Sugeridos
                        {
                            Id_Marketing = item.Id_Marketing,
                            URL = item.URL,
                            Empresa = new Empresa { Nombre = item.Empresa.Nombre, Correo = item.Empresa.Correo, Cedula = item.Empresa.Cedula},
                            Producto = new Producto { Nombre = item.Producto.Nombre },
                            Producto1 = new Producto { Nombre = item.Producto1.Nombre },
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
