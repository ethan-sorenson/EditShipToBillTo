page 50115 "Address Web Service"
{
    PageType = API;
    Caption = 'Address Web Service';
    APIPublisher = 'EthanSorenson';
    APIGroup = 'app1';
    APIVersion = 'v1.0';
    EntityName = 'AddressWebService';
    EntitySetName = 'AddressWebService';
    SourceTable = "Sales Header";
    DelayedInsert = true;
    ODataKeyFields = SystemId;

    layout
    {
        area(Content)
        {
            group(Settings)
            {
                field(No; Rec."No.")
                {
                    ApplicationArea = All;
                    Caption = 'No';
                }
                field(SystemId; Rec."SystemId")
                {
                    ApplicationArea = All;
                    Caption = 'SystemId';
                }
                field("ExternalDocumentNo"; Rec."External Document No.")
                {
                    ApplicationArea = All;
                    Caption = 'External Document No.';
                }
                field(YourReference; Rec."Your Reference")
                {
                    ApplicationArea = All;
                    Caption = 'Your Reference';

                }
                field(ShipToOptions; ShipToOptions)
                {
                    ApplicationArea = All;
                    Caption = 'ShipToOptions';
                    trigger OnValidate();
                    begin
                        case ShipToOptions of
                            'Default':
                                Rec.CopySellToAddressToShipToAddress;
                            'Alternate':
                                begin
                                end;
                            'Custom':
                                Rec.VALIDATE("Ship-to Code", '');
                            else
                                Error('Error: ShipToOptions - The available options are Default, Alternate, or Custom');
                        END;
                    End;

                }
                field(ShipToCode; Rec."Ship-to Code")
                {
                    ApplicationArea = All;
                    Caption = 'Ship-to Code';

                }
                field(ShipToName; Rec."Ship-to Name")
                {
                    ApplicationArea = All;
                    Caption = 'Ship-to Name';

                }
                field(ShipToAddress; Rec."Ship-to Address")
                {
                    ApplicationArea = All;
                    Caption = 'Ship-to Address';

                }
                field(ShipToAddress2; Rec."Ship-to Address 2")
                {
                    ApplicationArea = All;
                    Caption = 'Ship-to Address 2';

                }
                field(ShipToCity; Rec."Ship-to City")
                {
                    ApplicationArea = All;
                    Caption = 'Ship-to City';

                }
                field(ShipToCounty; Rec."Ship-to County")
                {
                    ApplicationArea = All;
                    Caption = 'Ship-to County';

                }
                field(ShipToPostCode; Rec."Ship-to Post Code")
                {
                    ApplicationArea = All;
                    Caption = 'Ship-to Post Code';

                }
                field(ShipToCountryRegionCode; Rec."Ship-to Country/Region Code")
                {
                    ApplicationArea = All;
                    Caption = 'Ship-to Country/Region Code';

                }
                field(ShipToContact; Rec."Ship-to Contact")
                {
                    ApplicationArea = All;
                    Caption = 'Ship-to Contact';

                }
                field(BillToOptions; BillToOptions)
                {
                    ApplicationArea = All;
                    Caption = 'BillToOptions';
                    trigger OnValidate();
                    begin
                        if BillToOptions = 'Customer' then
                            Rec.CopySellToAddressToBillToAddress;
                    END;
                }
                field(BillToName; Rec."Bill-to Name")
                {
                    ApplicationArea = All;
                    Caption = 'Bill-to Name';
                    trigger OnValidate();
                    Begin
                        IF Rec.GETFILTER("Bill-to Customer No.") = xRec."Bill-to Customer No." THEN
                            IF Rec."Bill-to Customer No." <> xRec."Bill-to Customer No." THEN
                                Rec.SETRANGE("Bill-to Customer No.");

                        IF ApplicationAreaMgmtFacade.IsFoundationEnabled THEN
                            SalesCalcDiscountByType.ApplyDefaultInvoiceDiscount(0, Rec);

                        CurrPage.UPDATE;
                    End;

                }
                field(BillToAddress; Rec."Bill-to Address")
                {
                    ApplicationArea = All;
                    Caption = 'Bill-to Address';

                }
                field(BillToAddress2; Rec."Bill-to Address 2")
                {
                    ApplicationArea = All;
                    Caption = 'Bill-to Address 2';

                }
                field(BillToCity; Rec."Bill-to City")
                {
                    ApplicationArea = All;
                    Caption = 'Bill-to City';

                }
                field(BillToCounty; Rec."Bill-to County")
                {
                    ApplicationArea = All;
                    Caption = 'Bill-to County';

                }
                field(BillToPostCode; Rec."Bill-to Post Code")
                {
                    ApplicationArea = All;
                    Caption = 'Bill-to Post Code';

                }
                field(BillToCountryRegionCode; Rec."Bill-to Country/Region Code")
                {
                    ApplicationArea = All;
                    Caption = 'Bill-to Country/Region Code';

                }
                field(BillToContactNo; Rec."Bill-to Contact No.")
                {
                    ApplicationArea = All;
                    Caption = 'Bill-to Contact No.';

                }
                field(BillToContact; Rec."Bill-to Contact")
                {
                    ApplicationArea = All;
                    Caption = 'Bill-to Contact';

                }
            }
        }
    }

    var
        ShipToOptions: Text;
        BillToOptions: Text;
        ApplicationAreaMgmtFacade: codeunit "Application Area Mgmt. Facade";
        SalesCalcDiscountByType: codeunit "Sales - Calc Discount By Type";
}