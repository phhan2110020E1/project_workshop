'use client'
import styles from "/app/admin/profile/updateprofile.module.css";
import React, { useState, useEffect } from "react";
import ApiService from '@/app/services/ApiService';
import Swal from 'sweetalert2';
import { useSession } from 'next-auth/react';

const ChangePassword = () => {
  const [oldPassword, setOldPassword] = useState('');
  const [newPassword, setNewPassword] = useState('');
  const [errorMessage, setErrorMessage] = useState('');
  const [successMessage, setSuccessMessage] = useState(''); // New state for success message

  const handleChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const { name, value } = e.target;
    if (name === 'oldPassword') {
      setOldPassword(value);
    } else if (name === 'newPassword') {
      setNewPassword(value);
    }
  };

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
          setSuccessMessage(''); // Clear success message on error
        } else {
          console.log('The password has been changed successfully.');
          await Swal.fire({
            title: "Success!",
            text: "Your password has been changed successfully!",
            icon: "success",
          }).then(() => {
            // Redirect to the login page after the SweetAlert is closed
            window.location.href = "/login";
          });
        }
      } else {
        console.error('Session is null. User is not authenticated.');
      }
    } catch (error) {
      console.error('Error:', error);
    }
  };

  return (
    <div>
      <div className={styles.container}>
        <div className={styles.formContainer}>

          <form className={styles.form} onSubmit={handleSubmit}>
            <input
              type="password"
              placeholder="Old Password"
              name="oldPassword"
              value={oldPassword}
              onChange={handleChange}
              className={styles.inputCustom}
            />
            {errorMessage && <p className={styles.error}>{errorMessage}</p>}
            {successMessage && <p className={styles.success}>{successMessage}</p>}

            <input
              type="password"
              placeholder="New Password"
              name="newPassword"
              value={newPassword}
              onChange={handleChange}
              className={styles.inputCustom}
            />

            <button type="submit" className={styles.borderButton}>
              Change Password
            </button>
          </form>
        </div>
      </div>
    </div>
  );
};

export default ChangePassword;
