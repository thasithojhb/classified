using System;
using Microsoft.AspNetCore.Routing.Matching;

namespace Classifieds.Models
{
    public class UserProducts
    {
        public int Id { get; set; }
        
        public String UserName { get; set; }
        
        public String Description { get; set; }
        
        public String Condition { get; set; }

        public String Packaging { get; set; }

        public String Warranty { get; set; }

        public double MinimumBid { get; set; }
        
        public String Shipping { get; set; }
        public String Created { get; set; }
        public String Updated { get; set; }
    }
    
}