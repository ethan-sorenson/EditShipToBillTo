## EditShipToBillTo
Failed to create record.: Property “Editable” for Ship-to Address is invalid!

This service will help workaround the limitation in the Business Central web services that prevents using custom addresses for the bill-to and ship-to on Sales Transactions.

### The Issue
When you change the address in Business Central, you first need to switch the flag “ShipToOptions”, but this field is not available through the web services. If you try to change one of the other Ship-to fields before changing the flag, you will receive the above error. The standard Business Central web services are unable to bypass this error, therefore you will need to create an Extension.

![increment](https://i.imgur.com/1o7TBTy.gif)

### Getting Started
1. If you aren't familar with building AL extensions you can use the Microsoft [documentation](https://docs.microsoft.com/en-us/dynamics365/business-central/dev-itpro/developer/devenv-dev-overview "documentation") to get started.
2. The [Pag50115.ShippingAddress.al](Pag50115.ShippingAddress.al) file can be modified as needed to use additional logic.
3. After publishing the page you will still want to use the standard Sales Transaction pages to create the Orders/Invoices/Credit Memos before using this page to modify the addresses.

PATCH /ODataV4/Company('Sample')/ShippingAddress({id})
A Sample Request body can be viewed in the [SampleRequest.json](SampleRequest.json) file.

### Troubleshooting
**Web Service isn't available after publishing**
* Make sure the service is published as outlined [here](https://docs.microsoft.com/en-us/dynamics365/business-central/across-how-publish-web-service "documentation").
* Make sure the service is named as expected ex. /ODataV4/Company('Sample')/ShippingAddress

**Something else isn't working properly**
* Use github's issue reporter on the right
* Send me an email ethan.sorenson@eonesolutions.com (might take a few days)

### Updates
* 1.0.0.5 first release on BC v14
* 1.0.0.6 updated for BC v16, removed duplicate insert triggers
* 1.0.0.7 updated runtime to 7, switched to AL Permission Sets, and added External Document No
* 1.0.0.8 Added Your Reference

Enjoy!
