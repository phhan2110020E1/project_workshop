import React, { useState, useEffect } from "react";
import { useRouter } from 'next/navigation';
import ApiService from "@/app/services/ApiService";
import { useSession } from 'next-auth/react';
import { PayPalButtons } from "@paypal/react-paypal-js";
import { toast } from 'react-toastify';
import 'react-toastify/dist/ReactToastify.css';

interface PayPalCheckOutButtonProps {
    amount: number;
    onPay: () => void;
}


const PayPalCheckOutButton: React.FC<PayPalCheckOutButtonProps> = ({ amount, onPay }) => {
    const router = useRouter();
    const { data: session } = useSession();
    const apiService = new ApiService(session);
    const [error, setError] = useState(null);
    const [paidFor, setPaidFor] = useState(false);

    const createPaypalOrder = () => {
        console.log('orderAmount before creating order:', amount);
        return {
            purchase_units: [
                {
                    description: "Request Deposit",
                    amount: {
                        value: amount.toString(),
                    },
                },
            ],
        };
    };

    async function handleApprove(orderID: string, order: any) {
        if (order.status === "COMPLETED") {
            try {
                const data = {
                    type: "DEPOSIT",
                    status: "payment_gateway",
                    item_register_id: 0,
                    locationId: 0,
                    amount: amount,
                    discountAmount: 0,
                    discountCode: "string",
                    paymentName: "PayPal",
                    paymentStatus: "success",
                };

                console.log("Data to be sent to apiService.Deposit:", data);
                const deposit = await apiService.Deposit(data);
                console.log("Deposit response:", deposit);

                if (deposit.status === "Success") {
                    toast.success('Deposit successful!');
                    router.refresh();
                } else {
                    toast.error('Deposit failed. Please try again.');
                    router.refresh();
                }
            } catch (error) {
                console.error("Error buying course with student:", error);
            }
        }
    }

    return (
        <div>
            <PayPalButtons
                forceReRender={[amount]}
                style={{
                    color: "silver",
                    layout: "horizontal",
                    height: 48,
                    tagline: false,
                    shape: "pill",
                }}
                onClick={(data, actions) => {
                    console.log("Before createOrder, orderAmount:", amount);
                    return actions.resolve();
                }}
                createOrder={(data, actions) => {
                    const order = createPaypalOrder();
                    console.log("Inside createOrder, orderAmount:", amount);
                    const orderForPayPal = actions.order.create(order);
                    return orderForPayPal;
                }}
                onApprove={async (data, actions) => {
                    const order = await actions.order?.capture();
                    handleApprove(data.orderID, order);
                    setPaidFor(true);
                    onPay();
                }}
                onError={(err) => {
                    setError(err);
                    console.error("PayPal SDK Error:", err);
                    toast.error('An error occurred with PayPal. Please try again.');
                }}
                onCancel={(data) => {
                    console.log("Cancelled", data);
                    toast.warn('Payment cancelled.');
                }}
            />
        </div>
    );
};

export default PayPalCheckOutButton;
