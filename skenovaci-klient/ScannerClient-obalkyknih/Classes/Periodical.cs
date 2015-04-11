using System.Text;
using System.Linq;

namespace ScannerClient_obalkyknih.Classes
{
    public class Periodical : GeneralRecord
    {
        /// <summary>ISSN identifier of periodical</summary>
        public string Issn { get; set; }

        /// <summary>Volume of particular unit</summary>
        public string PartVolume { get; set; }

        public override void ImportFromMetadata(Metadata metadata)
        {
            this.Issn = ParseIdentifier(metadata, Settings.MetadataIssnField).FirstOrDefault();
            base.ImportFromMetadata(metadata);
        }
    }
}
