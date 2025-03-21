using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace MercuryAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class MyofficeACPD : ControllerBase
    {

        [HttpGet]
        public async Task<string> Get()
        {
            return "Hello World!";
        }
    }

}
