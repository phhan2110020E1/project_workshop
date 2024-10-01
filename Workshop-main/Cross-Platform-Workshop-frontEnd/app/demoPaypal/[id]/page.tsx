'use client'
import React, { useEffect, useState } from "react";
import { Container, Form, Button, Row, Col, ButtonToolbar } from "react-bootstrap";
import PayPalCheckOutButton from "./component/PaypalButton";
import { PayPalScriptProvider } from "@paypal/react-paypal-js"
import { useSession } from "next-auth/react";
import { useRouter } from 'next/navigation';
import ApiService from "@/app/services/ApiService";
import stylecss from '../payment.module.css';
import Image from 'next/image';

interface CourseDetail {
    id: number;
    name: string;
    description: string;
    link: string;
    price: number;
}
const PayMent = ({ params }: { params: { id: any } }) => {
    const id = params;
    console.log("id", id);
    const router = useRouter();
    const { data: session } = useSession();
    const apiService = new ApiService(session);
    const email = session?.user.email;
    const [course, setCourse] = useState<CourseDetail | undefined>(undefined);
    const [paymentMethod, setPaymentMethod] = useState("#");
    const [isCouponApplied, setIsCouponApplied] = useState(false);
    const [couponDiscount, setCouponDiscount] = useState<number>(0);
    const [isPaymentProcessing, setPaymentProcessing] = useState(false);

    const [userData, setUserData] = useState({
        full_name: '',
        user_name: '',
        email: '',
        phoneNumber: '',
        image_url: '',
        balance: 0,
        userAddresses: [
            {
                id: 0,
                state: '',
                city: '',
                address: '',
                postalCode: 0,
            },
        ],
    });
    const [couponCode, setCouponCode] = useState('');

    const applyCoupon = async () => {
        try {
            console.log("applyCoupon function is called");

            // Call the checkUserDiscount function to validate the coupon
            const couponValidationResponse = await apiService.checkUserDiscount(couponCode);
            console.log('couponValidationResponse neenen', couponValidationResponse);

            if (couponValidationResponse.status === "Success") {
                // Add your coupon discount logic here
                const discountAmount = couponValidationResponse.data || 0; // Use the discount amount from the response
                console.log('discountAmount nè', discountAmount);

                // Update the course price with the discount
                setCourse((prevCourse) => {
                    if (!prevCourse) return prevCourse; // If prevCourse is undefined, return it as is
                    return {
                        ...prevCourse,
                        price: prevCourse.price - discountAmount,
                    };
                });
                setCouponDiscount(discountAmount);

                setIsCouponApplied(true);
            } else {
                console.log("Coupon is not valid for the user or course.");
                setIsCouponApplied(false);
            }
        } catch (error: any) {
            console.error("Error validating coupon:", error);

            // Check if the error is a 404 status
            if (error.response && error.response.status === 404) {
                console.log("Coupon not found (404 error).");
                // Handle the 404 error specific to your use case
                // ...
                setIsCouponApplied(false);

            } else {
                // Handle other errors
                // ...
            }
        }
    };

    useEffect(() => {
        if (session) {
            apiService.getUserDetails().then((data) => {
                if (data && data.data) {
                    setUserData(data.data);
                }
            }).catch((error) => {
                console.error('Error fetching user data:', error);
            });
        }
        const fetchData = async () => {
            if (id !== undefined) {
                try {
                    const respone = await apiService.CoursePublicDetail(params.id);
                    if (respone.data)
                        console.log("course in payment", respone.data);
                    {
                        setCourse(respone.data);

                    }

                } catch (error) {
                    console.error("Error checking user in course:", error);
                }

            }
        }
        fetchData();
    }, [session]);


    const handlePayNow = async () => {
        if (paymentMethod === "wallet") {
            if (isPaymentProcessing) {
                return; // Prevent multiple clicks while processing
            }

            setPaymentProcessing(true);

            try {
                const data = {
                    type: "string",
                    status: "Amount",
                    item_register_id: course!.id,
                    locationId: 0,
                    amount: course!.price,
                    discountAmount: 0,
                    discountCode: "string",
                    paymentName: "Amount",
                    paymentStatus: "string",

                };
                const buyCourseResponse = await apiService.buyCourseWithStudent(data);
                console.log(buyCourseResponse)
                if (buyCourseResponse.status === "Success") {
                    router.back();
                    router.refresh();
                } else {
                    router.refresh();
                }

            } catch (error) {
                console.error("Error buying course with student:", error);
            } finally {
                setPaymentProcessing(false);
            }
            console.log("Paying with wallet");
        } else if (paymentMethod === "paypal") {
            // Logic for PayPal payment
            console.log("Paying with PayPal");
            // You can pass product information to the PayPal component here
        }
    };
    const styles = {
        disabled: {
            pointerEvents: 'none',
            backgroundColor: '#CCCCCC',
            // Màu tối khi vô hiệu hóa
        },
        enabled: {
            pointerEvents: 'auto',
            backgroundColor: '#FFFFFF', // Màu sáng khi có thể tương tác
        },
        enabledHover: {
            backgroundColor: '#efefef', // Màu khi di chuột qua trong trạng thái enabled
        },
    };
    const remainingBalance = userData?.balance - course?.price;
    console.log("remainingBalance", remainingBalance);

    const handleGoBack = () => {
        router.back();
    };
    console.log(isCouponApplied);
    const [isPayPalSelected, setIsPayPalSelected] = useState(false);
    const handlePaymentChange = (e: { target: { value: React.SetStateAction<string>; }; }) => {
        setPaymentMethod(e.target.value);
        setIsPayPalSelected(e.target.value === "paypal");
    };

    return (
        <PayPalScriptProvider
            options={
                {
                    clientId: process.env.NEXT_PUBLIC_PAYPAL_CLIENT_ID!,
                    currency: "USD"
                }}>
            <Button variant="outline-primary" onClick={handleGoBack}>
                Back
            </Button>
            <Container>
                <Row>
                    <Col sm={6}>
                        <div className={stylecss.pricingItemPro}>
                            <Container>
                                <h1></h1>
                                <h2>Payment Details</h2>
                                <p>Product Description: {course?.description}</p>
                                <img
                                    alt="Video Thumbnail"
                                    className="object-cover"
                                    height="100px" // Đặt chiều cao thành 100px
                                    src={course?.courseMediaInfos[0].thumbnailSrc}
                                />
                                <div className={stylecss.priceDetails}>
                                    <Row>
                                        <Col>
                                            <h5 className={stylecss.label}>price:</h5>
                                        </Col>
                                        <Col className={stylecss.valueCol}>
                                            <h5 className={stylecss.value}>${course?.price}</h5>
                                        </Col>
                                    </Row>
                                    {/* ... (other code) */}
                                    <Row>
                                        <Col>
                                            <h5 className={stylecss.label}>Coupon Discount:</h5>
                                        </Col>
                                        <Col className={stylecss.valueCol}>
                                            <h5 className={stylecss.value}>-${couponDiscount}</h5>
                                        </Col>
                                    </Row>
                                    {/* ... (other code) */}
                                    <Row>
                                        <Col>
                                            <h5 className={stylecss.label}>Total:</h5>
                                        </Col>
                                        <Col className={stylecss.valueCol}>
                                            <h5 className={stylecss.value}>${course?.price - couponDiscount}</h5>
                                        </Col>
                                    </Row>
                                    {/* ... (other code) */}
                                </div>
                                <Form.Group controlId="couponCode">
                                    <Form.Label>Coupon Code:</Form.Label>
                                    <Form.Control
                                        type="text"
                                        placeholder="Enter coupon code"
                                        value={couponCode}
                                        onChange={(e) => setCouponCode(e.target.value)}
                                    />
                                </Form.Group>

                                <Button className={stylecss.gradientbutton} variant="secondary" onClick={applyCoupon}>
                                    Apply Coupon
                                </Button>
                                {isCouponApplied && (
                                    <div>
                                        <p>Coupon Applied!</p>
                                        {/* Display additional coupon information here */}
                                    </div>
                                )}
                                {!isCouponApplied && (
                                    <div>
                                        <p>Coupon Not Found!</p>
                                        {/* Display additional coupon information here */}
                                    </div>
                                )}
                            </Container>
                        </div>

                    </Col>

                    <Col sm={6}>
                        <div className={stylecss.pricingItemRegular}>

                            <Container>
                                <Form>
                                    <Form.Group controlId="paymentMethod">
                                        <h4>
                                            <em className={stylecss.emm}>Select Payment Method</em>
                                        </h4>
                                        <Image src="/../../heading-line-dec.png" alt="" width={45} height={2} />
                                        <Form.Control
                                            as="select"
                                            value={paymentMethod}
                                            onChange={handlePaymentChange}
                                            style={{ marginBottom: '5%' }}
                                        >
                                            <option value="#">Choses</option>
                                            <option value="wallet">Wallet</option>
                                            <option value="paypal">PayPal</option>
                                        </Form.Control>
                                    </Form.Group>
                                </Form>
                                {paymentMethod === "wallet" && (
                                    <div style={{ display: "flex", justifyContent: "space-between", marginTop: "20px" }}>
                                        <div style={{ textAlign: "left" }}>
                                            <h5>Wallet Balance: ${userData?.balance}</h5>
                                        </div>
                                        <div style={{ textAlign: "right" }}>
                                            <h5>Remaining Balance: ${remainingBalance}</h5>
                                        </div>
                                    </div>
                                )}

                                {paymentMethod === "wallet" && !isPayPalSelected && (
                                    <Button className={stylecss.gradientbutton} variant="primary" onClick={handlePayNow}
                                        disabled={isPaymentProcessing}
                                    >
                                        {isPaymentProcessing ? "Processing..." : "Pay Now"}
                                    </Button>
                                )}

                                {paymentMethod === "paypal" && (
                                    <PayPalCheckOutButton Courses={course} />
                                )}

                                <div style={remainingBalance < 5 ? styles.disabled : styles.enabled}
                                    onClick={handlePayNow}
                                    onMouseOver={remainingBalance >= 5 ? () => styles.enabledHover : null}
                                    onMouseOut={remainingBalance >= 5 ? () => styles.enabled : null}
                                >
                                    {/* {paymentMethod === "wallet" && (
                                        <div>
                                            <p>Wallet Balance: ${userData?.balance}</p>
                                            <p>Remaining Balance: ${remainingBalance}</p>
                                        </div>
                                    )} */}
                                </div>

                            </Container>
                        </div>

                    </Col>
                </Row>
            </Container>


        </PayPalScriptProvider>
    );
}
export default PayMent;