import NextLink from "next/link";
import { styled } from "@mui/material/styles"
import NextImage from "next/image";

const LogoImage = styled(NextImage)(() => ({
  height: "100px",
  width: "60px",
}));

const LogoLink = styled(NextLink)(() => ({
  height: "100px",
  width: "96px",
  overflow: "hidden",
  display: "block",
}));

const Logo = () => {
  return (
    <LogoLink href="/">
      <LogoImage src="/logo.png" alt="logo" layout="responsive" width={50} height={37} />
    </LogoLink>
  );
};

export default Logo;
