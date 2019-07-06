using C_R_M.Models;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Data.Entity;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.UI.WebControls;
using Microsoft.Reporting.WebForms;

namespace C_R_M.Controllers
{
    public class ReportController : Controller
    {
        private CRMEntities db = new CRMEntities();
        // GET: Report
        public ActionResult Index()
        {
            var list = db.ServicioEmpresa.Include(r => r.Empresa);
            ViewBag.Servicios = new SelectList(db.ServicioEmpresa.Include(Se => Se.Empresa).Include(p => p.Producto), "Id_Servicio_Empresa", "Empresa.Nombre");
            int id = db.ServicioEmpresa.First()!= null ? db.ServicioEmpresa.First().Id_Servicio_Empresa: 0;
            ViewBag.ReportViewer = GetReportViewer("SELECT * FROM dbo.View_ReportCuentas WHERE Id_Servicio_Empresa = " + id);
            return View();
        }
        // POST: Report/Create
        [HttpPost]
        public ActionResult Index(int? Id_Servicio_Empresa)
        {
            ViewBag.Servicios = new SelectList(db.ServicioEmpresa.Include(Se => Se.Empresa).Include(p => p.Producto), "Id_Servicio_Empresa", "Empresa.Nombre");
            int id = db.ServicioEmpresa.First() != null ? db.ServicioEmpresa.First().Id_Servicio_Empresa : 0;
            if (Id_Servicio_Empresa.HasValue)
            {
                ViewBag.ReportViewer = GetReportViewer("SELECT * FROM dbo.View_ReportCuentas WHERE Id_Servicio_Empresa = " + Id_Servicio_Empresa);
            }
            else
            {
                ViewBag.ReportViewer = GetReportViewer("SELECT * FROM dbo.View_ReportCuentas WHERE Id_Servicio_Empresa = " + id);
            }
            return View();
        }


        private ReportViewer GetReportViewer(String queryservicios)
        {
            ReportViewer reportViewer = new ReportViewer();
            reportViewer.ProcessingMode = ProcessingMode.Local;
            reportViewer.SizeToReportContent = false;
            reportViewer.Width = Unit.Percentage(100);
            reportViewer.Height = Unit.Percentage(100);
            var connectionString = ConfigurationManager.ConnectionStrings["CRMConnectionString"].ConnectionString;
            DataSet datos = new DataSet();
            SqlConnection conx = new SqlConnection(connectionString);
            SqlDataAdapter adpE = new SqlDataAdapter(queryservicios, conx);
            adpE.Fill(datos);
            reportViewer.LocalReport.ReportPath = Request.MapPath(Request.ApplicationPath) + @"Reports\ReportVentas.rdlc";
            reportViewer.LocalReport.DataSources.Add(new ReportDataSource("DataSetCuentas", datos.Tables[0]));
            reportViewer.ZoomPercent = 150;
            return reportViewer;
        }
    }
}
