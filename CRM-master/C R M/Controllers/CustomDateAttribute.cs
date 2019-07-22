using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace C_R_M.Controllers
{
    public class CustomDateAttribute: RangeAttribute
    {
        public CustomDateAttribute()
            : base(typeof(DateTime),
                DateTime.Now.ToShortDateString(), DateTime.MaxValue.ToShortDateString()
                )
        { }
    }
}