import React, { useState } from "react";
import { useTheme } from "@mui/material/styles";
import { signOut } from "next-auth/react";
import Link from "next/link";
import {
  Box,
  Menu,
  Avatar,
  Typography,
  Divider,
  Button,
  IconButton,
  ListItemButton,
  List,
  ListItemText,
} from "@mui/material";

import { Stack } from "@mui/system";
import {
  IconChevronDown,
  IconCreditCard,
  IconCurrencyDollar,
  IconMail,
  IconShield,
} from "@tabler/icons-react";
import { useSession } from "next-auth/react";

const Profile = () => {
  const [anchorEl2, setAnchorEl2] = useState(null);
  const handleClick2 = (event: any) => {
    setAnchorEl2(event.currentTarget);
  };
  const handleClose2 = () => {
    setAnchorEl2(null);
  };
  const handleSignout = () => {
    signOut();
  };
  const { data: session } = useSession();
  const userAvatar = session?.user?.image; // Đường dẫn hình ảnh người dùng
  const userName = session?.user?.user_name; // Tên người dùng 
  // console.log(session);
  
  const theme = useTheme();

  return (
    <Box>
      <IconButton
        size="large"
        aria-label="menu"
        color="inherit"
        aria-controls="msgs-menu"
        aria-haspopup="true"
        sx={{
          ...(typeof anchorEl2 === "object" && {
            borderRadius: "9px",
          }),
        }}
        onClick={handleClick2}
      >
        <Avatar
          src={userAvatar}
          alt={"ProfileImg"}
          sx={{
            width: 30,
            height: 30,
          }}
        />
        <Box
          sx={{
            display: {
              xs: "none",
              sm: "flex",
            },
            alignItems: "center",
          }}
        >
          <Typography
            color="textSecondary"
            variant="h5"
            fontWeight="400"
            sx={{ ml: 1 }}
          >
            Hi,
          </Typography>
          <Typography
            variant="h5"
            fontWeight="700"
            sx={{
              ml: 1,
            }}
          >
          {userName}
          </Typography>
          <IconChevronDown width="20" height="20" />
        </Box>
      </IconButton>
      {/* ------------------------------------------- */}
      {/* Message Dropdown */}
      {/* ------------------------------------------- */}
      <Menu
        id="msgs-menu"
        anchorEl={anchorEl2}
        keepMounted
        open={Boolean(anchorEl2)}
        onClose={handleClose2}
        anchorOrigin={{ horizontal: "right", vertical: "bottom" }}
        transformOrigin={{ horizontal: "right", vertical: "top" }}
        sx={{
          "& .MuiMenu-paper": {
            width: "360px",
            p: 2,
            pb: 2,
            pt:0
          },
        }}
      >

        <Box pt={0}>

          <List>
            <ListItemButton component="a" href="/user/ui-components/forms">
              <ListItemText primary="Profile" />
            </ListItemButton>
            <ListItemButton component="a" href="/user/ui-components/changepass">
              <ListItemText primary="Change Password" />
            </ListItemButton>
          </List>

        </Box>
        <Divider />
        <Box mt={2}>
          <Button  onClick={handleSignout}  fullWidth variant="contained"style={{ backgroundColor: "#4b8ef1" }} color="primary">
            Logout
          </Button>
        </Box>

      </Menu>
    </Box>
  );
};

export default Profile;
