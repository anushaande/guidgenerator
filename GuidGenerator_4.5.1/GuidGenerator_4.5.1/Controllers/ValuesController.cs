using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace GuidGenerator_4._5._1.Controllers
{
    public class ValuesController : ApiController
    {
        // GET api/values
        public string Get(int id)
        {
            return System.Guid.NewGuid().ToString();
        }

    }
}
