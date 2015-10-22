using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(WebSiteTesteInterop.Startup))]
namespace WebSiteTesteInterop
{
    public partial class Startup {
        public void Configuration(IAppBuilder app) {
            ConfigureAuth(app);
        }
    }
}
