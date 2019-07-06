
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Web;

namespace C_R_M.Controllers
{
    public class Email
    {
        public static bool Send(string receiver, string subject, string message) {
            try
            {
                    var senderEmail = new MailAddress("fidelitas.nosql@gmail.com", "Palmer");
                    var receiverEmail = new MailAddress(receiver, "Receiver");
                    var password = "qqwrqhlhzevbunov";
                    var sub = subject;
                    var body = message;
                    var smtp = new SmtpClient
                    {
                        Host = "smtp.gmail.com",
                        Port = 587,
                        EnableSsl = true,
                        DeliveryMethod = SmtpDeliveryMethod.Network,
                        UseDefaultCredentials = false,
                        Credentials = new NetworkCredential(senderEmail.Address, password)
                    };
                    using (var mess = new MailMessage(senderEmail, receiverEmail)
                    {
                        Subject = subject,
                        Body = body
                    })
                    {
                        smtp.Send(mess);
                    }
                    return true;
            }
            catch (Exception e)
            {
                return false;
            }
        }
    }
}