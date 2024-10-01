import React, { useState } from "react";
import { PayPalButtons } from "@paypal/react-paypal-js";
import { useRouter } from 'next/navigation';
import ApiService from "@/app/services/ApiService";
import { useSession } from 'next-auth/react';
interface CourseDetail {
    id: number;
    name: string;
    description: string;
    link: string;
    price: number;
  }
const PayPalCheckOutButton = ({ Courses }: { Courses: CourseDetail }) => {
    const courses = Courses;
    const [paidFor, setPaidFor] = useState(false);
    const [error, setError] = useState("");
    const router = useRouter();
    const { data: session } = useSession();
    const apiService = new ApiService(session);
    
    async function handleApprove(orderID: string,order: any): Promise<void> {
        setPaidFor(true);
        console.log("order.status",order.status);
        if(order.status ==="COMPLETED")
        {
            try {
                const data = {
                    type: "string",
                    status: "payment_gateway",
                    item_register_id: Courses.id,
                    locationId: 0,
                    amount: Courses.price,
                    discountAmount: 0,
                    discountCode: "string",
                    paymentName: "PayPal",
                    paymentStatus: "success",
                          
                };
                const buyCourseResponse = await apiService.buyCourseWithStudent(data);
                console.log(buyCourseResponse)
             if(buyCourseResponse.status === "Success"){
                router.back();
                router.refresh();
             }else{
                router.refresh();
             }
                  
            } catch (error) {
                console.error("Error buying course with student:", error);
            }
        }
    }
    if (paidFor) {
    }
    if (error) {
    }
    return (
        <PayPalButtons
            style={{
                color: "silver",
                layout: "horizontal",
                height: 48,
                tagline: false,
                shape: "pill",
            }}
            onClick={(data,actions)=>{
                const hasAlredyBoughCourse = false;
                if(hasAlredyBoughCourse){
                    setError('you already bought this product. Go to you account to View');
                    return actions.reject();
                }else{
                    return actions.resolve();
                }
               
            }}
            createOrder={(data, actions) => {
                return actions.order.create({
                    purchase_units: [
                        {
                            description: courses.description,
                            amount: {
                                value: courses.price.toString()
                            }
                        }
                    ]
                });
            }}
            onApprove={async (data, actions) => {
                const order = await actions.order?.capture();
                handleApprove(data.orderID,order);
            }}
            onError={(err) => {
                setError(err);
                console.log(err);
            }}
            onCancel={(data) => {
                console.log("Cancelled", data);
            }}
        />
    );
};

export default PayPalCheckOutButton;
