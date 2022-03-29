using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using Classifieds.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace Classifieds.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class SignupController : ControllerBase
    {
        private readonly UserContext _userContext;
        public SignupController(UserContext userContext)
        {
            _userContext = userContext;
        }
        // GET: api/<UserController>
        [HttpGet]
        public List<User> Get()
        {
            return _userContext.Users.ToList();
        }

        // GET api/<UserController>/5
        
        // POST api/<UserController>
        [HttpPost]
        public Response Post([FromBody] User value)
        {
            if (_userContext.Users.Any(e => e.UserName.Equals(value.UserName)))
            {
                return new Response
                {
                    Valid = false,
                    Message = "User Name Already Exist"
                };
            }

            if (_userContext.Users.Any(e => e.Email.Equals(value.Email)))
            {
                return new Response
                {
                    Valid = false,
                    Message = "Email Already Exist"
                };
            }

            value.Password = GetHash(value.Password);
            value.Token = Guid.NewGuid().ToString();
            _userContext.Users.Add(value);
            _userContext.SaveChanges();
            return new Response
            {
                Valid = true,
                Token = value.Token,
                Message = "Success"
            };
        }

        // PUT api/<UserController>/5
        [HttpPut("{id}")]
        public void Put(int id, [FromBody] User value)
        {
        }

        // DELETE api/<UserController>/5
        [HttpDelete("{id}")]
        public void Delete(int id)
        {
        }

        private  string GetHash(string text)
        {
            // SHA512 is disposable by inheritance.  
            using var sha256 = SHA256.Create();
            var hashedBytes = sha256.ComputeHash(Encoding.UTF8.GetBytes(text));
            // Get the hashed string.  
            return BitConverter.ToString(hashedBytes).Replace("-", "").ToLower();
        }
    }
}
