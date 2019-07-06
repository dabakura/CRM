using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace C_R_M.Models
{
    public class Sugeridos
    {
        public int Id_Marketing { get; set; }
        public int Id_Producto { get; set; }
        public int Id_Empresa { get; set; }
        public int Sugerencia_Producto { get; set; }
        public string URL { get; set; }

        public virtual Empresa Empresa { get; set; }
        public virtual Producto Producto { get; set; }
        public virtual Producto Producto1 { get; set; }
    }
}