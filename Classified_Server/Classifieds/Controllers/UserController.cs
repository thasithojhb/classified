using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Classifieds.Models;
using Microsoft.EntityFrameworkCore;

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace Classifieds.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class UserController : ControllerBase
    {
        private readonly UserContext _userContext;
        public UserController(UserContext userContext)
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
        public User Post([FromBody] User value)
        {
            _userContext.Users.Add(value);
            _userContext.SaveChanges();
            return value;
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
    }
}
