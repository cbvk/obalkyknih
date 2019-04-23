using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.ComponentModel;
using System.Windows;
using System.Windows.Controls;
using System.Net;
using System.Xml.Linq;
using System.IO;
using SobekCM;
using SobekCM.Bib_Package.MARC.Parsers;
using SobekCM.Bib_Package.MARC;
using System.Windows.Media.Imaging;
using Newtonsoft.Json;

namespace ScannerClient_obalkyknih.Classes
{
    /// <summary> Class used for retrieval of metadata </summary>
    public static class MetadataRetriever
    {
        const string CRYPTO_KEY = "0kcz,ApIv.3*";

        /// <summary>
        /// Retrieves Metadata for record specified by given identifier and saves important messages to list of warnings
        /// </summary>
        /// <param name="identifierType">Type of identifier used for metadata retrieval</param>
        /// <param name="value">Value of identifier used for metadata retrieval</param>
        /// <param name="warnings">Enumeration of important messages aquired during metadata retrieval or empty list</param>
        /// <returns>Retrieved Metadata of record with given identifier</returns>
        public static IList<Metadata> RetrieveMetadata(GeneralRecord generalRecord)
        {
            string identifierValue;
            switch (generalRecord.IdentifierType)
            {
                case IdentifierType.BARCODE:
                    identifierValue = generalRecord.Barcode;
                    break;
                case IdentifierType.CNB:
                    identifierValue = generalRecord.Cnb;
                    break;
                case IdentifierType.EAN:
                    identifierValue = generalRecord.Ean;
                    break;
                case IdentifierType.ISBN:
                    identifierValue = generalRecord.IdentifierValue;
                    break;
                case IdentifierType.ISMN:
                    identifierValue = generalRecord.Ismn;
                    break;
                case IdentifierType.ISSN:
                    identifierValue = ((Periodical)generalRecord).Issn;
                    break;
                case IdentifierType.OCLC:
                    identifierValue = generalRecord.Oclc;
                    break;
                case IdentifierType.URN:
                    identifierValue = generalRecord.Urn;
                    break;
                default:
                    identifierValue = generalRecord.Barcode;
                    break;
            }
            IList<Metadata> metadata = null;
            if (Settings.IsXServerEnabled && 
                !((generalRecord is Monograph) && (generalRecord as Monograph).IsUnionRequested)) //for union only Z39.50
            {
                metadata = RetrieveMetadataByXServer(generalRecord.IdentifierType, identifierValue);
            }
            else
            {
                bool isUnion = (generalRecord is Monograph && (generalRecord as Monograph).IsUnionRequested);
                metadata = RetrieveMetadataByZ39(generalRecord.IdentifierType, identifierValue, isUnion);
            }

            return metadata;
        }

        // Retrieves metadata from X-Server
        private static IList<Metadata> RetrieveMetadataByXServer(IdentifierType identifierType, string value)
        {
            //create X-Server request
            string xServerUrl = Settings.XServerUrl;
            string xServerBaseName = Settings.XServerBase;

            string identifierFieldCode;
            switch (identifierType)
            {
                case IdentifierType.BARCODE:
                    identifierFieldCode = "BAR";
                    break;
                case IdentifierType.CNB:
                    identifierFieldCode = "CNB";
                    break;
                case IdentifierType.EAN:
                    throw new NotImplementedException("Nelze vyhledávat podle EAN pomocí X-Server");
                case IdentifierType.ISBN:
                    identifierFieldCode = "SBN";
                    break;
                case IdentifierType.ISSN:
                    identifierFieldCode = "SSN";
                    break;
                case IdentifierType.OCLC:
                    throw new NotImplementedException("Nelze vyhledávat podle OCLC pomocí X-Server");
                default:
                    identifierFieldCode = "BAR";
                    break;
            }


            string errorText = "";
            if (string.IsNullOrWhiteSpace(xServerUrl))
            {
                errorText += "X-Server URL, ";
            }
            if (string.IsNullOrWhiteSpace(xServerBaseName))
            {
                errorText += "X-Server Database";
            }
            errorText = errorText.TrimEnd(new char[] { ' ', ',' });

            if (!string.IsNullOrEmpty(errorText))
            {
                throw new ArgumentException("V nastaveních chybí následující údaje: " + errorText);
            }

            string resultSetURLPart = "/X?op=find&code=" + identifierFieldCode + "&request=" + value + "&base=" + xServerBaseName;
            string sysNoUrlPart = "/X?op=present&set_entry=1&set_number=";

            if (!xServerUrl.StartsWith("http"))
            {
                xServerUrl = "https://" + xServerUrl;
            }
            // if /X is already in name, remove 'X'
            if (xServerUrl.EndsWith("/X"))
            {
                xServerUrl.TrimEnd('X');
            }
            // remove trailing '/'
            xServerUrl.TrimEnd('/');

            //Metadata metadata = new Metadata();
            List<Metadata> metadataList = new List<Metadata>();
            List<string> resultSetNumbers = new List<string>();
            using (WebClient webClient = new WebClient())
            {
                Stream stream = webClient.OpenRead(xServerUrl + resultSetURLPart);
                XDocument doc = XDocument.Load(stream);
                if (doc.Descendants("set_number").Count() > 0)
                {
                    foreach (XElement resultSet in doc.Descendants("set_number"))
                    {
                        resultSetNumbers.Add(resultSet.Value);
                    }
                }
                else
                {
                    throw new Z39Exception("Nenalezen vhodný záznam.");
                }

                foreach (string resultSetNumber in resultSetNumbers)
                {
                    Metadata metadata = new Metadata();
                    stream = webClient.OpenRead(xServerUrl + sysNoUrlPart + resultSetNumber);
                    doc = XDocument.Load(stream);

                    metadata.Sysno = doc.Descendants("doc_number").Single().Value;

                    IEnumerable<XElement> fixedFieldsXml = from el in doc.Descendants("fixfield")
                                                           select el;
                    IEnumerable<XElement> variableFieldsXml = from el in doc.Descendants("varfield")
                                                              select el;

                    List<KeyValuePair<string, string>> fixedFields = new List<KeyValuePair<string, string>>();
                    foreach (var field in fixedFieldsXml)
                    {
                        var fixedName = field.Attribute("id").Value;
                        var fixedValue = field.Value;
                        fixedFields.Add(new KeyValuePair<string, string>(fixedName, fixedValue));
                    }
                    metadata.FixedFields = fixedFields;

                    List<MetadataField> variableFields = new List<MetadataField>();
                    foreach (var field in variableFieldsXml)
                    {
                        MetadataField metadataField = new MetadataField();
                        metadataField.TagName = field.Attribute("id").Value;
                        metadataField.Indicator1 = field.Attribute("i1").Value;
                        metadataField.Indicator2 = field.Attribute("i2").Value;
                        IEnumerable<KeyValuePair<string, string>> subfields = from sf in field.Elements("subfield")
                                                                              select new KeyValuePair<string, string>(sf.Attribute("label").Value, sf.Value);
                        metadataField.Subfields = subfields;
                        variableFields.Add(metadataField);
                    }
                    metadata.VariableFields = variableFields;

                    // Get identifiers list (ISBNs + 902a yearbooks)
                    List<MetadataIdentifier> Identifiers = getIdentifiersList(metadata);
                    metadata.Identifiers = Identifiers;

                    metadataList.Add(metadata);
                }
            }
            return metadataList;
        }

        // Retrieves metadata from Z39.50 server
        private static IList<Metadata> RetrieveMetadataByZ39(IdentifierType identifierType, string value, bool isUnion)
        {
            string z39Server = Settings.Z39ServerUrl;
            int z39Port = Settings.Z39Port;
            string z39Base = Settings.Z39Base;
            string z39UserName = Settings.Z39UserName;
            string z39Password = Settings.Z39Password;
            Record_Character_Encoding z39Encoding = Settings.Z39Encoding;
            //Set union Z39.50
            if (isUnion)
            {
                z39Server = Settings.Z39UnionServerUrl;
                z39Port = Settings.Z39UnionPort;
                z39Base = Settings.Z39UnionBase;
                z39Encoding = Settings.Z39UnionEncoding;
                z39UserName = null;
                z39Password = null;
            }

            int identifierFieldNumber;
            switch (identifierType)
            {
                case IdentifierType.BARCODE:
                    identifierFieldNumber = Settings.Z39BarcodeField;
                    break;
                case IdentifierType.CNB:
                    if (isUnion)
                    {
                        identifierFieldNumber = Settings.DEFAULT_NKP_CNB_FIELD;
                    }
                    else
                    {
                        identifierFieldNumber = Settings.Z39CnbField;
                    }
                    break;
                case IdentifierType.EAN:
                    identifierFieldNumber = Settings.Z39EanField;
                    break;
                case IdentifierType.ISBN:
                    identifierFieldNumber = Settings.Z39IsbnField;
                    break;
                case IdentifierType.ISSN:
                    identifierFieldNumber = Settings.Z39IssnField;
                    break;
                case IdentifierType.ISMN:
                    identifierFieldNumber = Settings.Z39IsmnField;
                    break;
                case IdentifierType.OCLC:
                    identifierFieldNumber = Settings.Z39OclcField;
                    break;
                default:
                    identifierFieldNumber = Settings.DEFAULT_FIELD;
                    break;
            }

            //validate
            string errorText = "";
            if (string.IsNullOrEmpty(z39Server))
            {
                errorText += "Z39.50 Server URL; ";
            }
            if (z39Port <= 0)
            {
                errorText += "Z39.50 Sever Port; ";
            }
            if (string.IsNullOrEmpty(z39Base))
            {
                errorText += "Z39.50 Databáze; ";
            }
            if (identifierFieldNumber <= 0)
            {
                errorText += "Vyhledávací atribut";
            }

            if (!string.IsNullOrEmpty(errorText))
            {
                throw new ArgumentException("V nastaveních chybí následující údaje: " + errorText);
            }

            List<Metadata> metadataList = new List<Metadata>();
            string errorMessage = "";
            try
            {
                Z3950_Endpoint endpoint;
                if (string.IsNullOrEmpty(z39UserName))
                {
                    endpoint = new Z3950_Endpoint("Z39.50",
                        z39Server, (uint)z39Port, z39Base);
                }
                else
                {
                    endpoint = new Z3950_Endpoint("Z39.50",
                        z39Server, (uint)z39Port, z39Base, z39UserName);
                    endpoint.Password = z39Password ?? "";
                }

                // Retrieve the record by primary identifier
                IEnumerable<MARC_Record> recordsFromZ3950 = MARC_Record_Z3950_Retriever.Get_Record(
                    identifierFieldNumber, '"'+value+'"', endpoint, out errorMessage, z39Encoding);

                if (recordsFromZ3950 != null)
                {
                    foreach (MARC_Record record in recordsFromZ3950)
                    {
                        Metadata metadata = new Metadata();
                        // Sysno
                        metadata.Sysno = record.Control_Number;
                        metadata.FixedFields = MarcGetFixedFields(record);
                        metadata.VariableFields = MarcGetVariableFields(record);

                        // Get identifiers list (ISBNs + 902a yearbooks)
                        List<MetadataIdentifier> Identifiers = getIdentifiersList(metadata);
                        metadata.Identifiers = Identifiers;

                        // Add to list
                        metadataList.Add(metadata);
                    }
                }
            }
            catch (Exception)
            {
                throw new Z39Exception("Nastala neočekávaná chyba během Z39.50 dotazu.");
            }

            // Display any error message encountered
            if (metadataList.Count == 0)
            {
                if (errorMessage.Length > 0)
                {
                    if (errorMessage.Contains("No matching record found in Z39.50 endpoint"))
                    {
                        errorMessage = "Nenalezen vhodný záznam.";
                    }

                    else if (errorMessage.Contains("Connection could not be made to"))
                    {
                        errorMessage = "Nebylo možné navázat spojení s " +
                            errorMessage.Substring(errorMessage.LastIndexOf(' '));
                    }

                    throw new Z39Exception(errorMessage);
                }
                else
                {
                    throw new Z39Exception("Nastala neznámá chyba během Z39.50 dotazu");
                }
            }
            return metadataList;
        }

        // Build identifiers list (ISBNs + 902a yearbooks)
        private static List<MetadataIdentifier> getIdentifiersList(Metadata metadata)
        {
            List<MetadataIdentifier> Identifiers = new List<MetadataIdentifier>();

            // No identifier (default value if union record not found)
            MetadataIdentifier nullIdentifier = new MetadataIdentifier();
            nullIdentifier.IdentifierType = IdentifierType.ISBN;
            nullIdentifier.IdentifierCode = null;
            nullIdentifier.IdentifierDescription = "nebylo nalezeno ISBN souborného záznamu";
            Identifiers.Add(nullIdentifier);

            // MARC21 ISBNs
            foreach (var isbn in metadata.VariableFields.Where(vf => Settings.MetadataIsbnField.Item1.ToString("D3").Equals(vf.TagName)))
            {
                MetadataIdentifier identifierToInsert = new MetadataIdentifier();
                List<string> subfDescription = new List<string>();
                foreach (var subf in isbn.Subfields)
                {
                    if (subf.Key == "a") identifierToInsert.IdentifierCode = subf.Value;
                    if (subf.Key == "q") subfDescription.Add(subf.Value);
                }
                identifierToInsert.IdentifierType = IdentifierType.ISBN;
                identifierToInsert.IdentifierDescription = string.Join(" ", subfDescription);
                Identifiers.Add(identifierToInsert);
            }

            // ISBNs of yearbooks (902a)
            foreach (var isbn in metadata.VariableFields.Where(vf => Settings.MetadataIsbnYearbookField.Item1.ToString("D3").Equals(vf.TagName)))
            {
                MetadataIdentifier identifierToInsert = new MetadataIdentifier();
                List<string> subfDescription = new List<string>();
                foreach (var subf in isbn.Subfields)
                {
                    if (subf.Key == "a") identifierToInsert.IdentifierCode = subf.Value;
                    if (subf.Key == "q") subfDescription.Add(subf.Value);
                }
                identifierToInsert.IdentifierType = IdentifierType.ISBN;
                identifierToInsert.IdentifierDescription = string.Join(" ", subfDescription);
                Identifiers.Add(identifierToInsert);
            }

            return Identifiers;
        }

        // Returns collection of fixed fields from Marc21 record
        private static IEnumerable<KeyValuePair<string, string>> MarcGetFixedFields(MARC_Record record)
        {
            List<KeyValuePair<string, string>> fixedFields = new List<KeyValuePair<string, string>>();
            fixedFields.Add(new KeyValuePair<string, string>("LDR", record.Leader));
            
            foreach (int thisTag in record.Fields.Keys)
            {
                List<MARC_Field> matchingFields = record.Fields[thisTag];
                foreach (MARC_Field thisField in matchingFields)
                {
                    if (thisField.Subfield_Count == 0)
                    {
                        if (thisField.Control_Field_Value.Length > 0)
                        {
                            fixedFields.Add(new KeyValuePair<string, string>(
                                thisField.Tag.ToString().PadLeft(3, '0'),
                                thisField.Control_Field_Value));
                            
                        }
                    }
                }
            }
            return fixedFields;
        }

        // Returns collection of non-fixed (variable) fields from Marc21 record
        private static IEnumerable<MetadataField> MarcGetVariableFields(MARC_Record record)
        {
            List<MetadataField> metadataFieldsList = new List<MetadataField>();
            
            // Step through each field in the collection
            foreach (int thisTag in record.Fields.Keys)
            {
                List<MARC_Field> matchingFields = record.Fields[thisTag];
                foreach (MARC_Field thisField in matchingFields)
                {
                    if (thisField.Subfield_Count != 0)
                    {
                        MetadataField metadataField = new MetadataField();
                        metadataField.TagName = thisField.Tag.ToString().PadLeft(3, '0');
                        metadataField.Indicator1 = thisField.Indicator1.ToString();
                        metadataField.Indicator2 = thisField.Indicator2.ToString();
                        List<KeyValuePair<string, string>> subfields = new List<KeyValuePair<string, string>>();
                        // Build the complete line
                        foreach (MARC_Subfield thisSubfield in thisField.Subfields)
                        {
                            subfields.Add(new KeyValuePair<string, string>
                                (thisSubfield.Subfield_Code.ToString(), thisSubfield.Data));
                        }
                        metadataField.Subfields = subfields;
                        metadataFieldsList.Add(metadataField);
                    }
                }
            }
            return metadataFieldsList;
        }

        // Returns encrypted sigla (encrypted in compliance with NodeJS aes-256-cbc, using CRYPTO_KEY as password)
        private static string EcryptSigla(string sigla)
        {
            return CryptoUtility.Encrypt(sigla, CryptoUtility.HashSHA256(CRYPTO_KEY));
        }
    }
}
