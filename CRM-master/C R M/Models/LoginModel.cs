using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;


namespace C_R_M.Models
{
    public class LoginModel
    {
        [Required]
        [EmailAddress]
        [Display(Name ="Correo Electronico")]
        public String Email { get; set; }
        [Required]
        [Display(Name = "Contraseña")]
        [DataType(dataType: DataType.Password)]
        public String Password { get; set; }
        [Required]
        [Display(Name = "Mantenerme Conectado")]
        public bool RememberMe { get; set; }
    }
}