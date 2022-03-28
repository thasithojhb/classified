using Microsoft.EntityFrameworkCore;

namespace Classifieds.Models
{
    public sealed class UserContext : DbContext
    {
        public UserContext(DbContextOptions<UserContext> options) : base(options)
        {
            Database.EnsureCreated();
        }
        public DbSet<User> Users { get; set; }
        public DbSet<Product> Products { get; set; }
    }
}