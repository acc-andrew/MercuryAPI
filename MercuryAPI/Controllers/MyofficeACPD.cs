using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

using System.Text.Json;
using System.Text.Json.Serialization;
using Microsoft.Data.SqlClient;

namespace MercuryAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class MyofficeACPD : ControllerBase
    {
        // 資料庫連接字串
        private static readonly string connectionString =
            "Server=1302534-NB;Database=MercuryDB;User Id=MercuryUser;Password=654321;TrustServerCertificate=True;";

        // 定義資料模型
        public class MyOfficeACPD_Data
        {
            public string acpd_sid { get; set; }
            public string acpd_cname { get; set; }
            public string acpd_ename { get; set; }
            public string acpd_sname { get; set; }
            public string acpd_email { get; set; }

            
            // 狀況 0=正常 , 99=不正常{ get; set; }
            public char acpd_status { get; set; }

            //是否停用/不可登入
            public bool acpd_stop { get; set; }

            // 停用原因
            public string acpd_stopMemo { get; set; }

            // 登入帳號
            public string acpd_LoginID { get; set; }

            //  登入密碼
            public string acpd_LoginPW { get; set; }

            // 備註
            public string acpd_memo { get; set; }

            // 新增日期
            public DateTime acpd_nowdatetime { get; set; }

            //新增人員代碼
            public string appd_nowid { get; set; }

            // 修改日期
            public DateTime acpd_upddatetitme { get; set; }

            // 修改人員代碼
            public string acpd_updid { get; set; }

        }

        [HttpGet]
        public async Task<string> Get()
        {
            return "Hello World!";
        }

        [HttpPost]
        [Route("Easy")]
        public async Task<IActionResult> PoEasy(string sid)
        {
            return Ok("Hello World!");
        }

        [HttpPost]
        [Route("full")]
        public async Task<IActionResult> Post(MyOfficeACPD_Data data)
        {
            string jsonInput = JsonSerializer.Serialize(data);
            using (var connection = new SqlConnection(connectionString))
            {
                await connection.OpenAsync();

                using (var command = new SqlCommand("createMyofficeACPD", connection))
                {
                    command.CommandType = System.Data.CommandType.StoredProcedure;
                    command.Parameters.AddWithValue("@InputJSON", jsonInput);

                    // 定義輸出參數
                    var statusParam = new SqlParameter
                    {
                        ParameterName = "@StatusOutput",
                        SqlDbType = System.Data.SqlDbType.Int,
                        Direction = System.Data.ParameterDirection.Output
                    };
                    command.Parameters.Add(statusParam);

                    await command.ExecuteNonQueryAsync();

                    // 獲取處理狀態
                    int status = (int)(statusParam.Value ?? -1);
                    return Ok(status.ToString());
                }
            }
        }
    }

}
