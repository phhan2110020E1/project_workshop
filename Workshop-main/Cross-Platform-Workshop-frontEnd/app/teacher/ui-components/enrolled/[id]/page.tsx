'use client';
// Import các thư viện và component cần thiết
import * as React from 'react';
import { useState, useEffect, ChangeEvent } from 'react';
import Box from '@mui/material/Box';
import Rating from '@mui/material/Rating';
import Typography from '@mui/material/Typography';
import { Grid } from '@mui/material';
import BaseCard from '@/app/user/shared/BaseCard';
import { Button } from 'react-bootstrap';
import ApiService from '@/app/services/ApiService';
import { useSession } from 'next-auth/react';
import { toast, ToastContainer } from 'react-toastify';
import 'react-toastify/dist/ReactToastify.css';

interface EditProps {
  params: {
    id: number;
  };
}
export default function BasicRating({ params }: EditProps) {
  const [value, setValue] = React.useState<number | null>(2);

  const studentEnrollments = [
    { id: 0, name: '' },

  ];
  const [courseData, setCourseData] = useState(studentEnrollments);
  const { id } = params;
  const { data: session } = useSession();
  const apiService = new ApiService(session);
  useEffect(() => {
    const fetchData = async () => {
      if (id) {
        try {
          const response = await apiService.getCourseById(id);
          if (response.status === 'success') {

            setCourseData(response.data[0].studentEnrollments);
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

  console.log('courseData', courseData);
  const handleGiveCouponToAllStudents = async (initialStudentIds: number[]) => {
    try {
      // Thay đổi courseId và studentId theo logic của bạn
      const courseId = id;
      const studentIds = courseData.map(student => student.id);

      console.log('Before submitting:', courseId, studentIds);
      const result = await apiService.addDiscountToStudent(courseId, studentIds);
      console.log('After submitting:', result);
      toast.success('Coupon added successfully!');
      console.log('Discount added to students:', result);
    } catch (error) {
      console.error('Error adding discount to students:', error);
      toast.error('An error occurred. Please try again.');
    }
  };
  return (
    <Grid container spacing={3}>
      <ToastContainer />
      <Grid item xs={12} lg={12}>
        <BaseCard title="Enrollments List">
          <Box>
            <Button variant="contained" onClick={() => handleGiveCouponToAllStudents(courseData.map(student => student.id))}>
              Give Coupon
            </Button>
            {courseData.map((student) => (
              <div key={student.id} style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '8px' }}>
                <span>{student.id}</span>
                <span>{student.name}</span>
              </div>
            ))}
          </Box>
        </BaseCard>
      </Grid>
    </Grid>
  );
}