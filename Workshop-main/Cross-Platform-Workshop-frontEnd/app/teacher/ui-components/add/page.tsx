'use client';
import Head from 'next/head';
import { useEffect } from 'react';
import React, { useState } from 'react';
import { AccountProfile } from './account-profile';
import { AccountProfileDetails } from './account-profile-details';
import { DiscountDTOS } from './discount';
import { Box, Container, Stack, Typography, Grid, CardActions,Button } from '@mui/material';
import PageContainer from '@/app/teacher/components/container/PageContainer';
import ApiService from '@/app/services/ApiService';
import { useSession } from 'next-auth/react';
import CourseData from './courseData';
import { useRouter } from 'next/navigation';

interface AddProps {
  onSubmit: (data: CourseData) => void;
}
const Add = ({ onSubmit }: AddProps) => {
  const router = useRouter();
  const { data: session } = useSession();
  const [formData, setFormData] = useState<CourseData>({
    courseName: '',
    description: '',
    price: 0,
    startDate: '',
    endDate: '',
    studentCount: 0,
    type: 'offline',
    mediaInfoList: [
      {
        id: 0,
        thumbnailSrc:  '',
        title: 'string',
        urlImage: '',
        urlMedia: '',
      },
    ],
    discountDTOS: [ {
      courseDiscount_id: 0,
      quantity: 0,
      valueDiscount: 0,
      name: '',
      description:'',
      remainingUses: 0,
    },],
    courseLocation: [],
  });
  const [validationErrors, setValidationErrors] = useState({
    // Initialize validation errors for each field
    name: '',
    description: '',
    price: '',
    startDate: '',
    endDate: '',
    schedule_Date: '',
    area: '',
  }); 
  const [validationErrorsDiscount, setValidationErrorsDiscount] = useState({
    // Initialize validation errors for each field
    name: '',
    description: '',
    price: '',
    startDate: '',
    endDate: '',
    schedule_Date: '',
    area: '',
  });
  const handleValidationErrorsDiscount = (errors: any) => {
    setValidationErrors((prevErrors) => ({
      ...prevErrors,
      ...errors,
    }));
  };
  const handleValidationErrors = (errors: any) => {
    setValidationErrors((prevErrors) => ({
      ...prevErrors,
      ...errors,
    }));
  };
  useEffect(() => {
    console.log('formData updated:', formData);
  }, [formData]);


  const handleReceivedVideo = (data: any) => {
    setFormData((prevData) => {
      console.log('handleReceivedVideo nè:', { ...prevData, mediaInfoList: [
      {
        ...prevData.mediaInfoList[0], // Assuming there is only one object in the array
        ...data,
      },
    ],});
      return {
        ...prevData,
        mediaInfoList: [
          {
            ...prevData.mediaInfoList[0], // Assuming there is only one object in the array
            ...data,
          },
        ],
      };
    });
  };
  
  const handleAccountProfileDetailsSubmit = (data: any) => {
    setFormData((prevData) => ({ ...prevData, ...data }));
console.log('handleAccountProfileDetailsSubmit nè :',formData);

  };
  
  const handleDiscountDTOSubmit = (data: any) => {
    const { startDate, endDate } = formData;

  // Include startDate and endDate in the data object
  const newData = {
    ...data,
    startDate,
    endDate,
  };

    setFormData((prevData) => ({ ...prevData, ...data }));
  };

  const handleSubmitDataToServer = async (e: React.FormEvent) => {
    e.preventDefault();
    const hasValidationErrors = Object.values(validationErrors).some((error) => error !== '');
    // const hasValidationErrorsDiscount = Object.values(validationErrorsDiscount).some((error) => error !== '');

    // if (hasValidationErrors && hasValidationErrorsDiscount) {
      if (hasValidationErrors ) {
      // Handle validation errors, e.g., display error messages
      console.log('Validation Errors:', validationErrors);
      // console.log('Validation Errors:', validationErrorsDiscount);
    } else {
      // Proceed with submitting the data to the server
      try {
      const apiService = new ApiService(session);
      const response = await apiService.createCourse(formData);
      if (response && response.status === 'CREATED') {
        router.push(`/teacher/ui-components/buttons`);
      }
    } catch (error) {
      console.error('Error:', error);
    }
  };
}
  
  return (
    <PageContainer>
      <Head>
        <title>New Course</title>
      </Head>
      <Box component="main" sx={{ flexGrow: 1, py: 8 }}>
        <Container maxWidth="lg">
          <form onSubmit={handleSubmitDataToServer}>
            <Stack spacing={3}>
              <Typography variant="h4">New Course</Typography>
              <Grid container spacing={3}>
                <Grid item xs={12} md={6} lg={4}>
                  <AccountProfile onMediaUpload={handleReceivedVideo} existingMediaInfos={undefined} formData={undefined} />
                </Grid>
                <Grid item xs={12} md={6} lg={8}>
                  <AccountProfileDetails onDataChanged={handleAccountProfileDetailsSubmit} onValidationErrors={handleValidationErrors}/>
                </Grid>
              </Grid>
              <Stack spacing={3}>
                <DiscountDTOS onDataChanged={handleDiscountDTOSubmit}  onValidationErrors={handleValidationErrors} startDate={formData.startDate} // Pass startDate
    endDate={formData.endDate}  />
              </Stack>
            </Stack>
  
            <CardActions sx={{ justifyContent: 'flex-end' }}>
              <Button type="submit" variant="contained">
                Submit
              </Button>
            </CardActions>
          </form>
        </Container>
      </Box>
    </PageContainer>
  );
  
};

export default Add;