
//------------------------------------------------------------------------------
// <auto-generated>
//     Este código se generó a partir de una plantilla.
//
//     Los cambios manuales en este archivo pueden causar un comportamiento inesperado de la aplicación.
//     Los cambios manuales en este archivo se sobrescribirán si se regenera el código.
// </auto-generated>
//------------------------------------------------------------------------------


namespace C_R_M.Models
{

using System;
    using System.Collections.Generic;
    
public partial class Marketing
{

    public int Id_Marketing { get; set; }

    public int Id_Producto { get; set; }

    public int Empresa { get; set; }

    public int Sugerencia_Producto { get; set; }

    public string URL { get; set; }



    public virtual Empresa Empresa1 { get; set; }

    public virtual Producto Producto { get; set; }

    public virtual Producto Producto1 { get; set; }

}

}
