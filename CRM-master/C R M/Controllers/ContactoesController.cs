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
    public class ContactoesController : Controller
    {
        private CRMEntities db = new CRMEntities();

        // GET: Contactoes
        public ActionResult Index()
        {
            int? id = AccountController.Account.GetUser.Id_Empresa;
            var contacto = db.Contacto.Include(c => c.Empresa);
            List<Contacto> listContactos = contacto.ToList();
            List<SelectList> listCorreos = new List<SelectList>();
            List<SelectList> listTelefonos = new List<SelectList>();
            if (id != null)
            {
                foreach (var item in contacto)
                {
                    if (item.Id_Empresa != id)
                    {
                        listContactos.Remove(item);
                    }
                    else
                    {
                        listCorreos.Add(new SelectList(item.Correo, "Id_Correo", "Direccion"));
                        listTelefonos.Add(new SelectList(item.Telefono, "Id_Telefono", "N_Telefonico"));
                    }
                }
                ViewBag.Telefonos = listTelefonos.ToArray();
                ViewBag.Correos = listCorreos.ToArray();
            }
            else return RedirectToAction("Index", "Home", null);
            return View(listContactos);
        }

        // GET: Contactoes/Details/5
        public ActionResult Details(int? id)
        {
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
            int? id = AccountController.Account.GetUser.Id_Empresa;
            if (id != null)
                ViewBag.Empresa = new SelectList(db.Empresa.Where(e => e.Id_Empresa == id.Value).ToList(), "Id_Empresa", "Nombre");
            else return RedirectToAction("Index", "Home", null);

            Contacto cont = new Contacto
            {
                Correo = new List<Correo> {
                new Correo { Direccion="",Id_Correo=0},
                new Correo { Direccion = "", Id_Correo = 0 }
            },
                Telefono = new List<Telefono>
            {
                new Telefono { Codigo="",Id_Telefono=0,},
                new Telefono { Codigo = "", Id_Telefono = 0,}
            },Apellido1 = "", Apellido2="",Nombre="",Puesto=""
            };
            return View(cont);
        }

        // POST: Contactoes/Create
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que desea enlazarse. Para obtener 
        // más información vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "Id_Contacto,Nombre,Apellido1,Apellido2,Puesto,Id_Empresa,Correo,Telefono")]Contacto contacto)
        {
            if (ModelState.IsValid)
            {
                for (int i = 0; i < contacto.Correo.Count; i++)
                    if (String.IsNullOrEmpty(contacto.Correo.ElementAt(i).Direccion)) contacto.Correo.Remove(contacto.Correo.ElementAt(i));
                for (int i = 0; i < contacto.Telefono.Count; i++)
                {
                    if (0 == contacto.Telefono.ElementAt(i).N_Telefonico) contacto.Telefono.Remove(contacto.Telefono.ElementAt(i));
                    if (String.IsNullOrEmpty(contacto.Telefono.ElementAt(i).Codigo)) contacto.Telefono.ElementAt(i).Codigo = "(506)";
                }
                db.Contacto.Add(contacto);
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            int? id = AccountController.Account.GetUser.Id_Empresa;
            if (id != null)
                ViewBag.Empresa = new SelectList(db.Empresa.Where(e => e.Id_Empresa == id.Value).ToList(), "Id_Empresa", "Nombre");
            else return RedirectToAction("Index", "Home", null);
            return View(contacto);
        }

        // GET: Contactoes/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Contacto contacto = db.Contacto.Include(c => c.Correo).Include(c => c.Telefono).First(c => c.Id_Contacto == id.Value);
            if (contacto == null)
            {
                return HttpNotFound();
            }
            int? idem = AccountController.Account.GetUser.Id_Empresa;
            ViewBag.Empresa = new SelectList(db.Empresa.Where(e => e.Id_Empresa == idem.Value).ToList(), "Id_Empresa", "Nombre");
            return View(contacto);
        }

        // POST: Contactoes/Edit/5
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que desea enlazarse. Para obtener 
        // más información vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "Id_Contacto,Nombre,Apellido1,Apellido2,Puesto,Id_Empresa,Correo,Telefono")] Contacto contacto)
        {
            for (int i = 0; i < contacto.Correo.Count; i++)
                if (String.IsNullOrEmpty(contacto.Correo.ElementAt(i).Direccion)) contacto.Correo.Remove(contacto.Correo.ElementAt(i));
            for (int i = 0; i < contacto.Telefono.Count; i++)
            {
                if (0 == contacto.Telefono.ElementAt(i).N_Telefonico) contacto.Telefono.Remove(contacto.Telefono.ElementAt(i));
                if (String.IsNullOrEmpty(contacto.Telefono.ElementAt(i).Codigo)) contacto.Telefono.ElementAt(i).Codigo = "(506)";
            }
            if (ModelState.IsValid)
            {
                db.Entry(contacto).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            int? idem = AccountController.Account.GetUser.Id_Empresa;
            ViewBag.Empresa = new SelectList(db.Empresa.Where(e => e.Id_Empresa == idem.Value).ToList(), "Id_Empresa", "Nombre");
            return View(contacto);
        }

        // GET: Contactoes/Delete/5
        public ActionResult Delete(int? id)
        {
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
    }
}
