
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Net.Mime;
using System.Text;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.Hosting;

namespace C_R_M.Controllers
{
    public class Email
    {
        public static bool Send(string receiver, string subject, string message)
        {
            try
            {
                string htmlMessage = @"<html>
                         <body> <center>
                         <img src='cid:EmbeddedContent_1' />
                         <h2 style='color: orange'>Bitsoft</h2>
                         <br>
                         <h4>Palmer code le agradece por su preferencia</h4>
                         <br>
                         <b>" + message + "</b>" +
                         "<br><p>Este mensaje es automatizado para mas información contactanos al telefono: 22222222</p>"+
                         "</center></body>" +
                         "</html>";
                // Create the HTML view
                AlternateView htmlView = AlternateView.CreateAlternateViewFromString(
                    htmlMessage,
                    Encoding.UTF8,
                    MediaTypeNames.Text.Html);
                // Create a plain text message for client that don't support HTML
                AlternateView plainView = AlternateView.CreateAlternateViewFromString(
                    Regex.Replace(htmlMessage,"<[^>]+?>",string.Empty),
                    Encoding.UTF8,
                    MediaTypeNames.Text.Plain);
                string mediaType = MediaTypeNames.Image.Jpeg;
                string ruta = HostingEnvironment.ApplicationPhysicalPath + "/Resources/Images/logo.jpg";
                LinkedResource img = new LinkedResource(ruta, mediaType);
                // Make sure you set all these values!!!
                img.ContentId = "EmbeddedContent_1";
                img.ContentType.MediaType = mediaType;
                img.TransferEncoding = TransferEncoding.Base64;
                img.ContentType.Name = img.ContentId;
                img.ContentLink = new Uri("cid:" + img.ContentId);
                htmlView.LinkedResources.Add(img);
                //////////////////////////////////////////////////////////////
                var senderEmail = new MailAddress("fidelitas.nosql@gmail.com", "Bitsoft");
                var receiverEmail = new MailAddress(receiver, "Receiver");
                var password = "qqwrqhlhzevbunov";
                var sub = subject;
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
                    IsBodyHtml = true
                })
                {
                    mess.AlternateViews.Add(plainView);
                    mess.AlternateViews.Add(htmlView);
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