using System.Text;
using System.Linq;

namespace ScannerClient_obalkyknih.Classes
{
    public class Periodical : GeneralRecord
    {
        /// <summary>ISSN identifier of periodical</summary>
        public string Issn { get; set; }

        /// <summary>Volume of particular unit</summary>                                                         MetadataPartNoFieldA
        
        public string PartVolume { get; set; }

        public override void ImportFromMetadata(Metadata metadata)
        {
            this.Issn = ParseIdentifier(metadata, Settings.MetadataIssnField).FirstOrDefault();

            base.PartYear = metadata.VariableFields.Where(vf => Settings.MetadataPublishYearFieldA.Item1.ToString("D3").Equals(vf.TagName))
                                                                          .SelectMany(vf => vf.Subfields)
                                                                          .Where(subf => Settings.MetadataPublishYearFieldA.Item2.ToString().Equals(subf.Key))
                                                                          .Select(subf => subf.Value).FirstOrDefault();

            base.PartNo = metadata.VariableFields.Where(vf => Settings.MetadataPartNoFieldA.Item1.ToString("D3").Equals(vf.TagName))
                                                                          .SelectMany(vf => vf.Subfields)
                                                                          .Where(subf => Settings.MetadataPartNoFieldA.Item2.ToString().Equals(subf.Key))
                                                                          .Select(subf => subf.Value).FirstOrDefault();

            this.PartVolume = metadata.VariableFields.Where(vf => Settings.MetadataVolumeFieldA.Item1.ToString("D3").Equals(vf.TagName))
                                                                          .SelectMany(vf => vf.Subfields)
                                                                          .Where(subf => Settings.MetadataVolumeFieldA.Item2.ToString().Equals(subf.Key))
                                                                          .Select(subf => subf.Value).FirstOrDefault();

            base.ImportFromMetadata(metadata);
        }
    }
}
