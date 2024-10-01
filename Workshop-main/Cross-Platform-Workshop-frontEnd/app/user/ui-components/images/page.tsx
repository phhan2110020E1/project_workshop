'use client';
import ApiService from "@/app/services/ApiService";
import { Grid, Typography, TextField, Button, Card, CardContent, Box } from "@mui/material"; import { useSession } from 'next-auth/react';
import React, { useEffect, useState } from "react";
import styles from './deposit.module.css';
import { toast, ToastContainer } from 'react-toastify';
import 'react-toastify/dist/ReactToastify.css';
import { PayPalScriptProvider } from "@paypal/react-paypal-js";
import PayPalCheckOutButton from "./components/PaypalButton";

const WithdrawPage = () => {
  const [amount, setAmount] = useState(0);
  const [withdrawalInfo, setWithdrawalInfo] = useState({
    amount: 0,
    type: 'CASH',
    paymentName: 'CASH',
  });
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

  const { data: session } = useSession();
  const apiService = new ApiService(session);
  const handleWithdraw = async () => {
    try {
      // Kiểm tra nếu số tiền hợp lệ (ví dụ: lớn hơn 0)
      if (withdrawalInfo.amount > 0) {
        // const user = /* Lấy thông tin người dùng (nếu cần) */;
        const result = await apiService.withdraw(withdrawalInfo.amount, withdrawalInfo.type, withdrawalInfo.paymentName);
        console.log('result né', result);

        if (result.status === 'Success') {
          console.log('Rút tiền thành công!');
          const updatedUserData = await apiService.getUserDetails();
          if (updatedUserData && updatedUserData.data) {
            setUserData(updatedUserData.data);
            console.log('User data updated successfully:', updatedUserData.data);
            toast.success('Withdrawal request successful!');
          }
        } else {
          console.log('Yeu cau rut tien thanh cong');
          // Thực hiện các hành động cần thiết khi rút tiền thất bại
          toast.error('Withdrawal request failed. Please try again.');
        }
      } else {
        console.log('Yeu cau rut tien khong thanh cong');
        // Thực hiện xử lý khi số tiền không hợp lệ
        toast.error('Withdrawal request failed. Please try again.');

      }
    } catch (error) {
      // Xử lý lỗi nếu cần
      console.error('Lỗi khi thực hiện yêu cầu rút tiền:', error);
      toast.error('An error occurred. Please try again.');
    }
  };


  useEffect(() => {
    const fetchUserData = async () => {
      try {
        if (session) {
          const data = await apiService.getUserDetails();
          if (data && data.data) {
            setUserData(data.data);
            console.log('User data fetched successfully:', data.data);
          }
        }
      } catch (error) {
        console.error('Error fetching user data:', error);
      }
    };

    fetchUserData();
  }, [session]);
  console.log(userData);
  const handlePay = () => {
    toast.success('Payment successful!');
    // Xử lý sau khi thanh toán thành công (nếu cần)
    console.log('Payment successful!');
  };
  return (

    <PayPalScriptProvider
      options={
        {
          clientId: process.env.NEXT_PUBLIC_PAYPAL_CLIENT_ID!,
          currency: "USD"
        }}>
      <Grid container spacing={0} className={styles.container}>
        <ToastContainer />

        <Card className={styles.pricingItemRegular}>
          <CardContent>
            <Typography variant="h2">Withdraw Money</Typography>
            <div className={styles.marginTop2}>
              <Typography variant="h4">Current Balance: {userData.balance}</Typography>
            </div>
            <div className={styles.marginTop2}>
              <TextField
                type="number"
                label="Enter the amount."
                value={withdrawalInfo.amount}
                onChange={(e) => setWithdrawalInfo({ ...withdrawalInfo, amount: parseInt(e.target.value, 10) || 0 })}
              />
            </div>
            <div className={styles.marginTop4} style={{ display: 'flex', justifyContent: 'center' }}>
              <PayPalCheckOutButton amount={withdrawalInfo.amount} onPay={handlePay} />
            </div>
          </CardContent>
        </Card>
      </Grid>
    </PayPalScriptProvider>
  );
};
export default WithdrawPage;