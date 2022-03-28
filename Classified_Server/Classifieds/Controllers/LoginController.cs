using Classifieds.Models;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;
using Newtonsoft.Json;

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace Classifieds.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class LoginController : ControllerBase
    {

        private readonly UserContext _userContext;
        public LoginController(UserContext userContext)
        {
            _userContext = userContext;
        }

        // POST api/<LoginController>
        [HttpPost]
        public Response Post([FromBody] Login value)
        {
            var oldUser = _userContext.Users.SingleOrDefault<User>(user => user.Email == value.Email);
            Console.WriteLine(value.Email);
            if (oldUser?.Password == GetHash(value.Password))
            {
                return new Response()
                {
                    Valid = true,
                    Token = oldUser?.Token,
                    Message = "Success"
                };
            }

            return new Response()
            {
                Valid = false,
                Message = "Invalid login"
            };
        }

        private string GetHash(string text)
        {
            // SHA512 is disposable by inheritance.  
            using (var sha256 = SHA256.Create())
            {
                var hashedBytes = sha256.ComputeHash(Encoding.UTF8.GetBytes(text));
                // Get the hashed string.  
                return BitConverter.ToString(hashedBytes).Replace("-", "").ToLower();
            }
        }

    }
}
