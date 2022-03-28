using System;
using System.ComponentModel.DataAnnotations;

namespace Classifieds.Models
{
    public class User
    {
        public int Id { get; set; }

        public String Name { get; set; }
        public string UserName { get; set; }
        public String Email { get; set; }
        public String Password { get; set; }
        public String Token { get; set; }
        
    }
}