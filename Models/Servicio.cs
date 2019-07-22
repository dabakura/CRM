using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace C_R_M.Models
{
    public class Servicio
    {
        public int Id_Servicio_Empresa { get; set; }
        public string Descripcion { get; set; }
        public String Fecha_Creacion { get; set; }
        public String Primer_Pago { get; set; }
        public String Renovacion { get; set; }
        public int Id_Empresa { get; set; }
        public double Precio { get; set; }
        public virtual Empresa Empresa { get; set; }
        public virtual Producto Producto { get; set; }
    }
}