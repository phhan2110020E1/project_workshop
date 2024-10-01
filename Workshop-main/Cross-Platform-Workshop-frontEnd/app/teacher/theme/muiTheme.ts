import { createTheme } from '@mui/material/styles';

const theme = createTheme({
  breakpoints: {
    values: {
      xs: 0,
      sm: 600,
      md: 960,
      lg: 1280,
      xl: 1920,
    },
    // Các tùy chọn khác của breakpoints...
  },
  // Các tùy chọn khác của chủ đề...
});

export default theme;