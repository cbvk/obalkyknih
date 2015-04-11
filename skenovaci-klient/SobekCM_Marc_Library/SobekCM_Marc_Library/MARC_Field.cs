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
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;
using System.Text;

#endregion

namespace SobekCM.Bib_Package.MARC
{
	/// <summary> Stores the information for a field in a MARC21 record ( <see cref="MARC_Record"/> )</summary>
	/// <remarks>Object created by Mark V Sullivan (2006) for University of Florida's Digital Library Center.</remarks>
	public class MARC_Field
	{
	    private string data;
	    private List<MARC_Subfield> subfields;

	    #region Constructors

	    /// <summary> Constructor for a new instance of the MARC_Field class </summary>
	    public MARC_Field()
	    {
	        subfields = new List<MARC_Subfield>();

	        Tag = -1;
	        Indicator1 = ' ';
	        Indicator2 = ' ';
	    }

	    /// <summary> Constructor for a new instance of the MARC_Field class </summary>
	    /// <param name="Tag">Tag for this data field</param>
	    /// <param name="Control_Field_Value">Value for this control field </param>
	    public MARC_Field( int Tag, string Control_Field_Value )
	    {
	        subfields = new List<MARC_Subfield>();

	        this.Tag = Tag;
	        data = Control_Field_Value;
	        Indicator1 = ' ';
	        Indicator2 = ' ';
	    }

	    /// <summary> Constructor for a new instance of the MARC_Field class </summary>
	    /// <param name="Tag">Tag for this data field</param>
	    /// <param name="Indicator1">First indicator</param>
	    /// <param name="Indicator2">Second indicator</param>
	    public MARC_Field( int Tag, char Indicator1, char Indicator2 )
	    {
	        subfields = new List<MARC_Subfield>();

	        this.Tag = Tag;
	        this.Indicator1 = Indicator1;
	        this.Indicator2 = Indicator2;
	    }

	    /// <summary> Constructor for a new instance of the MARC_Field class </summary>
	    /// <param name="Tag">Tag for this data field</param>
	    /// <param name="Indicators">Indicators</param>
	    /// <param name="Control_Field_Value">Value for this control field</param>
	    public MARC_Field( int Tag, string Indicators, string Control_Field_Value )
	    {
	        subfields = new List<MARC_Subfield>();

	        this.Tag = Tag;
	        data = Control_Field_Value;

	        if (Indicators.Length >= 2)
	        {
	            Indicator1 = Indicators[0];
	            Indicator2 = Indicators[1];
	        }
	        else
	        {
	            if (Indicators.Length == 0)
	            {
	                Indicator1 = ' ';
	                Indicator2 = ' ';
	            }
	            if (Indicators.Length == 1)
	            {
	                Indicator1 = Indicators[0];
	                Indicator2 = ' ';
	            }
	        }
	    }

	    #endregion

	    #region Simple properties

	    /// <summary> Gets or sets the data for this MARC XML field which does not exist in any subfield </summary>
	    /// <remarks> This is generally used for the control Fields at the beginning of the MARC record </remarks>
	    public string Control_Field_Value
	    {
	        get
	        {
	            if (String.IsNullOrEmpty(data))
	                return String.Empty;
	            return data;
	        }
	        set
	        {
	            data = value;
	        }
	    }

	    /// <summary> Gets or sets the tag for this data field </summary>
	    public int Tag
	    {
	        get;
	        set;
	    }

	    /// <summary> Gets or sets the first character of the indicator </summary>
	    public char Indicator1
	    {
	        get;
	        set;
	    }

	    /// <summary> Gets or sets the second character of the indicator </summary>
	    public char Indicator2
	    {
	        get;
	        set;
	    }

	    /// <summary> Gets or sets the complete indicator for this data field </summary>
	    public string Indicators
	    {
	        get { return Indicator1.ToString() + Indicator2; }
	        set
	        {
	            if (value.Length >= 2)
	            {
	                Indicator1 = value[0];
	                Indicator2 = value[1];
	            }
	            else
	            {
	                if (value.Length == 0)
	                {
	                    Indicator1 = ' ';
	                    Indicator2 = ' ';
	                }
	                if (value.Length == 1)
	                {
	                    Indicator1 = value[0];
	                    Indicator2 = ' ';
	                }
	            }
	        }
	    }

	    #endregion

	    #region Methods and properties for working with subfields within this field

	    /// <summary> Get the number of subfields in this data field </summary>
	    public int Subfield_Count
	    {
	        get { return subfields.Count; }
	    }

	    /// <summary> Gets the collection of subfields in this data field </summary>
	    public ReadOnlyCollection<MARC_Subfield> Subfields
	    {
	        get { return new ReadOnlyCollection<MARC_Subfield>(subfields); }
	    }

	    /// <summary> Gets the data from a particular subfield in this data field </summary>
	    /// <param name="Subfield_Code"> Code for the subfield in question </param>
	    /// <returns>The value of the subfield, or an empty string </returns>
	    /// <remarks> If there are multiple instances of this subfield, then they are returned 
	    /// together with a '|' delimiter between them </remarks>
	    public string this[char Subfield_Code]
	    {
	        get
	        {
	            string returnValue = String.Empty;
	            foreach (MARC_Subfield subfield in subfields)
	            {
	                if (subfield.Subfield_Code == Subfield_Code)
	                {
	                    if (returnValue.Length == 0)
	                        returnValue = subfield.Data;
	                    else
	                        returnValue = returnValue + "|" + subfield.Data;
	                }
	            }
	            return returnValue;
	        }
	    }

	    /// <summary> Returns flag indicating if this data field has the indicated subfield </summary>
	    /// <param name="Subfield_Code">Code for the subfield in question</param>
	    /// <returns>TRUE if the subfield exists, otherwise FALSE</returns>
	    public bool has_Subfield(char Subfield_Code)
	    {
	        return subfields.Any(subfield => subfield.Subfield_Code == Subfield_Code);
	    }

	    /// <summary> Adds a new subfield code to this MARC field </summary>
	    /// <param name="Subfield_Code"> Code for this subfield in the MARC record field </param>
	    /// <param name="Data"> Data stored for this subfield </param>
	    public void Add_Subfield(char Subfield_Code, string Data)
	    {
	        subfields.Add(new MARC_Subfield(Subfield_Code, Data));
	    }

	    /// <summary> Adds a new subfield code to this MARC field or updates an existing subfield of the same code </summary>
	    /// <param name="Subfield_Code"> Code for this subfield in the MARC record field </param>
	    /// <param name="Data"> Data stored for this subfield </param>
	    /// <remarks> This is used to replace a non-repeatable subfield with new data </remarks>
	    public void Add_NonRepeatable_Subfield( char Subfield_Code, string Data )
	    {
	        // Look through existing subfields
	        foreach (MARC_Subfield subfield in subfields)
	        {
	            if (subfield.Subfield_Code == Subfield_Code)
	            {
	                subfield.Data = Data;
	                return;
	            }
	        }

	        // Add this as a new subfield
	        subfields.Add(new MARC_Subfield(Subfield_Code, Data));
	    }

	    /// <summary> Clears the list of all subfields in this field </summary>
	    public void Clear_Subfields()
	    {
	        subfields.Clear();
	    }

	    /// <summary> Gets the colleciton of subfields by subfield code </summary>
	    /// <param name="Subfield_Code">Code for this subfield in the MARC record field </param>
	    /// <returns> Collection of subfields by subfield code </returns>
	    public ReadOnlyCollection<MARC_Subfield> Subfields_By_Code(char Subfield_Code)
	    {
	        List<MARC_Subfield> returnValue = subfields.Where(subfield => subfield.Subfield_Code == Subfield_Code).ToList();
	        return new ReadOnlyCollection<MARC_Subfield>(returnValue);
	    }

	    /// <summary> Returns this data field as a simple string value </summary>
	    /// <returns> Data field as a string </returns>
	    public override string ToString()
	    {
	        // Build the return value
	        StringBuilder returnValue = new StringBuilder(Tag.ToString() + " " + Indicator1 + Indicator2 + " ");
	        foreach (MARC_Subfield thisSubfield in subfields)
	        {
	            returnValue.Append(thisSubfield + " ");
	        }
	        return returnValue.ToString();
	    }

	    #endregion
	}
}
