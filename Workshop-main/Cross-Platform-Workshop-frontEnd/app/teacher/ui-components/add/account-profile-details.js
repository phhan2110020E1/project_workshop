'use client';
import { useCallback, useState } from 'react';
import {
  Box,
  Card,
  CardContent,
  CardHeader,
  Divider,
  FormControlLabel,
  Grid,
  Switch,
  TextField,
  Typography
} from '@mui/material';

export const AccountProfileDetails = ({ onDataChanged ,onValidationErrors}) => {
  const [values, setValues] = useState({
    name: '',
    description: '',
    price: 0,
    startDate: '',
    endDate: '',
    student_count: 0,
    type: 'offline',
    courseLocation: [
      {
        courseLocation_id: 0,
        schedule_Date: '',
        area: ''
      }
    ]
  });

  const [inputErrors, setInputErrors] = useState({
    name: '',
    description: '',
    price: '',
    startDate: '',
    endDate: '',
    schedule_Date: '', 
    area: '' 
  });


  // Hàm kiểm tra lỗi cho từng ô nhập liệu khi rời khỏi
  const validateInput = (name, value) => {
    switch (name) {
      case 'name':
        if (!value.trim()) {
          return 'Name cannot be empty';
        }
        break;
      case 'description':
        if (!value.trim()) {
          return 'Description cannot be empty';
        }
        break;
      case 'price':
        const priceNumber = parseFloat(value);
        if (isNaN(priceNumber) || priceNumber <= 0) {
          return 'Price must be a positive number';
        }
        break;
      case 'startDate':
        const currentDate = new Date();
        const tomorrow = new Date();
        tomorrow.setDate(currentDate.getDate() + 1); 
        const selectedStartDate = new Date(value);
        if (!value.trim()) {
          return 'Schedule Date cannot be empty';
        }
        if (selectedStartDate < currentDate && selectedStartDate < tomorrow) {
          return 'Start Date must be tomorrow or in the future';
        }
        break;
      case 'endDate':
        const selectedEndDate = new Date(value);
        const currentDate1 = new Date();
        if (!value.trim()) {
          return 'Schedule Date cannot be empty';
        }
        if (selectedEndDate <= currentDate1 || selectedEndDate <= new Date(values.startDate)) {
          return 'End Date must be tomorrow or in the future and after Start Date';
        }
        break;
        case 'schedule_Date':
          const selectedScheduleDate = new Date(value);
          const selectedStartDate1 = new Date(values.startDate);
          const selectedEndDate1 = new Date(values.endDate);
    
          if (!value.trim()) {
            return 'Schedule Date cannot be empty';
          }
    
          if (selectedScheduleDate < selectedStartDate1 || selectedScheduleDate > selectedEndDate1) {
            return 'Schedule Date must be within the range of Start Date and End Date';
          }
          break;
        case 'area':
          // Thêm điều kiện kiểm tra cho Area
          // Ví dụ: Area không được trống
          if (!value.trim()) {
            return 'Area cannot be empty';
          }
          // Thêm các điều kiện kiểm tra khác nếu cần
          break;
       
        
      default:
        break;
    }
  
    return '';
  };
  
  // Hàm xử lý sự kiện khi rời khỏi ô
  const handleInputBlur = useCallback((event) => {
    const { name, value } = event.target;
    const error = validateInput(name, value);
  
    setInputErrors((prevErrors) => ({
      ...prevErrors,
      [name]: error
    }));
    onValidationErrors({ [name]: error });
  }, [values, setInputErrors]);
 

  const handleInputChange = useCallback((event) => {
    const newValue = event.target.type === 'checkbox' ? event.target.checked : event.target.value;
    const name = event.target.name;
  
    if (name === 'price') {
      const newPrice = parseInt(newValue);
      setValues((prevState) => ({
        ...prevState,
        price: newPrice,
      }));
      onDataChanged({ ...values, price: newPrice }); // Send updated price
    } else if (name === 'type') {
      const updatedType = values.type === 'online' ? 'offline' : 'online';
      setValues((prevState) => ({
        ...prevState,
        type: updatedType,
      }));
      onDataChanged({ ...values, type: updatedType }); // Send updated type
    } else {
      setValues((prevState) => ({
        ...prevState,
        [name]: newValue,
      }));
      onDataChanged({ ...values, [name]: newValue }); // Send updated values for other fields
    }
  }, [values, onDataChanged]);
  
  const handleLocationInputChange = useCallback((event, index) => {
    const { name, value } = event.target;
  
    setValues((prevState) => {
      const newCourseLocation = [...prevState.courseLocation];
      newCourseLocation[index] = {
        ...newCourseLocation[index],
        [name]: value,
      };
  
      const newState = {
        ...prevState,
        courseLocation: newCourseLocation,
      };
  
      onDataChanged(newState);
      return newState;
    });
  }, [onDataChanged]);
  

  return (
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
                onBlur={handleInputBlur}
                helperText={inputErrors.name}
                error={Boolean(inputErrors.name)}
                onChange={handleInputChange}
                required
                value={values.name}
               
              />
            </Grid>
            <Grid item xs={12} md={6}>
              <TextField
                fullWidth
                label="Description"
                name="description"
                onBlur={handleInputBlur}
                error={Boolean(inputErrors.description)}
                helperText={inputErrors.description}
                onChange={handleInputChange}
                required
                value={values.description}
              />
            </Grid>
         
            <Grid item xs={12} md={6}>
              <TextField
                fullWidth
                label="Price"
                name="price"
                onBlur={handleInputBlur}
                error={Boolean(inputErrors.price)}

                helperText={inputErrors.price}
                onChange={handleInputChange}
                required
                type="number"
                value={values.price}
              />
            </Grid>
            <Grid item xs={12} md={6}>
              <TextField
                fullWidth
                label="Start Date"
                name="startDate"
                onBlur={handleInputBlur}
                error={Boolean(inputErrors.startDate)}

                helperText={inputErrors.startDate}
                onChange={handleInputChange}
                type="date"
                value={values.startDate}
                InputLabelProps={{ shrink: true }}
              />
            </Grid>
            <Grid item xs={12} md={6}>
              <TextField
                fullWidth
                label="End Date"
                name="endDate"
                onBlur={handleInputBlur}
                error={Boolean(inputErrors.endDate)}

                helperText={inputErrors.endDate}
                onChange={handleInputChange}
                type="date"
                value={values.endDate}
                InputLabelProps={{ shrink: true }}
              />
            </Grid>
          </Grid>
        </Box>
      </CardContent>
      <Divider />
     
        <CardContent sx={{ pt: 0 }}>
          <CardHeader subheader="Please input your address for offline workshop" />
          <Box sx={{ m: -1.5 }}>
            {
              values.courseLocation.map((location, index) => (
                <Grid container spacing={3} key={index}>
                  <Grid item xs={12} md={6}>
                    <TextField
                      fullWidth
                      label="Schedule Date"
                      name="schedule_Date"
                error={Boolean(inputErrors.schedule_Date)}

                      onBlur={handleInputBlur}
                      helperText={inputErrors.schedule_Date}
                      onChange={(event) => handleLocationInputChange(event, index)}
                      type="date"
                      value={location.schedule_Date}
                      InputLabelProps={{ shrink: true }}
                    />
                  </Grid>
                  <Grid item xs={12} md={6}>
                    <TextField
                      fullWidth
                      label="Area"
                      name="area"
                      error={Boolean(inputErrors.area)}

                      onBlur={handleInputBlur}
                      helperText={inputErrors.area}
                      onChange={(event) => handleLocationInputChange(event, index)}
                      value={location.area}
                    />
                  </Grid>
                </Grid>
              ))
            }

          </Box>
        </CardContent>
      
    </Card>
  );
};