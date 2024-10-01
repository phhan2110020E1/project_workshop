'use client';
import ApiService from "@/app/services/ApiService";
import { Grid, Typography, TextField, Button, Card, CardContent, Box } from "@mui/material"; import { useSession } from 'next-auth/react';
import React, { useEffect, useState } from "react";
import styles from './withdraw.module.css';
import { toast, ToastContainer } from 'react-toastify';
import 'react-toastify/dist/ReactToastify.css';

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
  const [withdrawalStatus, setWithdrawalStatus] = useState('');
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
            // Check if the balance has decreased
            if (updatedUserData.data.balance !== userData.balance) {
              setWithdrawalStatus(''); // Reset withdrawal status if the balance has changed
            } else {
              setWithdrawalStatus('Pending...');
            }
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

  return (
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
          {withdrawalStatus && (
            <div className={styles.marginTop2}>
              <Typography variant="body1">Status: {withdrawalStatus}</Typography>
            </div>
          )}
          {withdrawalStatus !== 'Pending...' && (
            <div className={styles.marginTop4}>
              <Button className={styles.gradientbutton} onClick={handleWithdraw}>
                Confirm withdrawal
              </Button>
            </div>
          )}
        </CardContent>
      </Card>
    </Grid>
  );
};
export default WithdrawPage;