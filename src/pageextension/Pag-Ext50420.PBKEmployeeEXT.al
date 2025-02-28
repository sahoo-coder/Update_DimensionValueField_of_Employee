pageextension 50420 PBKEmployeeEXT extends "Employee Card"
{
    layout
    {
        // Add changes to page layout here
        addafter(Initials)
        {
            field(dimension_value; Rec.dimension_value)
            {
                Caption = 'Dimension Value';
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
        addafter("E&mployee")
        {
            group("Dimension Function")
            {
                action("getDimension")
                {
                    Caption = 'Update Dimesion BY FUNCTION';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        updateDimension();
                        Message('Dimension Value Updated By FUNCTION BUILD BY KIRTI');
                    end;
                }
            }
        }
    }

    procedure updateDimension()
    var
        dimesionEntry: Record "Default Dimension";
    begin
        dimesionEntry.SetRange("Table ID", Database::Employee);
        dimesionEntry.SetRange("No.", Rec."No.");
        dimesionEntry.SetRange("Dimension Code", 'DEPARTMENT');

        if (dimesionEntry.FindFirst()) then
            Rec.dimension_value := dimesionEntry."Dimension Value Code"
        else
            Rec.dimension_value := '';
        Rec.Modify();
        CurrPage.Update();
    end;

    var
        myInt: Integer;
}