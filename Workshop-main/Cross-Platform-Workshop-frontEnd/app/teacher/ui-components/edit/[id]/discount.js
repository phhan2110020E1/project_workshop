import { useState, useEffect } from 'react';
import {
  Button,
  Card,
  CardContent,
  CardHeader,
  Divider,
  Grid,
  TextField,
} from '@mui/material';
import PropTypes from 'prop-types';
export const DiscountDTOS = ({ onDataChanged,formData}) => {
  const [discountData, setDiscountData] = useState({
    discountDTOS: [
      {
        name: '',
        description: '',
        quantity: 0,
        valueDiscount: 0,
        remainingUses: 0,
        redemptionDate: new Date(),
      },
    ],
  });
  useEffect(() => {
    if (formData && formData.length > 0 && formData[0].discountDTOS && formData[0].discountDTOS.length > 0) {
      const {
        name,
        description,
        quantity,
        valueDiscount,
        remainingUses,
        redemptionDate,
      } = formData[0].discountDTOS[0];
      const formattedDate = redemptionDate
        ? new Date(redemptionDate).toISOString().substring(0, 16) // For "yyyy-MM-ddThh:mm"
        : '';
  
      setDiscountData({
        discountDTOS: [
          {
            name: name || '',
            description: description || '',
            quantity: quantity || 0,
            valueDiscount: valueDiscount || 0,
            remainingUses: remainingUses || 0,
            redemptionDate: formattedDate || '',
          },
        ],
      });
    }
  }, [formData]);

  const handleInputChange = (e) => {
    const { name, value } = e.target;
    const newData = {
      discountDTOS: [
        {
          ...discountData.discountDTOS[0],
          [name]: value,
        },
      ],
    };
    setDiscountData(newData);
    onDataChanged({
      ...formData[0], // assuming formData is an array with only one object
      discountDTOS: [
        {
          ...formData[0]?.discountDTOS[0],
          [name]: value,
        },
      ],
    });
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
              onChange={handleInputChange}
              value={discountData.discountDTOS[0].name}
              variant="outlined"
            />
          </Grid>
          <Grid item xs={12}>
            <TextField
              fullWidth
              label="Description"
              name="description"
              onChange={handleInputChange}
              value={discountData.discountDTOS[0].description}
              variant="outlined"
            />
          </Grid>
          <Grid item xs={6}>
            <TextField
              fullWidth
              label="Quantity"
              name="quantity"
              onChange={handleInputChange}
              value={discountData.discountDTOS[0].quantity}
              type="number"
              variant="outlined"
            />
          </Grid>
          <Grid item xs={6}>
            <TextField
              fullWidth
              label="Value Discount"
              name="valueDiscount"
              onChange={handleInputChange}
              value={discountData.discountDTOS[0].valueDiscount}
              type="number"
              variant="outlined"
            />
          </Grid>
          <Grid item xs={6}>
            <TextField
              fullWidth
              label="Remaining Uses"
              name="remainingUses"
              onChange={handleInputChange}
              value={discountData.discountDTOS[0].remainingUses}
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
              onChange={handleInputChange}
              value={discountData.discountDTOS[0].redemptionDate}
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
DiscountDTOS.propTypes = {
  onDataChanged: PropTypes.func.isRequired,
  existingData: PropTypes.object,
  formData: PropTypes.object, // You can add this prop type if needed
}; 
DiscountDTOS.defaultProps = {
  existingData: null,
  formData: null,
};