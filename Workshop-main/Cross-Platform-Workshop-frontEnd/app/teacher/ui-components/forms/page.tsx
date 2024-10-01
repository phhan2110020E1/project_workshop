
'use client'
import React, { useState, ChangeEvent, useEffect } from "react"
import { FirebaseDb } from "../../../../utils/FireBase/Config"
import { getDownloadURL, ref, uploadBytes } from "firebase/storage"
import { v4 } from 'uuid';
import {
  Paper,
  Grid,
  TextField,
  Button
} from '@mui/material';
import {
  createTheme,
  ThemeProvider
} from "@mui/material/styles";
import { useSession } from 'next-auth/react';
import styles from '../forms/form.module.css';
import Image from "next/image";


const lightTheme = createTheme({ palette: { mode: 'light' } });

const EditProfile = () => {
  const [inforUser, setInforUser] = useState("")
  const [userData, setUserData] = useState({
    full_name: '',
    user_name: '',
    email: '', // Thêm trường email
    phoneNumber: '',
    image_url: '',
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

  const [validationErrors, setValidationErrors] = useState({
    full_name: '',
    user_name: '',
    email: '',
    phoneNumber: '',
    image_url: '',
    state: '',
    city: '',
    address: '',
    postalCode: 0,
  });

  useEffect(() => {
    // console.log(session?.user.accessToken)
    if (session) {
      fetch('http://localhost:8089/user/detail', {
        headers: {
          Authorization: `Bearer ${session?.user.accessToken}`,
        },
      })
        .then((response) => response.json())
        .then((data) => {
          if (data && data.data) {
            setUserData(data.data);
            // console.log(data.data);

          }
        })
        .catch((error) => {
          console.error('Error fetching user data:', error);

        });
    }
  }, [session]);

  const handleInputChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const { name, value } = e.target;

    // Xác định các trường dữ liệu và cập nhật chúng
    if (name === 'email') {
      setUserData({ ...userData, email: value });
    } else if (name === 'full_name') {
      setUserData({ ...userData, full_name: value });
    } else if (name === 'user_name') {
      setUserData({ ...userData, user_name: value });
    } else if (name === 'phoneNumber') {
      setUserData({ ...userData, phoneNumber: value });
    } else if (name === 'image_url') {
      setUserData({ ...userData, image_url: value });
    }
    validateInput(name, value);
  };

  const handleAddressChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const { name, value } = e.target;

    if (userData.userAddresses && userData.userAddresses.length > 0) {
      // Đã có thông tin userAddresses, tìm "id" và gán lại
      let existingAddress = userData.userAddresses[0];
      if (!existingAddress) {
        existingAddress = {
          id: 0,
          state: '',
          city: '',
          address: '',
          postalCode: 0,
        };
      }

      if (name === 'id') {
        existingAddress.id = parseInt(value, 10);
      } else if (name === 'state') {
        existingAddress.state = value || ''; // Sử dụng giá trị của `value`, nếu nó là `undefined`, thì gán bằng chuỗi rỗng
      } else if (name === 'city') {
        existingAddress.city = value || ''; // Tương tự cho các trường khác
      } else if (name === 'address') {
        existingAddress.address = value || '';
      } else if (name === 'postalCode') {
        existingAddress.postalCode = value ? parseInt(value, 10) : 0;
      }

      setUserData({
        ...userData,
        userAddresses: [existingAddress],
      });
    } else {
      // Chưa có thông tin userAddresses, tạo một bản ghi mới
      const newAddress: {
        id: number;
        state: string; // Đảm bảo rằng trường state luôn là chuỗi
        city: string;
        address: string;
        postalCode: number;
      } = {
        id: 0,
        state: '',
        city: '',
        address: '',
        postalCode: 0,
      };
      if (name === 'state') {
        newAddress.state = value || ''; // Sử dụng giá trị của `value`, nếu nó là `undefined`, thì gán bằng chuỗi rỗng
      } else if (name === 'city') {
        newAddress.city = value || ''; // Tương tự cho các trường khác
      } else if (name === 'address') {
        newAddress.address = value || '';
      } else if (name === 'postalCode') {
        newAddress.postalCode = value ? parseInt(value, 10) : 0;
      }

      setUserData({
        ...userData,
        userAddresses: [newAddress],
      });
    }
    validateInput(name, value);
  }
  const validateInput = (name: string, value: string) => {
    let errorMessage = '';

    // Add validation logic based on the input name
    switch (name) {
      case 'full_name':
        errorMessage = value.trim() ? '' : 'Full Name is required';
        break;
      case 'user_name':
        errorMessage = value.trim() ? '' : 'User Name is required';
        break;
      case 'email':
        const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
      errorMessage = emailRegex.test(value) ? '' : 'Invalid email format';
        break;
      case 'phoneNumber':
        const phoneNumberRegex = /^\d{8,}$/;
        errorMessage = phoneNumberRegex.test(value) ? '' : 'Invalid phone number format';
        break;
      case 'image_url':
        errorMessage = value.trim() ? '' : 'Image is required';
        break;
      case 'state':
        errorMessage = value.trim() ? '' : 'State is required';
        break;
      case 'city':
        errorMessage = value.trim() ? '' : 'City is required';
        break;
      case 'address':
        errorMessage = value.trim() ? '' : 'Address is required';
        break;
      case 'postalCode':
        const postalCodeRegex = /^\d{3,}$/;
        errorMessage = postalCodeRegex.test(value) ? '' : 'Invalid postalCode format';
        break;
      default:
        break;
      // Add more cases for other fields
    }
    setValidationErrors({ ...validationErrors, [name]: errorMessage });
  }
  const hasValidationErrors = () => {
    // Check if any validation errors exist
    return Object.values(validationErrors).some((error) => Boolean(error));
  };
  const handleSubmit = async (e: React.ChangeEvent<HTMLFormElement>) => {
    e.preventDefault();
    if (hasValidationErrors()) {
      console.error('Form has validation errors. Please correct them.');
      return;
    }
    try {
      if (session) {

        const response = await fetch('http://localhost:8089/auth/user/edit', {
          method: 'PUT',
          headers: {
            //  Authorization: `Bearer ${authToken}`,
            'Content-Type': 'application/json',
          },
          body: JSON.stringify(userData),
        });

        if (response.ok) {
          console.log('User data updated successfully.');
          // console.log(userData);

        } else {
          console.error('Error updating user data:', response.status);
        }
      } else {
        console.error('Session is null. User is not authenticated.');
      }
    } catch (error) {
      console.error('Error:', error);
    }
  };



  const handleImageUpload = async (event: React.ChangeEvent<HTMLInputElement>) => {
    const files = event.target.files;
    if (files) {
      const selectedImage = files[0];
      if (selectedImage) {
        const imgRef = ref(FirebaseDb, `/user/${v4()}`);
        try {
          const uploadTask = await uploadBytes(imgRef, selectedImage);
          const url = await getDownloadURL(uploadTask.ref);

          // Lưu đường dẫn hình ảnh vào userData
          setUserData({ ...userData, image_url: url });
          console.log("url reponse", url);
        } catch (error) {
          console.error("Lỗi tải lên:", error);
        }
      } else {
        console.error("Không có tệp hình ảnh được chọn.");
      }
    } else {
      console.error("Không có tệp hình ảnh được chọn.");
    }
  };


  return (
    <ThemeProvider theme={lightTheme}>
      <Grid container spacing={3}>
        <Grid item xs={12} lg={12}>
          <div className={`${styles.formCustom} text-center`}>
            <h1 className={styles.h1Custom}>Edit Profile</h1>
            <Image className={styles.imageMargin} src="/../../../heading-line-dec.png" alt="" width={45} height={2} />
            <form onSubmit={handleSubmit}>
              <div>
                <TextField
                  type="text"
                  label="Full Name"
                  name="full_name"
                  value={userData.full_name || ''}
                  onChange={handleInputChange}
                  className={styles.inputCustom}
                  error={Boolean(validationErrors.full_name)}
                  helperText={validationErrors.full_name}
                />


                <TextField
                  type="text"
                  label="User Name"
                  name="user_name"
                  value={userData.user_name || ''}
                  onChange={handleInputChange}
                  className={styles.inputCustom}
                  error={Boolean(validationErrors.user_name)}
                  helperText={validationErrors.user_name}
                />
              </div>
              <div>
                <TextField
                  type="text"
                  label="Email"
                  name="email"
                  value={userData.email || ''}
                  onChange={handleInputChange}
                  className={styles.inputCustom}
                  error={Boolean(validationErrors.email)}
                  helperText={validationErrors.email}
                />

                <TextField
                  type="text"
                  label="Phone Number"
                  name="phoneNumber"
                  value={userData.phoneNumber || ''}
                  onChange={handleInputChange}
                  className={styles.inputCustom}
                  error={Boolean(validationErrors.phoneNumber)}
                  helperText={validationErrors.phoneNumber}
                />
              </div>

              <div>
                <TextField
                  type="text"
                  label="State"
                  name="state"
                  value={userData?.userAddresses[0]?.state || ''}
                  onChange={handleAddressChange}
                  className={styles.inputCustom}
                  error={Boolean(validationErrors.state)}
                  helperText={validationErrors.state}
                />

                <TextField
                  type="text"
                  label="City"
                  name="city"
                  value={userData?.userAddresses[0]?.city || ''}
                  onChange={handleAddressChange}
                  className={styles.inputCustom}
                  error={Boolean(validationErrors.city)}
                  helperText={validationErrors.city}
                />
              </div>
              <div>
                <TextField
                  type="text"
                  label="Address"
                  name="address"
                  value={userData?.userAddresses[0]?.address || ''}
                  onChange={handleAddressChange}
                  className={styles.inputCustom}
                  error={Boolean(validationErrors.address)}
                  helperText={validationErrors.address}
                />

                <TextField
                  type="number"
                  label="Postal Code"
                  name="postalCode"
                  value={userData?.userAddresses[0]?.postalCode || ''}
                  onChange={handleAddressChange}
                  className={styles.inputCustom}
                  error={Boolean(validationErrors.postalCode)}
                  helperText={validationErrors.postalCode}
                />

              </div>
              <div className={styles.leftAlignedDiv}>
                {userData.image_url && (
                  <img src={userData.image_url} alt="User Avatar" className={styles.roundedImage} />
                )}
                <input
                  type="hidden"
                  // label="Image URL"
                  name="image_url"
                  value={userData.image_url || ''}
                  onChange={(e) => setUserData({ ...userData, image_url: e.target.value })}
                  className={styles.inputCustom2}
                />
                <label className={styles.customFileInput}>
                  Choose File
                  <input
                    id="fileInput" // Gán id cho input
                    type="file"
                    accept="image/*"
                    onChange={handleImageUpload}
                  />
                </label>
              </div>
              <Button type="submit"
                className={styles.borderButton}>
                Save Profile
              </Button>
              <Button href="/teacher/ui-components/changepass"
                className={styles.borderButton}>
                Change Password
              </Button>
            </form>
          </div>
        </Grid>
      </Grid>
    </ThemeProvider>
  );

};
export default EditProfile;