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
        [HttpGet("{id}")]
        public ActionResult<User> Get(int id)
        {
            return _userContext.Users.Find(id);
        }

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
        public User Put(int id, [FromBody] User value)
        {
            /*var oldUser = _userContext.Users.Find(id);
            oldUser.Name = value.Name;
            oldUser.Email = value.Email;
            oldUser.Password = value.Password;

            _userContext.SaveChanges();*/

            value.Id = id;
            _userContext.Entry(value).State = EntityState.Modified;
            _userContext.SaveChanges();
            return value;
        }

        // DELETE api/<UserController>/5
        [HttpDelete("{id}")]
        public void Delete(int id)
        {
            _userContext.Users.Remove(_userContext.Users.Find(id));
            _userContext.SaveChanges();
        }

        private  string GetHash(string text)
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
