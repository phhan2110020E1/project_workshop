'use client'
import { ref, uploadBytesResumable, getDownloadURL } from 'firebase/storage';
import { v4 } from 'uuid';
import { useCallback, useState, useEffect, ChangeEvent } from 'react';
import { useRouter } from 'next/navigation';
import ApiService from '@/app/services/ApiService';
import { useSession } from 'next-auth/react';
import PageContainer from '@/app/teacher/components/container/PageContainer';
import Head from 'next/head';
import { Box, Grid, Stack, TextField, Typography, Container, Card, CardContent, CardHeader, FormControlLabel, Switch, Divider, CardActions, Button, CircularProgress } from '@mui/material';
import { FirebaseDb } from '../../../../../utils/FireBase/Config';
import { format } from 'date-fns';
import styles from './edit.module.css';
import CheckCircleIcon from '@mui/icons-material/CheckCircle';
import ClearIcon from '@mui/icons-material/Clear';

interface EditProps {
  params: {
    id: number;
  };
}

const EditCoursePage = ({ params }: EditProps) => {
  const router = useRouter();
  const [loading, setLoading] = useState(true);
  const initialCourseData = {
    id: 0,
    name: '',
    description: '',
    price: 0,
    startDate: new Date(),
    endDate: new Date(),
    student_count: 0,
    type: 'offline',
    courseMediaInfos: [
      {
        id: 0,
        urlMedia: '',
        urlImage: '',
        thumbnailSrc: '' || null,
        title: '',
      },
    ],
    discountDTOS: [
      {
        id: 0,
        quantity: 0,
        redemptionDate: new Date(),
        valueDiscount: 0,
        name: '',
        description: '',
        remainingUses: 0,
        // locationDTO:[{
        //   name: '', 
        //   statusAvailable: '',
        //    address: '', 
        //    description: ''
        // }]
      },
    ],
    courseLocations: [
      {
        id: 0,
        schedule_Date: new Date(),
        area: '',
      },
    ],
  };


  const [courseData, setCourseData] = useState(initialCourseData);
  const { id } = params;
  const { data: session } = useSession();
  const apiService = new ApiService(session);
  useEffect(() => {
    const fetchData = async () => {
      if (id) {
        try {
          const response = await apiService.getCourseById(id);
          if (response.status === 'success') {

            setCourseData(response.data[0]);
          } else {
            console.error('Error fetching course data:', response.error);
          }
        } catch (error) {
          console.error('Error fetching course data:', error);
        }
      }
    };

    fetchData();
  }, [session, id]);

  const handleInputChange = (e: { target: { name: any; value: any; }; }) => {
    const { name, value } = e.target;
    setCourseData((prevData) => ({
      ...prevData,
      [name]: value,

    }));
  };


  const handleLocationInputChange = (event: ChangeEvent<HTMLInputElement | HTMLTextAreaElement>, index: number) => {
    const { name, value } = event.target;

    setCourseData((prevData) => ({
      ...prevData,
      courseLocations: prevData.courseLocations && prevData.courseLocations.map((location, i) =>
        i === index && location
          ? { ...location, [name]: value }
          : location || {} // Ensure location is an object
      ),

    }));
  };



  const handleSubmit = async (e: { preventDefault: () => void; }) => {
    e.preventDefault();
    console.log('Course data before update:', courseData);
    if (hasValidationErrors()) {
      // Display error message or handle validation errors as needed
      console.error('Form has validation errors. Please correct them.');
      return;
    }
    try {
      await apiService.editCourse(id, courseData);
      // Redirect to the course detail page or any other page after successful update
      router.push(`/teacher/ui-components/buttons`);
    } catch (error) {
      console.error('Error updating course:', error);
    }
  };

  const handleImageUpload = async (event: ChangeEvent<HTMLInputElement>) => {
    const files = event.target.files;

    if (files && files[0]) {
      const selectedImage = files[0];
      const imageRef = ref(FirebaseDb, `images/${v4()}`);

      try {
        const uploadTask = uploadBytesResumable(imageRef, selectedImage);

        uploadTask.on(
          'state_changed',
          (snapshot) => {
            const progress = (snapshot.bytesTransferred / snapshot.totalBytes) * 100;
            console.log('Upload is ' + progress + '% done');
          },
          (error) => {
            console.error('Error uploading image:', error);
          },
          async () => {
            try {
              const url = await getDownloadURL(uploadTask.snapshot.ref);

              const newImageInfo = {
                id: courseData.courseMediaInfos[0]?.id,
                urlImage: url,
              };

              setCourseData((prevState) => ({
                ...prevState,
                courseMediaInfos: [
                  {
                    ...prevState.courseMediaInfos[0],
                    urlImage: url,
                  },
                ],
              }));
              console.log('Image uploaded successfully.');
            } catch (error) {
              console.error('Error getting download URL:', error);
            }
          }
        );
      } catch (error) {
        console.error('Error uploading image:', error);
      }
    } else {
      console.error('No image file selected.');
    }
  };

  const hasValidationErrors = () => {
    // Add additional validation logic as needed
    if (
      !courseData.name.trim() ||
      !courseData.description.trim() ||
      isNaN(courseData.price) || 
      !courseData.startDate ||
      !isStartDateValid(courseData.startDate) ||
      !courseData.endDate ||
      !isEndDateValid(courseData.endDate, courseData.startDate)
    ) {
      return true; // There are validation errors
    }
  
    return false; // No validation errors
  };
  const handleImageInputChange = (e: ChangeEvent<HTMLInputElement>) => {
    // Update the state with the value from the hidden input
    setCourseData((prevState) => ({
      ...prevState,
      courseMediaInfos: [
        {
          ...prevState.courseMediaInfos[0],
          urlImage: e.target.value,
        },
      ],
    }));
  };
  console.log('courseData.courseMediaInfos[0]?.id', courseData.courseMediaInfos[0]?.id);

  const handleVideoUpload = async (event: ChangeEvent<HTMLInputElement>) => {
    const files = event.target.files;

    if (files && files[0]) {
      const selectedVideo = files[0];
      const videoRef = ref(FirebaseDb, `videos/${v4()}`);

      try {
        const uploadTask = uploadBytesResumable(videoRef, selectedVideo);

        uploadTask.on(
          'state_changed',
          (snapshot) => {
            const progress = (snapshot.bytesTransferred / snapshot.totalBytes) * 100;
            console.log('Upload is ' + progress + '% done');
          },
          (error) => {
            console.error('Error uploading video:', error);
          },
          async () => {
            try {
              const url = await getDownloadURL(uploadTask.snapshot.ref);

              const newVideoInfo = {
                id: courseData.courseMediaInfos[0]?.id,
                thumbnailSrc: null,
                title: '',
                urlImage: courseData.courseMediaInfos.length > 0 ? courseData.courseMediaInfos[0].urlImage : '',
                urlMedia: url,
              };

              setCourseData((prevState) => ({
                ...prevState,
                courseMediaInfos: [newVideoInfo, ...prevState.courseMediaInfos.slice(1)],
              }));

              console.log('Video uploaded successfully.');
            } catch (error) {
              console.error('Error getting download URL:', error);
            }
          }
        );
      } catch (error) {
        console.error('Error uploading video:', error);
      }
    } else {
      console.error('No video file selected.');
    }
  };


  const handleInputImageChange = (e: ChangeEvent<HTMLInputElement>) => {

    setCourseData((prevState) => ({
      ...prevState,
      courseMediaInfos: [
        {
          ...prevState.courseMediaInfos[0],
          urlMedia: e.target.value,
        },
      ],

    }
    ));
  };
  useEffect(() => {
    console.log('Updated courseData:', courseData);
  }, [courseData]); // Chạy useEffect mỗi khi courseData thay đổi

  console.log(courseData);
  const handleDiscountInputChange = (
    e: ChangeEvent<HTMLInputElement | HTMLTextAreaElement>,
    field: string
  ) => {
    const { value } = e.target;
    setCourseData((prevData) => ({
      ...prevData,
      discountDTOS: prevData.discountDTOS && prevData.discountDTOS.map((discount, i) =>
        i === 0 && discount
          ? { ...discount, [field]: value }
          : discount || {}
      ),
    }));
  };
  const isStartDateValid = (startDate: string | number | Date) => {
    const currentDate = new Date();
    const tomorrow = new Date();
    tomorrow.setDate(currentDate.getDate() + 1);
    const selectedStartDate = new Date(startDate);
    return selectedStartDate >= tomorrow;
  };
  
  // Helper function to check if the End Date is tomorrow or in the future and after Start Date
  const isEndDateValid = (endDate: string | number | Date, startDate: string | number | Date) => {
    const selectedEndDate = new Date(endDate);
    const currentDate = new Date();
    return selectedEndDate >= currentDate && selectedEndDate > new Date(startDate);
  };

  return (
    <div>
      <PageContainer>
        <Head>
          <title>Edit Course</title>
        </Head>
        <Box component="main" sx={{ flexGrow: 1, py: 8 }}>
          <Container maxWidth="lg">
            {/* {loading && <CircularProgress />} {/* Display loading spinner */}
            {/* {!loading && ( */}
            <form onSubmit={handleSubmit}>
              <Stack spacing={3}>
                <Typography variant="h4">Edit Course</Typography>
                <Grid container spacing={3}>
                  <Grid item xs={12} md={6} lg={4}>
                    <Card>
                      <CardContent>
                        <Box
                          sx={{
                            alignItems: 'center',
                            display: 'flex',
                            flexDirection: 'column',
                          }}
                        >
                          {courseData?.courseMediaInfos?.[0]?.urlMedia && (
                            <video width="320" height="240" controls>
                              <source
                                src={courseData.courseMediaInfos[0].urlMedia} type="video/mp4" />
                              Your browser does not support the video tag.
                            </video>
                          )}
                        </Box>
                      </CardContent>
                      <Divider />
                      <CardActions>
                        <Button fullWidth variant="text">
                          <label htmlFor="video-upload">
                            Upload video
                          </label>
                          <input
                            type="hidden"
                            name="video_url"
                            value={courseData.courseMediaInfos?.[0]?.urlMedia}
                            onChange={handleInputImageChange}
                          />

                          <input
                            id="video-upload"
                            type="file"
                            style={{ display: 'none' }}
                            onChange={handleVideoUpload}
                            accept="video/*,image/*"
                            multiple // Allow selecting multiple files for uploading video and images
                          />
                        </Button>
                      </CardActions>

                      <Box
                        sx={{
                          alignItems: 'center',
                          display: 'flex',
                          flexDirection: 'column',
                        }}
                      >
                        {courseData.courseMediaInfos && courseData.courseMediaInfos.length > 0 && (
                          <img
                            src={courseData.courseMediaInfos[0].urlImage}
                            alt="Selected Image"
                            style={{ width: '50%', height: 'auto', maxWidth: '320px' }}
                          />
                        )}

                      </Box>
                      <CardActions>
                        <Button fullWidth variant="text">
                          <label htmlFor="image-upload">
                            Upload image
                          </label>
                          {courseData.courseMediaInfos && courseData.courseMediaInfos.length > 0 && (
                            <input
                              type="hidden"
                              name="image_url"
                              value={courseData.courseMediaInfos[0].urlImage || ''}
                              onChange={handleImageInputChange}
                            />
                          )}

                          <input
                            id="image-upload"
                            type="file"
                            style={{ display: 'none' }}
                            onChange={handleImageUpload}
                            accept="image/*"
                          />
                        </Button>
                      </CardActions>
                    </Card>
                  </Grid>
                  <Grid item xs={12} md={6} lg={8}>
                    <Card>
                      <CardHeader subheader="The information can be edited" title="Profile" />
                      <CardContent sx={{ pt: 0 }}>
                        <Box sx={{ m: -1.5 }}>
                          <Grid container spacing={3}>
                            <Grid item xs={12} md={6}>
                              <TextField
                                fullWidth
                                label="Course name"
                                name="name"
                                onChange={handleInputChange}
                                required
                                value={courseData.name}
                                InputLabelProps={{ shrink: true }}
                                error={!courseData.name.trim()}  // Basic validation, checking if the field is not empty
                                helperText={!courseData.name.trim() ? 'Course name is required' : ''}
                              />
                            </Grid>
                            <Grid item xs={12} md={6}>
                              <TextField
                                fullWidth
                                label="Description"
                                name="description"
                                onChange={handleInputChange}
                                required
                                value={courseData.description}
                                InputLabelProps={{ shrink: true }}
                                error={!courseData.description.trim()}
                                helperText={!courseData.description.trim() ? 'Description is required' : ''}
                              />
                            </Grid>
                            <Grid item xs={12} md={6}>
                              <TextField
                                fullWidth
                                label="Price"
                                name="price"
                                onChange={handleInputChange}
                                required
                                type="number"
                                value={courseData.price}
                                InputLabelProps={{ shrink: true }}
                                error={isNaN(courseData.price) || courseData.price <= 0}  // Checking if the price is a valid positive number
                                helperText={
                                  isNaN(courseData.price)
                                    ? 'Price must be a valid number'
                                    : courseData.price <= 0
                                      ? 'Price must be a positive number'
                                      : ''
                                }
                              />
                            </Grid>
                            <Grid item xs={12} md={6}>
                              <TextField
                                fullWidth
                                label="Start Date"
                                name="startDate"
                                onChange={handleInputChange}
                                type="date"
                                value={format(new Date(courseData.startDate), 'yyyy-MM-dd')}
                                InputLabelProps={{ shrink: true }}
                                error={!courseData.startDate || !isStartDateValid(courseData.startDate)}
                                helperText={
                                  !courseData.startDate
                                    ? 'Start Date is required'
                                    : !isStartDateValid(courseData.startDate)
                                      ? 'Start Date must be tomorrow or in the future'
                                      : ''
                                }
                              />
                            </Grid>
                            <Grid item xs={12} md={6}>
                              <TextField
                                fullWidth
                                label="End Date"
                                name="endDate"
                                onChange={handleInputChange}
                                type="date"
                                value={format(new Date(courseData.endDate), 'yyyy-MM-dd')}
                                InputLabelProps={{ shrink: true }}
                                error={!courseData.endDate || !isEndDateValid(courseData.endDate, courseData.startDate)}
                                helperText={
                                  !courseData.endDate
                                    ? 'End Date is required'
                                    : !isEndDateValid(courseData.endDate, courseData.startDate)
                                      ? 'End Date must be tomorrow or in the future and after Start Date'
                                      : ''
                                }
                              />
                            </Grid>
                          </Grid>
                        </Box>
                      </CardContent>
                      <Divider />
                      <CardContent sx={{ pt: 0 }}>
                        <CardHeader subheader="Your location for workshop" />
                        <Box sx={{ m: -1.5 }}>
                          <Grid container spacing={3} >
                            <Grid item xs={12} md={6}>
                              <TextField
                                fullWidth
                                label="Schedule Date"
                                name="schedule_Date"
                                onChange={(event) => handleLocationInputChange(event, 0)}
                                type="date"
                                disabled
                                value={format(new Date(courseData.courseLocations && courseData.courseLocations[0]?.schedule_Date || ''), 'yyyy-MM-dd')} InputLabelProps={{ shrink: true }}
                              />
                            </Grid>
                            <Grid item xs={12} md={6}>
                              <TextField
                                fullWidth
                                label="Area"
                                name="area"
                                onChange={(event) => handleLocationInputChange(event, 0)}
                                disabled
                                value={courseData.courseLocations && courseData.courseLocations[0]?.area || ''}
                              />
                            </Grid>
                            <Grid item xs={12} md={6}>
                              <TextField
                                fullWidth
                                label="District"
                                name="District"
                                onChange={(event) => handleLocationInputChange(event, 0)}
                                disabled
                                value={courseData?.courseLocations?.[0]?.locationDTO?.address || ''}
                              />
                            </Grid><Grid item xs={12} md={6}>
                              <TextField
                                fullWidth
                                label="Center"
                                name="Center"
                                onChange={(event) => handleLocationInputChange(event, 0)}
                                disabled
                                value={courseData?.courseLocations?.[0]?.locationDTO?.name || ''}
                              />
                            </Grid>
                            <Grid item xs={12} md={6}>
                              <TextField
                                fullWidth
                                label="Branch "
                                name="branch "
                                onChange={(event) => handleLocationInputChange(event, 0)}
                                disabled
                                value={courseData?.courseLocations?.[0]?.locationDTO?.description || ''}
                              />
                            </Grid>
                            <Grid item xs={12} md={6}>
                              {courseData?.courseLocations?.[0]?.locationDTO?.statusAvailable === 'available' ? (
                                <div>
                                  <CheckCircleIcon fontSize="small" style={{ color: 'green' }} />
                                  <span style={{ marginLeft: '5px', color: 'green' }}>Available Now</span>
                                </div>
                              ) : (
                                <div>
                                  <ClearIcon fontSize="small" style={{ color: 'red' }} />
                                  <span style={{ marginLeft: '5px', color: 'red' }}>Not Available Now</span>
                                </div>
                              )}
                            </Grid>
                          </Grid>


                        </Box>

                      </CardContent>
                    </Card>
                  </Grid>
                </Grid>
                <Stack spacing={3}>
                  <Card>
                    <CardHeader
                      subheader="Manage Discounts"
                      title="Discount Information"
                    />
                    <Divider />
                    <CardContent>
                      <Grid container spacing={2}>
                        <Grid item xs={12}>
                          <TextField
                            fullWidth
                            label="Discount Name"
                            name="name"
                            onChange={handleInputChange}
                            value={courseData.discountDTOS[0]?.name}
                            variant="outlined"
                            disabled

                          />
                        </Grid>
                        <Grid item xs={12}>
                          <TextField
                            fullWidth
                            label="Description"
                            name="description"
                            onChange={(e) => handleDiscountInputChange(e, 'description')}
                            value={courseData.discountDTOS[0]?.description}
                            variant="outlined"
                            disabled

                          />
                        </Grid>
                        <Grid item xs={6}>
                          <TextField
                            fullWidth
                            label="Quantity"
                            name="quantity"
                            onChange={(e) => handleDiscountInputChange(e, 'quantity')}
                            value={courseData.discountDTOS[0]?.quantity}
                            type="number"
                            variant="outlined"
                            disabled

                          />
                        </Grid>
                        <Grid item xs={6}>
                          <TextField
                            fullWidth
                            label="Value Discount"
                            name="valueDiscount"
                            onChange={(e) => handleDiscountInputChange(e, 'valueDiscount')}
                            value={courseData.discountDTOS[0]?.valueDiscount}
                            type="number"
                            variant="outlined"
                            disabled

                          />
                        </Grid>
                        <Grid item xs={6}>
                          <TextField
                            fullWidth
                            label="Remaining Uses"
                            name="remainingUses"
                            onChange={(e) => handleDiscountInputChange(e, 'remainingUses')}
                            value={courseData.discountDTOS[0]?.remainingUses}
                            type="number"
                            variant="outlined"
                            disabled

                          />
                        </Grid>
                        <Grid item xs={6}>
                          <TextField
                            fullWidth
                            label="Redemption Date"
                            name="redemptionDate"
                            type="datetime-local"
                            onChange={(e) => handleDiscountInputChange(e, 'redemptionDate')}
                            value={courseData.discountDTOS[0]?.redemptionDate
                              ? format(new Date(courseData.discountDTOS[0].redemptionDate), 'yyyy-MM-dd\'T\'HH:mm')
                              : format(new Date(), 'yyyy-MM-dd\'T\'HH:mm')}
                            InputLabelProps={{ shrink: true }}
                            disabled
                            variant="outlined"
                          />
                        </Grid>
                      </Grid>
                    </CardContent>
                    <Divider />

                  </Card>
                </Stack>
              </Stack>

              <CardActions sx={{ justifyContent: 'flex-end' }}>
                <Button type="submit" variant="contained">
                  Save Changes
                </Button>
              </CardActions>
            </form>
            {/* )} */}
          </Container>
        </Box>
      </PageContainer>
    </div>
  );
};

export default EditCoursePage;
