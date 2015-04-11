using System.Text;
using System.Linq;
using System.Collections.Generic;
using System;

namespace ScannerClient_obalkyknih.Classes
{
    public class Monograph : GeneralRecord
    {
        /// <summary>Duplicate identifiers found in metadata (only one of each type, if more found, others are ignored)</summary>
        public Dictionary<IdentifierType, string> DuplicateIdentifiers { get; set; }

        /// <summary>Indicates whether part metadata or union metadata should be imported</summary>
        /// <remarks>Important to set before metadata retrieval</remarks>
        public bool IsUnionRequested { get; set; }

        public string Isbn { get; set; }

        public string PartIsbn { get; set; }

        public string PartCnb { get; set; }

        public string PartOclc { get; set; }

        public string PartEan { get; set; }

        public string PartUrn { get; set; }

        public string PartTitle { get; set; }

        public string PartAuthors { get; set; }
        
        public string PartCustom { get; set; }

        public List<MetadataIdentifier> listIdentifiers { get; set; }

        public Monograph()
        {
        }

        public override void ImportFromMetadata(Metadata metadata)
        {
            if (this.IsUnionRequested)
            {
                this.Isbn = this.Cnb = this.Oclc = this.Ean = this.Urn = null;

                this.Isbn = ParseIdentifier(metadata, Settings.MetadataIsbnField).FirstOrDefault();
                base.ImportFromMetadata(metadata);
                if (metadata.Identifiers.Count > 3)
                {
                    // nalezen souborny zaznam s vyssim poctem identifikatoru = nami skenovana monografie je nevyznamneho nazvu
                    this.PartCnb = null;
                    this.PartOclc = null;
                }
                else
                {
                    // souborny zaznam obsahuje jine ISBN napr. na krabici svazku = souborny zaznam bude obsahovat pouze rozdilne zaznamy (s nejvetsi pravdepodobnosti ISBN)
                    if (this.PartIsbn == this.Isbn) this.Isbn = null;
                    if (this.PartCnb == base.Cnb) base.Cnb = null;
                    if (this.PartEan == base.Ean) base.Ean = null;
                    if (this.PartOclc == base.Oclc) base.Oclc = null;
                }
            }
            else
            {
                ImportPartFromMetadata(metadata);
            }
        }

        private void ImportPartFromMetadata(Metadata metadata)
        {
            //partTitle
            this.PartTitle = ParseTitle(metadata);
            //partAuthor
            this.PartAuthors = ParseAuthors(metadata);
            //partYear
            this.PartYear = ParseYear(metadata);
            //identifiers list
            this.listIdentifiers = metadata.Identifiers;

            //Parse identifiers
            SetPartIdentfier(metadata, IdentifierType.CNB, Settings.MetadataCnbField);
            SetPartIdentfier(metadata, IdentifierType.EAN, Settings.MetadataEanField);
            SetPartIdentfier(metadata, IdentifierType.OCLC, Settings.MetadataOclcField);
            this.Custom = metadata.Sysno;

            if (this.listIdentifiers.Count > 2)
            {
                //choose part and union ISBNs
                int idUnion = -1;
                int idPart = -1;
                int j = 0;
                foreach (MetadataIdentifier identifier in this.listIdentifiers)
                {
                    //here we trying to find requested ISBN record
                    if (base.IdentifierValue == identifier.IdentifierCode) idPart = j;
                    //here we trying to find union record
                    if (identifier.IdentifierDescription.ToLower().IndexOf("soubor") != -1 && idUnion == -1) idUnion = j+1;
                    j++;
                }
                this.Isbn = idUnion == -1 ? null : this.listIdentifiers[idUnion].IdentifierCode;
                this.PartIsbn = idPart == -1 ? this.listIdentifiers[1].IdentifierCode : this.listIdentifiers[idPart].IdentifierCode;
            }
            else
            {
                //one ISBN
                SetPartIdentfier(metadata, IdentifierType.ISBN, Settings.MetadataIsbnField);
            }
        }

        private void SetPartIdentfier(Metadata metadata, IdentifierType idType, Tuple<int, char, char?, char?> metadataSettings)
        {
            IEnumerable<string> identifiers = ParseIdentifier(metadata, metadataSettings);
            
            string first = identifiers.FirstOrDefault();
            string second = identifiers.Where(id => !id.Equals(first)).FirstOrDefault();
            DuplicateIdentifiers = new Dictionary<IdentifierType, string>();
            DuplicateIdentifiers.Add(idType, first);
            second = second == null ? second = first : second;
            
            switch (idType)
            {
                case IdentifierType.ISBN:
                    this.PartIsbn = second;
                    break;
                case IdentifierType.CNB:
                    this.PartCnb = second;
                    break;
                case IdentifierType.EAN:
                    this.PartEan = second;
                    break;
                case IdentifierType.OCLC:
                    this.PartOclc = second;
                    break;
            }
        }
    }
}
