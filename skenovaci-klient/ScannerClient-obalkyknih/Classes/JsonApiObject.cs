using System;
using System.Collections.Generic;


namespace ScannerClient_obalkyknih
{

    /// <summary>
    /// Represent json object of request for original toc and cover, used for Serialization
    /// All attributes have same name as in query in javascript api of obalkyknih.cz
    /// </summary>
    public class RequestObject3
    {
        public string isbn { get; set; }
        public string nbn { get; set; }
        public string oclc { get; set; }
        public string part_year { get; set; }
        public string part_volume { get; set; }
        public string part_no { get; set; }
        public string part_name { get; set; }
    }

    #region OBSOLETE API 2.0
    /// <summary>
    /// Represent json object of request for original toc and cover, used for Serialization
    /// All attributes have same name as in query in javascript api of obalkyknih.cz
    /// <remarks>OBSOLETE</remarks>
    /// </summary>
    public class RequestObject
    {
        public string permalink { get; set; }
        public Bibinfo bibinfo { get; set; }
    }

    /// <summary>
    /// Represent json object of response for original toc and cover, used for Serialization
    /// All attributes have same name as in query in javascript api of obalkyknih.cz
    /// <remarks>OBSOLETE</remarks>
    /// </summary>
    public class ResponseObject
    {
        public int rating_count { get; set; }
        public int rating_sum { get; set; }
        public string cover_thumbnail_url { get; set; }
        public List<object> reviews { get; set; }
        public string cover_icon_url { get; set; }
        public string toc_text_url { get; set; }
        public string permalink { get; set; }
        public string backlink_url { get; set; }
        public string toc_thumbnail_url { get; set; }
        public string cover_medium_url { get; set; }
        public string toc_pdf_url { get; set; }
        public Bibinfo bibinfo { get; set; }
    }

    /// <summary>
    /// Represents Bibinfo class of request and response object, used for Serialization
    /// All attributes have same name as in query in javascript api of obalkyknih.cz
    /// </summary>
    public class Bibinfo
    {
        public List<string> authors { get; set; }
        public string title { get; set; }
        public string year { get; set; }
        public string isbn { get; set; }
        public string issn { get; set; }
        public string nbn { get; set; }
        public string oclc { get; set; }
        public string ean { get; set; }
    }
    #endregion
}
