using Sphdhv.KlantPortaal.Access.Deelnemer.Interface;
using Sphdhv.KlantPortaal.Common;
using Sphdhv.KlantPortaal.Host.WebHost.Environment.KlantPortaal;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using System.IO;
using OfficeOpenXml;
using Sphdhv.UserExportTool.Icatt.Export.Engine.Excel.EpplusService;
using Sphdhv.KlantPortaal.Access.Deelnemer.Contract;
using System.Reflection;

namespace Sphdhv.UserExportTool
{
    class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("Wait for it");

            Console.WriteLine("did you read the readme.txt?");

            var factoryContainer = new KlantPortaalFactoryContainer();
            var proxy = factoryContainer.ProxyFactory.CreateProxy<IDeelnemerAccess>(new KlantPortaalContext());

            //get data
            var deelnemers = proxy.Deelnemers();

            //create excel
            var excelEngine = new EpplusExcelExportEngine();
            var excelData = excelEngine.ExportExcel(deelnemers.Select( d => new { d.Bsn,  d.Email }), new string[] { "Bsn", "Email" });

            //save to file
             using (var fileStream = new FileStream("../SPHDHVEmails.xlsx", FileMode.OpenOrCreate, FileAccess.Write))
            {
                excelData.Seek(0, SeekOrigin.Begin);
                excelData.CopyTo(fileStream);
                var writer = new StreamWriter(fileStream); 
                Console.WriteLine($"export saved at {fileStream.Name}");
            }
                       
            Console.WriteLine("Press any key to close");
            Console.ReadKey();

        }


    }



    namespace Icatt.Export.Engine.Excel.EpplusService
    {
        public class EpplusExcelExportEngine
        {

            public Stream ExportExcel(IEnumerable<object> tableData, string[] tableHeaders)
            {
                var stream = new MemoryStream(1 * 1024 * 1024);

                using (var package = new ExcelPackage())
                {
                    package.Compatibility.IsWorksheets1Based = false;
                    ExcelWorksheet worksheet = package.Workbook.Worksheets.Add("MIP Export");

                    var cells = worksheet.Cells;

                    //TODO Add header row
                    for (int i = 0; i < tableHeaders.Length; i++)
                    {
                        var cell = cells[1, i + 1];

                        cell.Value = tableHeaders[i];
                        cell.Style.Font.Bold = true;
                        cell.Style.HorizontalAlignment = OfficeOpenXml.Style.ExcelHorizontalAlignment.Center;
                    }

                    var rowcount = 0;
                    foreach (var item in tableData)
                    {
                        rowcount++;

                        var colcount = 0;
                        foreach (var prop in item.GetType().GetProperties(BindingFlags.Instance | BindingFlags.Public))
                        {
                            colcount++;

                            //Indexers are 1 based
                            var cell = cells[rowcount + 1, colcount  ];
                 
                            cell.Value = prop.GetValue(item);

                            FormatCell(cell, prop?.GetType());

                          
                        }

                        
                    }


                    package.SaveAs(stream);
                }
                stream.Position = 0;

                return stream;
            }

            private void FormatCell(ExcelRange cell, Type type)
            {
                if (type == null)
                    return;

                if (type == typeof(DateTime))
                {
                    cell.Style.Numberformat.Format = "dd-mm-yyyy";
                }
                else if (type == typeof(float) || type == typeof(double) || type == typeof(decimal) || type == typeof(int) || type == typeof(uint) || type == typeof(long) || type == typeof(ulong))
                {
                    cell.Style.Numberformat.Format = "#,###,###,##0";
                }
                else
                {
                    //Text
                    var value = cell.Value as string;
                    if (value == null) return;

   
                }



            }
        }
    }



}
