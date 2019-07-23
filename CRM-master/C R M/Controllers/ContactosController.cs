using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq.Dynamic;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using C_R_M.Models;
using Newtonsoft.Json;

namespace C_R_M.Controllers
{
    [PermisoAttribute]
    public class ContactosController : Controller
    {
        private CRMEntities db = new CRMEntities();

        // GET: Contactoes
        public ActionResult Index()
        {
            if (AccountController.Account.GetUser == null)
                return RedirectPermanent("Login/Index");
            return View();
        }

        // GET: Contactoes/Details/5
        public ActionResult Details(int? id)
        {
            if (AccountController.Account.GetUser == null)
                return RedirectPermanent("Login/Index");
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Contacto contacto = db.Contacto.Include(c => c.Correo).Include(c => c.Telefono).First(c => c.Id_Contacto == id.Value);
            if (contacto == null)
            {
                return HttpNotFound();
            }
            return View(contacto);
        }

        // GET: Contactoes/Create
        public ActionResult Create()
        {
            if (AccountController.Account.GetUser == null)
                return RedirectPermanent("Login/Index");
            ViewBag.Empresa = new SelectList(db.Empresa.ToList(), "Id_Empresa", "Nombre");
            return View();
        }

        // POST: Contactoes/Create
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que desea enlazarse. Para obtener 
        // más información vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "Id_Contacto,Nombre,Apellido1,Apellido2,Puesto,Id_Empresa,Correo,Telefono")]Contacto contacto)
        {
            if (AccountController.Account.GetUser == null)
                return RedirectPermanent("Login/Index");
            int index = contacto.Correo.Count - 1;
            for (int i = index; i >= 0; i--)
                if (String.IsNullOrEmpty(contacto.Correo.ElementAt(i).Direccion)) contacto.Correo.Remove(contacto.Correo.ElementAt(i));
            index = contacto.Telefono.Count - 1;
            for (int i = index; i >= 0; i--)
            {
                if (String.IsNullOrEmpty(contacto.Telefono.ElementAt(i).Codigo)) contacto.Telefono.ElementAt(i).Codigo = "(506)";
                if (!contacto.Telefono.ElementAt(i).N_Telefonico.HasValue || 0 == contacto.Telefono.ElementAt(i).N_Telefonico) contacto.Telefono.Remove(contacto.Telefono.ElementAt(i));
            }
            if (ModelState.IsValid)
            {
                db.Contacto.Add(contacto);
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.Empresa = new SelectList(db.Empresa.ToList(), "Id_Empresa", "Nombre");
            return View(contacto);
        }

        // GET: Contactoes/Edit/5
        public ActionResult Edit(int? id)
        {
            if (AccountController.Account.GetUser == null)
                return RedirectPermanent("Login/Index");
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Contacto contacto = db.Contacto.Include(c => c.Correo).Include(c => c.Telefono).First(c => c.Id_Contacto == id.Value);
            if (contacto == null)
            {
                return HttpNotFound();
            }
            ViewBag.Empresa = new SelectList(db.Empresa.ToList(), "Id_Empresa", "Nombre");
            return View(contacto);
        }

        // POST: Contactoes/Edit/5
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que desea enlazarse. Para obtener 
        // más información vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "Id_Contacto,Nombre,Apellido1,Apellido2,Puesto,Id_Empresa,Correo,Telefono")] Contacto contacto)
        {
            if (AccountController.Account.GetUser == null)
                return RedirectPermanent("Login/Index");
            for (int i = 0; i < contacto.Correo.Count; i++)
            {
                contacto.Correo.ElementAt(i).Contacto = null;
                contacto.Correo.ElementAt(i).Id_Correo = 0;
                if (String.IsNullOrEmpty(contacto.Correo.ElementAt(i).Direccion)) contacto.Correo.Remove(contacto.Correo.ElementAt(i));
            }
            for (int i = 0; i < contacto.Telefono.Count; i++)
            {
                contacto.Telefono.ElementAt(i).Contacto = null;
                contacto.Telefono.ElementAt(i).Id_Telefono = 0;
                if (String.IsNullOrEmpty(contacto.Telefono.ElementAt(i).Codigo)) contacto.Telefono.ElementAt(i).Codigo = "(506)";
                if (0 == contacto.Telefono.ElementAt(i).N_Telefonico) contacto.Telefono.Remove(contacto.Telefono.ElementAt(i));
            }
            if (ModelState.IsValid)
            {
                Contacto contact = db.Contacto.Find(contacto.Id_Contacto);
                contact.Nombre = contacto.Nombre;
                contact.Apellido1 = contacto.Apellido1;
                contact.Apellido2 = contacto.Apellido2;
                contact.Id_Empresa = contacto.Id_Empresa;
                contact.Puesto = contacto.Puesto;
                contact.Correo.Clear();
                contact.Correo = contacto.Correo;
                contact.Telefono.Clear();
                contact.Telefono = contacto.Telefono;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.Empresa = new SelectList(db.Empresa.ToList(), "Id_Empresa", "Nombre");
            return View(contacto);
        }

        // GET: Contactoes/Delete/5
        public ActionResult Delete(int? id)
        {
            if (AccountController.Account.GetUser == null)
                return RedirectPermanent("Login/Index");
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Contacto contacto = db.Contacto.Find(id);
            if (contacto == null)
            {
                return HttpNotFound();
            }
            return View(contacto);
        }

        // POST: Contactoes/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            if (AccountController.Account.GetUser == null)
                return RedirectPermanent("Login/Index");
            Contacto contacto = db.Contacto.Find(id);
            db.Contacto.Remove(contacto);
            db.SaveChanges();
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
                    var customerData = (from tempcustomer in _context.Contacto
                                        select tempcustomer);

                    //Sorting  
                    if (!string.IsNullOrEmpty(sortColumn) && !string.IsNullOrEmpty(sortColumnDir))
                    {
                        customerData = customerData.OrderBy(sortColumn + " " + sortColumnDir);
                    }

                    //Search  
                    if (!string.IsNullOrEmpty(searchValue))
                    {
                        customerData = customerData.Where(m => m.Nombre.Contains(searchValue)
                        || m.Apellido1.Contains(searchValue) || m.Apellido2.Contains(searchValue) || m.Empresa.Nombre.Contains(searchValue));
                    }

                    //total number of rows count   
                    recordsTotal = customerData.Count();
                    //Paging   
                    var data = customerData.Skip(skip).Take(pageSize).ToList();
                    List<Contacto> list = new List<Contacto>();
                    foreach (var item in data)
                    {
                        list.Add(new Contacto
                        {
                            Apellido1 = item.Apellido1,
                            Apellido2 = item.Apellido2,
                            Id_Contacto = item.Id_Contacto,
                            Id_Empresa = item.Id_Empresa,
                            Nombre = item.Nombre,
                            Puesto = item.Puesto,
                            Telefono = (from te in item.Telefono select new Telefono { Codigo = te.Codigo, N_Telefonico = te.N_Telefonico }).ToList(),
                            Empresa = new Empresa { Nombre = item.Empresa.Nombre },
                            Correo = (from te in item.Correo select new Correo { Direccion = te.Direccion }).ToList(),
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
    }
}
