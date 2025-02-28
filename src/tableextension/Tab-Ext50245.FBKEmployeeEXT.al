tableextension 50245 "FBK_EmployeeEXT" extends Employee
{
    fields
    {
        // Add changes to table fields here
        field(50286; dimension_value; Code[30])
        {
            Caption = 'Dimension Value';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        // Add changes to keys here
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        myInt: Integer;
}