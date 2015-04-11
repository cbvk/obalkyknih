using System;
using System.Collections.Generic;
using ScannerClient_obalkyknih.Classes;


namespace ScannerClient_obalkyknih
{
    /// <summary>
    /// Represents metadata record of unit
    /// </summary>
    public class Metadata
    {
        /// <summary>
        /// System number of record
        /// </summary>
        public string Sysno { get; set; }
        
        /// <summary>
        /// Represents enumeration of all fixed Fields (Fields without subfields)
        /// </summary>
        public IEnumerable<KeyValuePair<string, string>> FixedFields { get; set; }

        /// <summary>Represents enumeration of all variable (non-fixed) Fields (with subfields)</summary>
        public IEnumerable<MetadataField> VariableFields { get; set; }

        /// <summary>Represents identifiers contained in metadata</summary>
        public List<MetadataIdentifier> Identifiers { get; set; }
    }

    /// <summary>
    /// Represents one variable (non-fixed) field from metadata record with all subfields
    /// </summary>
    public class MetadataField
    {
        /// <summary>Name/number of Marc field</summary>
        public string TagName { get; set; }

        /// <summary>First indicator of Marc field</summary>
        public string Indicator1 { get; set; }

        /// <summary>Second indicator of Marc field</summary>
        public string Indicator2 { get; set; }

        /// <summary>Enumeration of all pairs of subfield code and value of that subfield</summary>
        public IEnumerable<KeyValuePair<string, string>> Subfields { get; set; }
    }

    /// <summary>
    /// Represents one identifier
    /// </summary>
    public class MetadataIdentifier
    {
        /// <summary>Identifier value</summary>
        public string IdentifierCode { get; set; }

        /// <summary>Identifier description</summary>
        public string IdentifierDescription { get; set; }

        /// <summary>Type of identifier</summary>
        public IdentifierType IdentifierType { get; set; }
    }
}
