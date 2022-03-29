using Classifieds.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;

namespace Classifieds.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ProductController : ControllerBase
    {
        private readonly UserContext _userContext;
        public ProductController(UserContext userContext)
        {
            _userContext = userContext;
        }
        // GET: api/<UserController>
        [HttpGet]
        public List<object> Get()
        {
            var products = 
                    from u in _userContext.Users
                    from p in _userContext.Products
                    where u.Id == p.UserId
                    select new 
                    { 
                        Id = p.Id,
                        UserName = u.UserName,
                        Description = p.Description,
                        Condition = p.Condition,
                        Packaging = p.Packaging,
                        Warranty = p.Warranty,
                        MinimumBid = p.MinimumBid,
                        Shipping = p.Shipping,
                        Created = p.Created,
                        Updated = p.Updated
                    };

            var list = new List<object>();
            foreach (var product in products) list.Add(product);
            return list;
        }

        // POST api/<UserController>
        [HttpPost]
        public ProductResponse Post([FromBody] Product value)
        {
            var authToken = HttpContext.Request.Headers["Authorization"].ToString().Split(' ');
            var current = _userContext.Users.FirstOrDefault(e => e.Token.Equals(authToken[1]));
            value.Created = DateTime.Now.ToString("yyyy'-'MM'-'dd'T'HH':'mm':'ss");
            value.Updated = value.Created;
            value.ProductId = Guid.NewGuid().ToString();
            if (current != null)
            {
                value.UserId = current.Id;
                var p = _userContext.Products.Add(value);
                _userContext.SaveChanges();

                return new ProductResponse()
                {
                    Message = "Success",
                    Id = p.Entity.Id,
                    UserName = current.UserName,
                    Description = p.Entity.Description,
                    Condition = p.Entity.Condition,
                    Packaging = p.Entity.Packaging,
                    Warranty = p.Entity.Warranty,
                    MinimumBid = p.Entity.MinimumBid,
                    Shipping = p.Entity.Shipping,
                    Created = p.Entity.Created,
                    Updated = p.Entity.Updated
                };
            }
            


            return new ProductResponse()
                {       
                    Message = "User Not Found",
                }; 
        }

        // PUT api/<UserController>/5
        [HttpPut("{id}")]
        public User Put(int id, [FromBody] User value)
        {
            return value;
        }

        // DELETE api/<UserController>/5
        [HttpDelete("{id}")]
        public void Delete(int id)
        {
        }
        
    }
}