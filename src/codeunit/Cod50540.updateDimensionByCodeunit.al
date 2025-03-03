codeunit 50540 updateDimensionByCodeunit
{
    [EventSubscriber(ObjectType::Table, Database::"Default Dimension", 'OnAfterInsertEvent', '', false, false)]
    local procedure forFirstTimeDimesionInsertion(var Rec: Record "Default Dimension")
    begin
        updateFieldInEmployee(Rec);
    end;

    [EventSubscriber(ObjectType::Table, Database::"Default Dimension", 'OnAfterModifyEvent', '', false, false)]
    local procedure forModification(var Rec: Record "Default Dimension")
    begin
        updateFieldInEmployee(Rec);
    end;

    local procedure updateFieldInEmployee(var Rec: Record "Default Dimension")
    var
        employeeRecord: Record Employee;
    begin
        if Rec."Table ID" <> Database::Employee then
            exit;

        if employeeRecord.Get(Rec."No.") then begin
            if Rec."Dimension Code" = 'DEPARTMENT' then begin
                employeeRecord.dimension_value := Rec."Dimension Value Code";
                employeeRecord.Modify();
                Message('Dimension Updated to: %1', Rec."Dimension Value Code");
            end;
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Default Dimension", OnAfterDeleteEvent, '', false, false)]
    local procedure deleteFieldOfEmployee(var Rec: Record "Default Dimension")
    var
        employeerecord: Record Employee;
    begin
        if (employeerecord.Get(Rec."No.")) then begin
            employeerecord.dimension_value := '';
            Message('Dimension Field removed in Employee Page.🥶');
            employeerecord.Modify();
        end;
    end;
}