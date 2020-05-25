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
                field(No; "No.")
                {
                    ApplicationArea = All;
                    Caption = 'No';

                }
                field(ShipToOptions; ShipToOptions)
                {
                    ApplicationArea = All;
                    Caption = 'ShipToOptions';
                    trigger OnValidate();
                    begin
                        case ShipToOptions of
                            'Default':
                                CopySellToAddressToShipToAddress;
                            'Alternate':
                                begin
                                end;
                            'Custom':
                                VALIDATE("Ship-to Code", '');
                            else
                                Error('Error: ShipToOptions - The available options are Default, Alternate, or Custom');
                        END;
                    End;

                }
                field(ShipToCode; "Ship-to Code")
                {
                    ApplicationArea = All;
                    Caption = 'Ship-to Code';

                }
                field(ShipToName; "Ship-to Name")
                {
                    ApplicationArea = All;
                    Caption = 'Ship-to Name';

                }
                field(ShipToAddress; "Ship-to Address")
                {
                    ApplicationArea = All;
                    Caption = 'Ship-to Address';

                }
                field(ShipToAddress2; "Ship-to Address 2")
                {
                    ApplicationArea = All;
                    Caption = 'Ship-to Address 2';

                }
                field(ShipToCity; "Ship-to City")
                {
                    ApplicationArea = All;
                    Caption = 'Ship-to City';

                }
                field(ShipToCounty; "Ship-to County")
                {
                    ApplicationArea = All;
                    Caption = 'Ship-to County';

                }
                field(ShipToPostCode; "Ship-to Post Code")
                {
                    ApplicationArea = All;
                    Caption = 'Ship-to Post Code';

                }
                field(ShipToCountryRegionCode; "Ship-to Country/Region Code")
                {
                    ApplicationArea = All;
                    Caption = 'Ship-to Country/Region Code';

                }
                field(ShipToContact; "Ship-to Contact")
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
                            CopySellToAddressToBillToAddress;
                    END;
                }
                field(BillToName; "Bill-to Name")
                {
                    ApplicationArea = All;
                    Caption = 'Bill-to Name';
                    trigger OnValidate();
                    Begin
                        IF GETFILTER("Bill-to Customer No.") = xRec."Bill-to Customer No." THEN
                            IF "Bill-to Customer No." <> xRec."Bill-to Customer No." THEN
                                SETRANGE("Bill-to Customer No.");

                        IF ApplicationAreaMgmtFacade.IsFoundationEnabled THEN
                            SalesCalcDiscountByType.ApplyDefaultInvoiceDiscount(0, Rec);

                        CurrPage.UPDATE;
                    End;

                }
                field(BillToAddress; "Bill-to Address")
                {
                    ApplicationArea = All;
                    Caption = 'Bill-to Address';

                }
                field(BillToAddress2; "Bill-to Address 2")
                {
                    ApplicationArea = All;
                    Caption = 'Bill-to Address 2';

                }
                field(BillToCity; "Bill-to City")
                {
                    ApplicationArea = All;
                    Caption = 'Bill-to City';

                }
                field(BillToCounty; "Bill-to County")
                {
                    ApplicationArea = All;
                    Caption = 'Bill-to County';

                }
                field(BillToPostCode; "Bill-to Post Code")
                {
                    ApplicationArea = All;
                    Caption = 'Bill-to Post Code';

                }
                field(BillToCountryRegionCode; "Bill-to Country/Region Code")
                {
                    ApplicationArea = All;
                    Caption = 'Bill-to Country/Region Code';

                }
                field(BillToContactNo; "Bill-to Contact No.")
                {
                    ApplicationArea = All;
                    Caption = 'Bill-to Contact No.';

                }
                field(BillToContact; "Bill-to Contact")
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
        Orders: Page 42;
        attachments: page 2121;
}
