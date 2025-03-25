using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

using System.Text.Json;
using System.Text.Json.Serialization;
using Microsoft.Data.SqlClient;
using System.Reflection;

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
            public int acpd_status { get; set; }

            //是否停用/不可登入
            public bool acpd_stop { get; set; }

            // 停用原因
            public string acpd_stopMemo { get; set; }

            // 登入帳號
            public string acpd_LoginID { get; set; }

            //  登入密碼
            public string acpd_LoginPWD { get; set; }

            // 備註
            public string acpd_memo { get; set; }

            // 新增日期
            public DateTime acpd_nowdatetime { get; set; }

            //新增人員代碼
            public string acpd_nowid { get; set; }

            // 修改日期
            public DateTime acpd_upddatetime { get; set; }

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

                using (var command = new SqlCommand("sp_createMyofficeACPD", connection))
                {
                    command.CommandType = System.Data.CommandType.StoredProcedure;
                    //command.Parameters.AddWithValue("@InputJSON", jsonInput);

                    // insert variable to parameters
                    command.Parameters.AddWithValue("@ACPD_SID", data.acpd_sid);
                    command.Parameters.AddWithValue("@ACPD_Cname", data.acpd_cname);
                    command.Parameters.AddWithValue("@ACPD_Ename", data.acpd_ename);

                    command.Parameters.AddWithValue("@ACPD_Sname", data.acpd_sname);
                    command.Parameters.AddWithValue("@ACPD_Email", data.acpd_email);
                    command.Parameters.AddWithValue("@ACPD_Status", data.acpd_status);

                    command.Parameters.AddWithValue("@ACPD_Stop", data.acpd_stop);
                    command.Parameters.AddWithValue("@ACPD_StopMemo", data.acpd_stopMemo);
                    command.Parameters.AddWithValue("@ACPD_LoginID", data.acpd_LoginID);

                    command.Parameters.AddWithValue("@ACPD_LoginPWD", data.acpd_LoginPWD);
                    command.Parameters.AddWithValue("@ACPD_Memo", data.acpd_memo);
                    command.Parameters.AddWithValue("@ACPD_NowID", data.acpd_nowid);

                    command.Parameters.AddWithValue("@ACPD_UPDID", data.acpd_updid);

                    command.Parameters.AddWithValue("@ACPD_NowDateTime", data.acpd_nowdatetime);
                    command.Parameters.AddWithValue("@ACPD_UPDDateTime", data.acpd_upddatetime);


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

        [HttpPut]
        [Route("Update")]
        public async Task<IActionResult> UpdateACPD(MyOfficeACPD_Data data)
        {
            using (var connection = new SqlConnection(connectionString))
            {
                await connection.OpenAsync();

                using (var command = new SqlCommand("sp_updateMyofficeACPD", connection))
                {
                    command.CommandType = System.Data.CommandType.StoredProcedure;
                    //command.Parameters.AddWithValue("@InputJSON", jsonInput);

                    // insert variable to parameters
                    command.Parameters.AddWithValue("@ACPD_SID", data.acpd_sid);
                    command.Parameters.AddWithValue("@ACPD_Cname", data.acpd_cname);
                    command.Parameters.AddWithValue("@ACPD_Ename", data.acpd_ename);

                    command.Parameters.AddWithValue("@ACPD_Sname", data.acpd_sname);
                    command.Parameters.AddWithValue("@ACPD_Email", data.acpd_email);
                    command.Parameters.AddWithValue("@ACPD_Status", data.acpd_status);

                    command.Parameters.AddWithValue("@ACPD_Stop", data.acpd_stop);
                    command.Parameters.AddWithValue("@ACPD_StopMemo", data.acpd_stopMemo);
                    command.Parameters.AddWithValue("@ACPD_LoginID", data.acpd_LoginID);

                    command.Parameters.AddWithValue("@ACPD_LoginPWD", data.acpd_LoginPWD);
                    command.Parameters.AddWithValue("@ACPD_Memo", data.acpd_memo);
                    command.Parameters.AddWithValue("@ACPD_NowID", data.acpd_nowid);

                    command.Parameters.AddWithValue("@ACPD_UPDID", data.acpd_updid);

                    //command.Parameters.AddWithValue("@ACPD_NowDateTime", data.acpd_nowdatetime);
                    //command.Parameters.AddWithValue("@ACPD_UPDDateTime", data.acpd_upddatetime);


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

        [HttpDelete]
        [Route("Delete")]
        public async Task<IActionResult> DeleteACPD(string SID)
        {
            using (var connection = new SqlConnection(connectionString))
            {
                await connection.OpenAsync();

                using (var command = new SqlCommand("sp_deleteMyofficeACPD", connection))
                {
                    command.CommandType = System.Data.CommandType.StoredProcedure;
                    //command.Parameters.AddWithValue("@InputJSON", jsonInput);

                    // insert variable to parameters
                    command.Parameters.AddWithValue("@ACPD_SID", SID);

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
