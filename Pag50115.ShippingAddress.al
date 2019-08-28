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
    ODataKeyFields = ID;

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
                        CASE ShipToOptions OF
                            ShipToOptions::"Default (Sell-to Address)":
                                BEGIN
                                    CopySellToAddressToShipToAddress;
                                END;
                            ShipToOptions::"Alternate Shipping Address":
                                BEGIN
                                END;
                            ShipToOptions::"Custom Address":
                                BEGIN
                                    VALIDATE("Ship-to Code", '');
                                END;
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
                        CASE BillToOptions OF
                            BillToOptions::"Default (Customer)":
                                BEGIN
                                    CopySellToAddressToBillToAddress;
                                END;
                        END;
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
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Insert(true);
        Modify(true);
        exit(false);
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        Delete(true)
    end;

    var
        ShipToOptions: Option "Default (Sell-to Address)","Alternate Shipping Address","Custom Address";
        BillToOptions: Option "Default (Customer)","Another Customer","Custom Address";
        ApplicationAreaMgmtFacade: codeunit "Application Area Mgmt. Facade";
        SalesCalcDiscountByType: codeunit "Sales - Calc Discount By Type";
        Orders: Page 42;
}
