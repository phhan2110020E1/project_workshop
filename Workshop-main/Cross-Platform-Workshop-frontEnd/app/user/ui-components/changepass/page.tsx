'use client'
import React, { useState, ChangeEvent, useEffect } from "react"
import { Grid, TextField, Button} from '@mui/material';
import styles from '../forms/form.module.css';
import { Dialog, DialogTitle, DialogContent, DialogActions } from '@mui/material';
import{ createTheme, ThemeProvider }from "@mui/material/styles";
import ApiService from '@/app/services/ApiService';
import { useSession } from 'next-auth/react';
const lightTheme = createTheme({ palette: { mode: 'light' } });

const ChangePassword = () => {
  const [oldPassword, setOldPassword] = useState('');
  const [newPassword, setNewPassword] = useState('');
  const [errorMessage, setErrorMessage] = useState('');
  const [successMessage, setSuccessMessage] = useState('');
  const [isAlertOpen, setIsAlertOpen] = useState(false);
  const [alertMessage, setAlertMessage] = useState('');
  const [alertTitle, setAlertTitle] = useState('');

  const handleChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const { name, value } = e.target;
    if (name === 'oldPassword') {
      setOldPassword(value);
    } else if (name === 'newPassword') {
      setNewPassword(value);
    }
  };

  const handleCloseAlert = () => {
    setIsAlertOpen(false);
    setAlertMessage('');
    setAlertTitle('');
    window.location.href = "/login";
  };

  const showCustomAlert = (message: string, title: string = 'Alert') => {
    setAlertMessage(message);
    setAlertTitle(title);
    setIsAlertOpen(true);
  };

  const [isHovered, setIsHovered] = useState(false);
  const { data: session } = useSession();
  const apiService = new ApiService(session);
  const handleSubmit = async (e: React.FormEvent<HTMLFormElement>) => {
    e.preventDefault();

    try {
      if (apiService) {
        const response = await apiService.UpdatePassword(oldPassword, newPassword);

        if (response && response.status === 204) {
          console.error('The old password is incorrect.');
          setErrorMessage('The old password is incorrect. Please check again.');
        } else {
          console.log('The password has been changed successfully.');
          setSuccessMessage('');
          showCustomAlert('The password has been changed successfully.');
          setIsAlertOpen(true);
        }
      } else {
        console.error('Session is null. User is not authenticated.');
      }
    } catch (error) {
      console.error('Error:', error);
    }
  };


  return (
    <ThemeProvider theme={lightTheme}>
      <Grid container spacing={3}>
        <Grid item xs={12} lg={12}>
  
          <div className={`${styles.formCustom} text-center`}>
            <h1 className={styles.h1Custom}>Change Password</h1>
            <form onSubmit={handleSubmit}>
              <div>
                <TextField
                  type="password"
                  label="Old Password"
                  name="oldPassword"
                  value={oldPassword}
                  onChange={handleChange}
                  className={styles.inputCustom}
                />
                {errorMessage && <p style={{ color: 'red' }}>{errorMessage}</p>}
              </div>
              <div>
                <TextField
                  type="password"
                  label="New Password"
                  name="newPassword"
                  value={newPassword}
                  onChange={handleChange}
                  className={styles.inputCustom}
                />
              </div>
              <Button type="submit" className={styles.borderButton}>
                Change Password
              </Button>
              <Dialog
                classes={{ paper: styles.customAlert }} 
                open={isAlertOpen}
                onClose={handleCloseAlert}
              >
                <DialogTitle>SUCCESS</DialogTitle>
                <DialogContent>
                  <p>{alertMessage}</p>
                </DialogContent>
                <DialogActions>
                  <Button 
                  className={`${styles.okButton} ${isHovered ? styles.okButtonHover : ''}`}
                  onMouseEnter={() => setIsHovered(true)}
                  onMouseLeave={() => setIsHovered(false)}
                  onClick={handleCloseAlert}
                  >OK
                  </Button>
                </DialogActions>
              </Dialog>
            </form>
          </div>
        </Grid>
      </Grid>
    </ThemeProvider>
  );
};

export default ChangePassword;
