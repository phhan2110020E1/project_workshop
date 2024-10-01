import paypal from '@paypal/checkout-server-sdk'
import { NextResponse } from 'next/server'

const clientId = "AceLbmTlRy4eqddeg7HxdU72gHdzoW3THUZsDTNzpFJbebiAoX9S1uoxOS5YiEw48BObSef22b8_LNbq"
const clientSecret = "EBa3F1ePdvUPih1rpuWCpk87Kwp4VbDMCxyZPLuRW7oyRxesn_KXQHfElmbGe_tsWRTwBssMrTc2fYYH"
const environment = new paypal.core.SandboxEnvironment(clientId, clientSecret)
const client = new paypal.core.PayPalHttpClient(environment)
// const dynamicData = req.body;
//     console.log("dynamicData,",dynamicData);

export async function POST() {
    const request = new paypal.orders.OrdersCreateRequest()
    
    request.requestBody({
        intent: 'CAPTURE',
        purchase_units: [
            {
                amount: {
                    currency_code: 'USD',
                    value: '100.00',
                    breakdown: {
                        item_total: {
                            currency_code: 'USD',
                            value: '100.00',
                        }
                    }
                },
                description: "Demo san pham ",
                items: [
                    {
                        name: "Demo san pham  1",
                        description: "Demo san pham  1",
                        quantity: "1",
                        unit_amount: {
                            currency_code: 'USD',
                            value: '50.00'
                        }
                    },
                    {
                        name: "Demo san pham  2",
                        description: "Demo san pham  2",
                        quantity: "1",
                        unit_amount: {
                            currency_code: 'USD',
                            value: '50.00'
                        }
                    },
                ]
            }
        ]
    })
    const response = await client.execute(request)
    console.log("response.status",response)

    return NextResponse.json({
        id: response.result.id,
        result:response.result.status
    })
}