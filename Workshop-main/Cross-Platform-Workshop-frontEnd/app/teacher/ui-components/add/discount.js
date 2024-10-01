import { useCallback, useState } from 'react';
import {
  Button,
  Card,
  CardContent,
  CardHeader,
  Divider,
  Grid,
  TextField,
} from '@mui/material';
import { values } from 'lodash';

export const DiscountDTOS = ({ onDataChanged ,onValidationErrors,startDate, endDate }) => {
  
  const [discountData, setDiscountData] = useState({
    discountDTOS: [
      {
        name: '',
        description: '',
        quantity: 0,
        valueDiscount: 0,
        redemptionDate: '',
      }]
  });
  const [inputErrors, setInputErrors] = useState({
    name: '',
    description: '',
    quantity: '',
    valueDiscount: '',
    redemptionDate: '',
  });

  const handleInputBlur = useCallback((event) => {
    const { name, value } = event.target;
    const error = validateInput(name, value);
  
    setInputErrors((prevErrors) => ({
      ...prevErrors,
      [name]: error
      
    }));
    onValidationErrors({ [name]: error });
  }, [discountData, setInputErrors]);
  const validateInput = (name, value) => {
    switch (name) {
      case 'name':
        if (!value.trim()) {
          return 'Discount Name cannot be empty';
        }
        break;
      case 'description':
        if (!value.trim()) {
          return 'Description cannot be empty';
        }
        break;
      case 'quantity':
        const quantityNumber = parseInt(value);
        if (isNaN(quantityNumber) || quantityNumber < 0) {
          return 'Quantity must be a non-negative number';
        }
        break;
      case 'valueDiscount':
        const valueDiscountNumber = parseFloat(value);
        if (isNaN(valueDiscountNumber) || valueDiscountNumber < 0) {
          return 'Value Discount must be a non-negative number';
        }
        break;
   
      case 'redemptionDate':
        if (!value.trim()) {
          return 'Schedule Date cannot be empty';
        }
        const selectedRedemptionDate = new Date(value);
        const startDateTime = new Date(startDate);
        const endDateTime = new Date(endDate);
  
        if (selectedRedemptionDate < startDateTime || selectedRedemptionDate > endDateTime) {
          return 'Redemption Date must be within the range of Start Date and End Date';
        }
      break;
      default:
        break;
    }

    return '';
  };
  const handleInputChange = (e) => {
    const { name, value } = e.target;
    const newData = {
      discountDTOS: [
        {
          ...discountData.discountDTOS[0], // Assuming there is only one object in the array
          [name]: value,
        },
      ],
    };
    setDiscountData(newData);
    const error = validateInput(name, value);
    setInputErrors((prevErrors) => ({
      ...prevErrors,
      [name]: error,
    }));

    onDataChanged(newData);
  };
  return (
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
              error={Boolean(inputErrors.name)}
              onBlur={handleInputBlur}
              helperText={inputErrors.name}
              onChange={handleInputChange}
              value={discountData.name}
              variant="outlined"
            />
          </Grid>
          <Grid item xs={12}>
            <TextField
              fullWidth
              label="Description"
              name="description"
              error={Boolean(inputErrors.description)}
              onBlur={handleInputBlur}
              helperText={inputErrors.description}
              onChange={handleInputChange}
              value={discountData.description}
              variant="outlined"
            />
          </Grid>
          <Grid item xs={6}>
            <TextField
              fullWidth
              label="Quantity"
              name="quantity"
              error={Boolean(inputErrors.quantity)}
              onBlur={handleInputBlur}
              helperText={inputErrors.quantity}
              onChange={handleInputChange}
              value={discountData.quantity}
              type="number"
              variant="outlined"
            />
          </Grid>
          <Grid item xs={6}>
            <TextField
              fullWidth
              label="Value Discount"
              name="valueDiscount"
              error={Boolean(inputErrors.valueDiscount)}
              onBlur={handleInputBlur}
              helperText={inputErrors.valueDiscount}
              onChange={handleInputChange}
              value={discountData.valueDiscount}
              type="number"
              variant="outlined"
            />
          </Grid>
     
          <Grid item xs={6}>
            <TextField
              fullWidth
              label="Redemption Date"
              name="redemptionDate"
              type="datetime-local"
              error={Boolean(inputErrors.redemptionDate)}
              onBlur={handleInputBlur}
              helperText={inputErrors.redemptionDate}
              onChange={handleInputChange}
              value={discountData.redemptionDate}
              variant="outlined"
              InputLabelProps={{ shrink: true }}
            />
          </Grid>
        </Grid>
      </CardContent>
      <Divider />

    </Card>
  );
};