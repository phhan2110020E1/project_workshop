'use client';
import React, { useCallback, useState,useEffect } from 'react';
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
  Typography,
  Button
} from '@mui/material';
import PropTypes from 'prop-types';


export const AccountProfileDetails = ({ onDataChanged, formData }) => {

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
  AccountProfileDetails.propTypes = {
    onDataChanged: PropTypes.func.isRequired,
    formData: PropTypes.shape({
      // Define the expected structure of formData
      id: PropTypes.number,
      courseName: PropTypes.string,
      // ... other properties
    }).isRequired,
  };


  const handleInputChange = useCallback((event) => {
    const newValue = event.target.type === 'checkbox' ? event.target.checked : event.target.value;
    const name = event.target.name;
  
    setValues((prevValues) => {
      let updatedValues;
      if (name === 'price') {
        const newPrice = parseInt(newValue);
        updatedValues = { ...prevValues, price: newPrice };
      } else if (name === 'type') {
        const updatedType = prevValues.type === 'online' ? 'offline' : 'online';
        updatedValues = { ...prevValues, type: updatedType };
      } else {
        updatedValues = { ...prevValues, [name]: newValue };
      }
  
      onDataChanged(updatedValues);
      console.log('updatedValues',updatedValues);

      return updatedValues;

    });
  }, [onDataChanged]);
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

  

  useEffect(() => {
    if (formData && formData.length > 0) {
      const startFormattedDate = formData[0]?.startDate
        ? new Date(formData[0]?.startDate).toISOString().split('T')[0]
        : '';
  
      const endFormattedDate = formData[0]?.endDate
        ? new Date(formData[0]?.endDate).toISOString().split('T')[0]
        : '';
  
        setValues((prevValues) => ({
          ...prevValues,
          name: formData[0]?.name || 'ada',
          description: formData[0]?.description || '',
          price: formData[0]?.price || 0,
          startDate: startFormattedDate,
          endDate: endFormattedDate,
          student_count: formData[0]?.studentCount || 0,
          type: formData[0]?.type || 'offline',
          schedule_Date: formData[0]?.courseLocations[0]?.schedule_Date
            ? new Date(formData[0]?.courseLocations[0]?.schedule_Date).toISOString().split('T')[0]
            : '',
          area: formData[0]?.courseLocations[0]?.area || '',
        }));
      }
    }, [formData]);
  
  
  const handleEdit = (index) => {
    setEditingIndex(index);
    // Nếu muốn hiển thị thông tin cũ trong chế độ chỉnh sửa, có thể làm điều này ở đây
  };

  const handleSave = () => {
    // Xử lý lưu thông tin chỉnh sửa
    setEditingIndex(-1);
  };

  return (
    <Card>
    <CardHeader subheader="The information can be edited" title="Profile" />
    <CardContent sx={{ pt: 0 }}>
      <Box sx={{ m: -1.5 }}>
        <Grid container spacing={3}>
          <Grid item xs={12} md={6}>
            <TextField
              fullWidth
              label="Workshop name"
              name="name"
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
              onChange={handleInputChange}
              required
              value={values.description}
            />
          </Grid>
          <Grid item xs={12} md={6}>
            <Typography variant="body1">Workshop Type</Typography>
            <FormControlLabel
              control={
                <Switch
                  checked={values.type === 'online'}
                  onChange={() =>
                    setValues((prevState) => ({
                      ...prevState,
                      type: prevState.type === 'online' ? 'offline' : 'online',
                    }))
                  }
                  name="type"
                  color="primary"
                />
              }
              label={values.type === 'online' ? 'Online' : 'Offline'}
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
              value={values.price}
            />
          </Grid>
          <Grid item xs={12} md={6}>
            <TextField
              fullWidth
              label="Start Date"
              name="startDate"
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
    {/* {values.type === 'offline' && ( 
      <CardContent sx={{ pt: 0 }}>
        <CardHeader subheader="Please input your address for offline workshop" />
        <Box sx={{ m: -1.5 }}>
          {
            // values.courseLocation.map((location, index) => (
              // <Grid container spacing={3} key={index}>
              {values.courseLocation.map((location, index) => (
                <Grid container spacing={3} key={index}>
                <Grid item xs={12} md={6}>
                  <TextField
                    fullWidth
                    label="Schedule Date"
                    name="schedule_Date"
                    onChange={(event) => handleLocationInputChange(event, 0)}
                    type="date"
                    value={location.schedule_Date}

                  />
                </Grid>
                <Grid item xs={12} md={6}>
                  <TextField
                    fullWidth
                    label="Area"
                    name="area"
                    onChange={(event) => handleLocationInputChange(event, 0)}
                    value={location.area}
                  />
                </Grid>
              </Grid>
            ))
          }
        }
        </Box>
      </CardContent>
    )} */}
    {values.type === 'offline' && ( 
  <CardContent sx={{ pt: 0 }}>
    <CardHeader subheader="Please input your address for offline workshop" />
    <Box sx={{ m: -1.5 }}>
      {values.courseLocation.map((location, index) => (
        <Grid container spacing={3} key={index}>
          <Grid item xs={12} md={6}>
            <TextField
              fullWidth
              label="Schedule Date"
              name="schedule_Date"
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
              onChange={(event) => handleLocationInputChange(event, index)}
              value={location.area}
            />
          </Grid>
        </Grid>
      ))}
    </Box>
  </CardContent>
)}

  </Card>
  );
};