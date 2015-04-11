#region License and Copyright

//          SobekCM MARC Library ( Version 1.2 )
//          
//          Copyright (2005-2012) Mark Sullivan. ( Mark.V.Sullivan@gmail.com )
//          
//          This file is part of SobekCM MARC Library.
//          
//          SobekCM MARC Library is free software: you can redistribute it and/or modify
//          it under the terms of the GNU Lesser Public License as published by
//          the Free Software Foundation, either version 3 of the License, or
//          (at your option) any later version.
//            
//          SobekCM MARC Library is distributed in the hope that it will be useful,
//          but WITHOUT ANY WARRANTY; without even the implied warranty of
//          MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//          GNU Lesser Public License for more details.
//            
//          You should have received a copy of the GNU Lesser Public License
//          along with SobekCM MARC Library.  If not, see <http://www.gnu.org/licenses/>.


#endregion

#region Using directives

using System;
using System.IO;
using SobekCM.Bib_Package.MARC;
using SobekCM.Bib_Package.MARC.Parsers;
using SobekCM.Bib_Package.MARC.Writers;
using System.Text;

#endregion

namespace Marc_Demo_App
{
    class Program
    {
        static void Main()
        {
            // DEMO 1: Read a MARC DAT file completely using the IEnumerator interface. and adding it 
            //                 to  a MarcXML output file
            //demo1();

            // DEMO 2: Read the second record from a MARC21 DAT file, w/o using the IEnumerator 
            //                  interface and write that single record to both a XML file and a DAT file, w/o calling
            //                  the writer classes explicitly
            //demo2();

            // DEMO 3: Read the resulting demo2.dat file, change the title, publisher, and add a subject field
            //                 and then save it again
            //demo3();

            // DEMO 4: Read a record from Z39.50 and save it as MarcXML
            demo4();
            //test();
            Console.WriteLine("COMPLETE!");
            Console.ReadLine();
 
        }

        /// <summary> DEMO 1 : Read a MARC DAT file completely using the IEnumerator interface. and adding it to  a MarcXML output file </summary>
        private static void demo1()
        {
            Console.WriteLine("Performing demo1");

            // Create the marc21 exchange reader
            MARC21_Exchange_Format_Parser parser1 = new MARC21_Exchange_Format_Parser("AgricNewCat02.dat");

            // Create the marc xml writer
            MARCXML_Writer writer1 = new MARCXML_Writer("AgricNewCat02.xml");

            try
            {
                // Step through each record from the Marc21 dat file and output to the XML file
                foreach (MARC_Record thisRecord in parser1)
                {
                    writer1.AppendRecord(thisRecord);
                }
            }
            catch (Exception ee)
            {
                Console.WriteLine(ee.StackTrace);
            }
            finally
            {
                // Close all the streams
                parser1.Close();
                writer1.Close();
            }
        }

        /// <summary> DEMO 2: Read the second record from a MARC21 DAT file, w/o using the IEnumerator 
        /// interface and write that single record to both a XML file and a DAT file, w/o calling the writer classes 
        /// explicitly </summary>
        private static void demo2()
        {
            Console.WriteLine("Performing demo2");

            // Create the marc21 exchange reader
            MARC21_Exchange_Format_Parser parser1 = new MARC21_Exchange_Format_Parser();
            
            // This parses and pulls out the first record (discarded)
            parser1.Parse("CIMMYT01.dat");

            // We'll pull again to get the second
             MARC_Record record = parser1.Next();

            // If this is null, say so
            if (record == null)
            {
                Console.WriteLine("Unable to read the second record from test file.");
                return;
            }

            // Save as a MarcXML file
            if (!record.Save_MARC_XML("demo2.xml"))
            {
                Console.WriteLine("Error encountered while writing demo2.xml");
                return;
            }
         
            // Save as a single Marc21 file
            if ( !record.Save_MARC21("demo2.dat"))
            {
                Console.WriteLine("Error encountered while writing demo2.dat");
            }
        }

        /// <summary> DEMO 3: Read the resulting demo2.dat file, change the title, publisher, and add 
        /// a subject field and then save it again</summary>
        private static void demo3()
        {
            Console.WriteLine("Performing demo3");

            // Create the marc21 exchange reader
            MARC21_Exchange_Format_Parser parser1 = new MARC21_Exchange_Format_Parser();

            // Read the record
            MARC_Record record = parser1.Parse("demo2.dat");

            // If this is null, say so
            if (record == null)
            {
                Console.WriteLine("Unable to read the demo2.dat in the 3rd demo portion");
                return;
            }

            // Change the title field ( 245 )
            record[245][0].Add_NonRepeatable_Subfield('a', "New Title");

            // Also change the creator field (110 in this case)
            record[110][0].Add_NonRepeatable_Subfield('a', "Corn Maze Production, Incorporated");

            // Add a new field to record
            MARC_Field newSubject = record.Add_Field( 650, ' ', '0' );
            newSubject.Add_Subfield('a', "Soils");
            newSubject.Add_Subfield('x', "Phosphorous content");
            newSubject.Add_Subfield('z', "Indonesia");

            // Save this as XML and also as Marc21
            record.Save_MARC_XML("demo3.xml");
            record.Save_MARC21("demo3.dat");
        }

        private static void demo4()
        {
            Console.WriteLine("Performing demo4 ( z39.50 )");

            try
            {
                // Create the Z39.50 endpoint
                Z3950_Endpoint endpoint = new Z3950_Endpoint("Moravian Library in Brno", "aleph.mzk.cz", 9991, "MZK01-UTF");

                // Retrieve the record by primary identifier
                string out_message;
                MARC_Record record_from_z3950 = MARC_Record_Z3950_Retriever.Get_Record(/*7*/1063, "2610356038"/*"80-85609-28-2"*/, endpoint, out out_message,
                    Record_Character_Encoding.Unicode);
                //MARC_Record record_from_z3950 = MARC_Record_Z3950_Retriever.Get_Record_By_Primary_Identifier("4543338", endpoint, out out_message);

                // Display any error message encountered
                if (record_from_z3950 == null)
                {
                    if (out_message.Length > 0)
                    {
                        Console.WriteLine(out_message);
                    }
                    else
                    {
                        Console.WriteLine("Unknown error occurred during Z39.50 request");
                    }
                    return;
                }
                Console.WriteLine(record_from_z3950.Get_Data_Subfield(100,'a'));
                Console.WriteLine(record_from_z3950);
                // Write as MARCXML
                record_from_z3950.Save_MARC_XML("C:\\Temp\\demo4.xml");
            }
            catch (Exception ee)
            {
                Console.WriteLine("EXCEPTION CAUGHT while performing Z39.50 demo. ( " + ee.Message + " )");
            }

        }
    }
}
