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
using System.Threading.Tasks;

namespace C_R_M.Controllers
{
    public class ReportController : Controller
    {
        private CRMEntities db = new CRMEntities();
        // GET: Report
        public async Task<ActionResult> Index()
        {
            ViewBag.Servicios = await ListItems();
            int id = db.ServicioEmpresa.First()!= null ? db.ServicioEmpresa.First().Id_Servicio_Empresa: 0;
            ViewBag.ReportViewer = GetReportViewer("SELECT * FROM dbo.View_ReportCuentas WHERE Id_Servicio_Empresa = " + id);
            return View();
        }
        // POST: Report/Create
        [HttpPost]
        public async Task<ActionResult> Index(int? Id_Servicio_Empresa)
        {
            ViewBag.Servicios = await ListItems();
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


        private async Task<List<SelectListItem>> ListItems() {
            List<SelectListItem> list = new List<SelectListItem>();
            var queryEmpresas = from em in await db.ServicioEmpresa.ToListAsync()
                                group em by em.Empresa.Nombre into newGroup
                                orderby newGroup.Key
                                select newGroup;
            foreach (var nameGroup in queryEmpresas)
            {
                SelectListGroup llave = new SelectListGroup { Name = "Empresa: " + nameGroup.Key };
                foreach (var item in nameGroup)
                {
                    list.Add(new SelectListItem { Text = "Producto: " + item.Producto.Nombre + " - Fecha: " + item.Fecha_Creacion.ToShortDateString(), Value = "" + item.Id_Servicio_Empresa, Group = llave });
                }
            }
            return list;
        }

        private ReportViewer GetReportViewer(String queryservicios)
        {
            ReportViewer reportViewer = new ReportViewer();
            reportViewer.ProcessingMode = ProcessingMode.Local;
            reportViewer.Width = Unit.Percentage(100);
            reportViewer.Height = Unit.Percentage(100);
            reportViewer.ZoomMode = ZoomMode.Percent;
            var connectionString = ConfigurationManager.ConnectionStrings["CRMConnectionString"].ConnectionString;
            DataSet datos = new DataSet();
            SqlConnection conx = new SqlConnection(connectionString);
            SqlDataAdapter adpE = new SqlDataAdapter(queryservicios, conx);
            adpE.Fill(datos);
            reportViewer.LocalReport.ReportPath = Request.MapPath(Request.ApplicationPath) + @"Reports\ReportVentas.rdlc";
            reportViewer.LocalReport.DataSources.Add(new ReportDataSource("DataSetCuentas", datos.Tables[0]));
            reportViewer.ShowZoomControl = true;
            reportViewer.ZoomPercent = 150;
            return reportViewer;
        }
    }
}
