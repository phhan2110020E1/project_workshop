// // 'use client'
// // import React, { useState, ChangeEvent ,useEffect} from "react"
// // import { FirebaseDb } from "./Config"
// // import { getDownloadURL,  ref, uploadBytes } from "firebase/storage"
// // import { v4  } from 'uuid';
// // import { Container } from "react-bootstrap";

// // export default function DemoUpload() {
// //     const [img, setImg] = useState('');
// //     const [imgUrl, setImgUrl ]= useState('');

// //     const handleImageUpload = (event) => {
// //         const files = event.target.files;
// //     if (files) {
// //         const selectedImage = files[0];
// //         if (selectedImage) {
// //             const fileExtension = selectedImage.name.split('.').pop();
// //             console.log("File Extension:", fileExtension);
// //             setImg({ file: selectedImage, extension: fileExtension });
// //         } else {
// //             console.error("Không có tệp hình ảnh được chọn.");
// //         }
// //     } else {
// //         console.error("Không có tệp hình ảnh được chọn.");
// //     }
// //     }
// //     const handleClick = () => {
// //         if (img && img.file) {
// //             const { file, extension } = img;
// //             const fileName = `${v4()}.${extension}`;
// //             const imgRef = ref(FirebaseDb,`/user/${v4()}`); 
// //             uploadBytes(imgRef, file).then((value) => {
// //                 console.log("Tải lên thành công :", value);
// //                 getDownloadURL(value.ref).then(url => {
// //                     setImgUrl(data => [...data, { url, fileName }]);
// //                 });
// //             }).catch((error) => {
// //                 console.error("Lỗi tải lên:", error);
// //             });
// //         }
// //     };
// //     console.log("Url :",imgUrl);
  
// //     return (
// //         <Container className="">
// //             <input type="file" onChange={handleImageUpload}/>
// //             <button onClick={handleClick}>Upload</button>
// //         </Container>
// //     )
// // }


// // 'use client'
// // import React, { useState, useEffect } from 'react';
// // import {
// //   Paper,
// //   Grid,
// //   TextField,
// //   Button,
// //   createTheme,
// //   ThemeProvider,
// // } from '@mui/material';
// // import { useSession } from 'next-auth/react';

// // const lightTheme = createTheme({ palette: { mode: 'light' } });

// // const EditProfile = () => {
// //   const { data: session } = useSession();
// //   const [updatedUser, setUpdatedUser] = useState({
// //     full_name: '',
// //     user_name: '',
// //     email: '',
// //     phoneNumber: '',
// //   });

// //   const handleInputChange = (e: React.ChangeEvent<HTMLInputElement>) => {
// //     const { name, value } = e.target;
// //     setUpdatedUser((prevState) => ({
// //       ...prevState,
// //       [name]: value,
// //     }));
// //   };

// //   const handleEditUser = async () => {
// //     try {
// //       if (session) {
// //         const response = await fetch('http://localhost:8089/auth/user/edit', {
// //           method: 'PUT',
// //           headers: {
// //             'Content-Type': 'application/json',
// //           },
// //           body: JSON.stringify({ ...updatedUser }),
// //         });

// //         if (response.ok) {
// //           // Xử lý thành công (ví dụ: hiển thị thông báo thành công)
// //         } else {
// //           // Xử lý lỗi (ví dụ: hiển thị thông báo lỗi)
// //         }
// //       } else {
// //         // Xử lý trường hợp khi session là null (ví dụ: hiển thị thông báo lỗi)
// //       }
// //     } catch (error) {
// //       console.error('Lỗi:', error);
// //     }
// //   };


// //   return (
// //     <ThemeProvider theme={lightTheme}>
// //       <Grid container spacing={3}>
// //         <Grid item xs={12} lg={12}>
// //           <div>
// //             <h1>Edit Profile</h1>
// //             <form>
// //               <TextField
// //                 type="text"
// //                 name="full_name"
// //                 label="Full Name"
// //                 variant="outlined"
// //                 value={updatedUser.full_name}
// //                 onChange={handleInputChange}
// //               />
// //               <TextField
// //                 type="text"
// //                 name="user_name"
// //                 label="User Name"
// //                 variant="outlined"
// //                 value={updatedUser.user_name}
// //                 onChange={handleInputChange}
// //               />
// //               <TextField
// //                 name="email"
// //                 label="Email"
// //                 variant="outlined"
// //                 value={updatedUser.email}
// //                 onChange={handleInputChange}
// //               />
// //               <TextField
// //                 name="phoneNumber"
// //                 label="Phone Number"
// //                 variant="outlined"
// //                 value={updatedUser.phoneNumber}
// //                 onChange={handleInputChange}
// //               />
// //               <Button variant="contained" onClick={handleEditUser}>
// //                 Submit
// //               </Button>
// //             </form>
// //           </div>
// //         </Grid>
// //       </Grid>
// //     </ThemeProvider>
// //   );
// // };

// // export default EditProfile;

// // 'use client'
// // import React, { useState, useEffect } from 'react';
// // import {
// //   Paper,
// //   Grid,
// //   TextField,
// //   Button,
// //   createTheme,
// //   ThemeProvider,
// // } from '@mui/material';
// // import { useSession } from 'next-auth/react';


// // const lightTheme = createTheme({ palette: { mode: 'light' } });

// // const EditProfile = () => {
// //   const [inforUser, setInforUser] = useState("")
// //   const [userData, setUserData] = useState({
// //     full_name: '',
// //     user_name: '',
// //     email: '', // Thêm trường email
// //     phoneNumber: '',
// //     image_url: '',
// //     roles: '',
// //     userAddresses: [
// //       {
// //         state: '',
// //         city: '',
// //         address: '',
// //         postalCode: 0,
// //       },
// //     ],
// //   });

// //   const { data: session } = useSession();
// //   useEffect(() => {
// //     console.log(session?.user.accessToken)

// //     if(session) {
// //       fetch('http://localhost:8089/user/detail', {
// //         headers: {
// //           Authorization: `Bearer ${session?.user.accessToken}`,
// //         },
// //       })
// //         .then((response) => response.json())
// //         .then((data) => {
// //           console.log(data);

// //           if (data && data.data) {
// //             setUserData(data.data);
// //           }
// //         })
// //         .catch((error) => {
// //           console.error('Error fetching user data:', error);
// //         });
// //     } 
// //   }, [session]);

// //   const handleInputChange = (e: React.ChangeEvent<HTMLInputElement>) => {
// //     const { name, value } = e.target;

// //     // Xác định các trường dữ liệu và cập nhật chúng
// //     if (name === 'email') {
// //       setUserData({ ...userData, email: value });
// //     } else if (name === 'full_name') {
// //       setUserData({ ...userData, full_name: value });
// //     } else if (name === 'user_name') {
// //       setUserData({ ...userData, user_name: value });
// //     } else if (name === 'phoneNumber') {
// //       setUserData({ ...userData, phoneNumber: value });
// //     } else if (name === 'image_url') {
// //       setUserData({ ...userData, image_url: value });
// //     } else if (name === 'roles') {
// //       setUserData({ ...userData, roles: value });
// //     }
// //   };

// //   const handleAddressChange = (e: React.ChangeEvent<HTMLInputElement>) => {
// //     const { name, value } = e.target;

// //     // Xác định các trường địa chỉ và cập nhật chúng
// //     if (name === 'state') {
// //       setUserData({
// //         ...userData,
// //         userAddresses: [{ ...userData.userAddresses[0], state: value }],
// //       });
// //     } else if (name === 'city') {
// //       setUserData({
// //         ...userData,
// //         userAddresses: [{ ...userData.userAddresses[0], city: value }],
// //       });
// //     } else if (name === 'address') {
// //       setUserData({
// //         ...userData,
// //         userAddresses: [{ ...userData.userAddresses[0], address: value }],
// //       });
// //     } else if (name === 'postalCode') {
// //       setUserData({
// //         ...userData,
// //         userAddresses: [{ ...userData.userAddresses[0], postalCode: parseInt(value, 10) }],
// //       });
// //     }
// //   };

// //   const handleSubmit = async (e: React.ChangeEvent<HTMLFormElement>) => {
// //     e.preventDefault();
// //     try {
// //       if (session) {
// //         const authToken = session.user.accessToken;
// //         console.log(authToken);
// //         console.log(userData);


// //         const response = await fetch('http://localhost:8089/auth/user/edit', {
// //           method: 'PUT',
// //           headers: {
// //             // Authorization: `Bearer ${authToken}`,
// //             'Content-Type': 'application/json',
// //           },
// //           body: JSON.stringify(userData),
// //         });

// //         if (response.ok) {
// //           console.log('User data updated successfully.');
// //         } else {
// //           console.error('Error updating user data:', response.status);
// //         }
// //       } else {
// //         console.error('Session is null. User is not authenticated.');
// //       }
// //     } catch (error) {
// //       console.error('Error:', error);
// //     }
// //   };



// //   return (
// //     <ThemeProvider theme={lightTheme}>
// //       <Grid container spacing={3}>
// //         <Grid item xs={12} lg={12}>
// //           <div>
// //             <h1>Edit Profile</h1>
// //             <form onSubmit={handleSubmit}>
// //               <TextField
// //                 type="text"
// //                 label="Full Name"
// //                 name="full_name"
// //                 value={userData.full_name}
// //                 onChange={handleInputChange}
// //               />
// //               <TextField
// //                 type="text"
// //                 label="User Name"
// //                 name="user_name"
// //                 value={userData.user_name}
// //                 onChange={handleInputChange}
// //               />
// //               <TextField
// //                 type="text"
// //                 label="Email"
// //                 name="email"
// //                 value={userData.email}
// //                 onChange={handleInputChange}
// //               />
// //               <TextField
// //                 type="text"
// //                 label="Phone Number"
// //                 name="phoneNumber"
// //                 value={userData.phoneNumber}
// //                 onChange={handleInputChange}
// //               />
// //               <TextField
// //                 type="text"
// //                 label="Image URL"
// //                 name="image_url"
// //                 value={userData.image_url}
// //                 onChange={handleInputChange}
// //               />
// //               <TextField
// //                 type="text"
// //                 label="Roles"
// //                 name="roles"
// //                 value={userData.roles}
// //                 onChange={handleInputChange}
// //               />
// //               <TextField
// //                 type="text"
// //                 label="State"
// //                 name="state"
// //                 value={userData?.userAddresses[0].state}
// //                 onChange={handleAddressChange}
// //               />
// //               <TextField
// //                 type="text"
// //                 label="City"
// //                 name="city"
// //                 value={userData?.userAddresses[0].city}
// //                 onChange={handleAddressChange}
// //               />
// //               <TextField
// //                 type="text"
// //                 label="Address"
// //                 name="address"
// //                 value={userData?.userAddresses[0].address}
// //                 onChange={handleAddressChange}
// //               />
// //               <TextField
// //                 type="number"
// //                 label="Postal Code"
// //                 name="postalCode"
// //                 value={userData?.userAddresses[0].postalCode}
// //                 onChange={handleAddressChange}
// //               />
// //               <button type="submit">Save</button>
// //             </form>
// //           </div>
// //         </Grid>
// //       </Grid>
// //     </ThemeProvider>
// //   );
// // };

// // export default EditProfile;

// 'use client'
// import React, { useState, ChangeEvent, useEffect } from "react"
// import { FirebaseDb } from ".././../../FireBase/Config"
// import { getDownloadURL, ref, uploadBytes, uploadBytesResumable } from "firebase/storage"
// import { v4 } from 'uuid';
// import { Container } from "react-bootstrap";
// import { UploadTaskSnapshot } from 'firebase/storage';
// import {
//   Paper,
//   Grid,
//   TextField,
//   Button,
//   createTheme,
//   ThemeProvider,
// } from '@mui/material';
// import { useSession } from 'next-auth/react';


// const lightTheme = createTheme({ palette: { mode: 'light' } });

// const EditProfile = () => {
//   const [inforUser, setInforUser] = useState("")
//   const [userData, setUserData] = useState({
//     full_name: '',
//     user_name: '',
//     email: '', // Thêm trường email
//     phoneNumber: '',
//     image_url: '',
//     roles: '',
//     userAddresses: [
//       {
//         state: '',
//         city: '',
//         address: '',
//         postalCode: 0,
//       },
//     ],
//   });

//   const { data: session } = useSession();


//   useEffect(() => {
//     // console.log(session?.user.accessToken)
// var response = {}
//     if (session) {
//       fetch('http://localhost:8089/user/detail', {
//         headers: {
//           Authorization: `Bearer ${session?.user.accessToken}`,
//         },
//       })
//         .then((response) => response.json())
//         .then((data) => {
//           // data.data.roles.join();

//           // const result = {... data.data, data.data.roles: data.data.roles.join();}
//           // console.log(result);

//           if (data && data.data) {
//             setUserData(data.data);
//           }
//         })
//         .catch((error) => {
//           console.error('Error fetching user data:', error);
//         });
//     }
//   }, [session]);

//   const handleInputChange = (e: React.ChangeEvent<HTMLInputElement>) => {
//     const { name, value } = e.target;

//     // Xác định các trường dữ liệu và cập nhật chúng
//     if (name === 'email') {
//       setUserData({ ...userData, email: value });
//     } else if (name === 'full_name') {
//       setUserData({ ...userData, full_name: value });
//     } else if (name === 'user_name') {
//       setUserData({ ...userData, user_name: value });
//     } else if (name === 'phoneNumber') {
//       setUserData({ ...userData, phoneNumber: value });
//     } else if (name === 'image_url') {
//       setUserData({ ...userData, image_url: value });
//     } else if (name === 'roles') {
//       setUserData({ ...userData, roles: userData.roles.join() });
//     }
//   };

//   // console.log(userData);

//   const handleAddressChange = (e: React.ChangeEvent<HTMLInputElement>) => {
//     const { name, value } = e.target;

//     // Xác định các trường địa chỉ và cập nhật chúng
//     if (name === 'state') {
//       setUserData({
//         ...userData,
//         userAddresses: [{ ...userData.userAddresses[0], state: value }],
//       });
//     } else if (name === 'city') {
//       setUserData({
//         ...userData,
//         userAddresses: [{ ...userData.userAddresses[0], city: value }],
//       });
//     } else if (name === 'address') {
//       setUserData({
//         ...userData,
//         userAddresses: [{ ...userData.userAddresses[0], address: value }],
//       });
//     } else if (name === 'postalCode') {
//       setUserData({
//         ...userData,
//         userAddresses: [{ ...userData.userAddresses[0], postalCode: parseInt(value, 10) }],
//       });
//     }
//   };

//   const handleSubmit = async (e: React.ChangeEvent<HTMLFormElement>) => {
//     e.preventDefault();
//     try {
//       if (session) {
//         // const authToken = session.user.accessToken;
//         // console.log(authToken);
//         console.log(userData);


//         const response = await fetch('http://localhost:8089/auth/user/edit', {
//           method: 'PUT',
//           headers: {
//             // Authorization: `Bearer ${authToken}`,
//             'Content-Type': 'application/json',
//           },
//           body: JSON.stringify(userData),
//         });

//         if (response.ok) {
//           console.log('User data updated successfully.');
//         } else {
//           console.error('Error updating user data:', response.status);
//         }
//       } else {
//         console.error('Session is null. User is not authenticated.');
//       }
//     } catch (error) {
//       console.error('Error:', error);
//     }
//   };

//   const [img, setImg] = useState<{ file: File | null, extension: string | undefined }>({
//     file: null,
//     extension: undefined,
//   });
//   const [imgUrl, setImgUrl] = useState<(string | { url: string, fileName: string })[]>([]);





//   // const handleImageUpload = (event: React.ChangeEvent<HTMLInputElement>) => {
//   //   const files = event.target.files;
//   //   if (files) {
//   //     const selectedImage = files[0];
//   //     if (selectedImage) {
//   //       const fileExtension = selectedImage.name.split('.').pop();
//   //       console.log("File Extension:", fileExtension);
//   //       setImg({ file: selectedImage, extension: fileExtension });
//   //     } else {
//   //       console.error("Không có tệp hình ảnh được chọn.");
//   //     }
//   //   } else {
//   //     console.error("Không có tệp hình ảnh được chọn.");
//   //   }
//   // }

//   // const handleClick = () => {
//   //   if (img && img.file) {
//   //     const { file, extension } = img;
//   //     const fileName = `${v4()}.${extension}`;
//   //     const imgRef = ref(FirebaseDb, `/user/${v4()}`);
//   //     uploadBytes(imgRef, file).then((value) => {
//   //       console.log("Tải lên thành công:", value);
//   //       getDownloadURL(value.ref).then(url => {
//   //         setImgUrl((data) => [...data, { url, fileName }]);
//   //         console.log(url);

//   //         // Lưu đường dẫn hình ảnh vào userData
//   //         setUserData({ ...userData, image_url: url });
//   //       });
//   //     }).catch((error) => {
//   //       console.error("Lỗi tải lên:", error);
//   //     });
//   //   }
//   // };

//   return (
//     <ThemeProvider theme={lightTheme}>
//       <Grid container spacing={3}>
//         <Grid item xs={12} lg={12}>
//           <div>
//             <h1>Edit Profile</h1>
//             <form onSubmit={handleSubmit}>
//               <TextField
//                 type="text"
//                 label="Full Name"
//                 name="full_name"
//                 value={userData.full_name}
//                 onChange={handleInputChange}
//               />
//               <TextField
//                 type="text"
//                 label="User Name"
//                 name="user_name"
//                 value={userData.user_name}
//                 onChange={handleInputChange}
//               />
//               <TextField
//                 type="text"
//                 label="Email"
//                 name="email"
//                 value={userData.email}
//                 onChange={handleInputChange}
//               />
//               <TextField
//                 type="text"
//                 label="Phone Number"
//                 name="phoneNumber"
//                 value={userData.phoneNumber}
//                 onChange={handleInputChange}
//               />
//               <TextField
//                 type="text"
//                 label="Image URL"
//                 name="image_url"
//                 value={userData.image_url}
//                 onChange={handleInputChange}
//               />
//               <TextField
//                 type="text"
//                 label="State"
//                 name="state"
//                 value={userData?.userAddresses[0]?.state}
//                 onChange={handleAddressChange}
//               />
//               <TextField
//                 type="text"
//                 label="City"
//                 name="city"
//                 value={userData?.userAddresses[0]?.city}
//                 onChange={handleAddressChange}
//               />
//               <TextField
//                 type="text"
//                 label="Address"
//                 name="address"
//                 value={userData?.userAddresses[0]?.address}
//                 onChange={handleAddressChange}
//               />
//               <TextField
//                 type="number"
//                 label="Postal Code"
//                 name="postalCode"
//                 value={userData?.userAddresses[0]?.postalCode}
//                 onChange={handleAddressChange}
//               />
//               {/* <input
//                 type="file"
//                 accept="image/*"
//                 onChange={handleImageUpload}
//               />
//               <button onClick={handleClick}>Upload Image</button> */}
//               <button type="submit">Save</button>
//             </form>
//           </div>
//         </Grid>
//       </Grid>
//     </ThemeProvider>
//   );
// };
// export default EditProfile;