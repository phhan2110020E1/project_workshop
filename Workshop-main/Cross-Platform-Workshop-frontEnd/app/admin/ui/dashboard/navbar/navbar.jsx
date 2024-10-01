"use client";
import { usePathname } from "next/navigation";
import styles from "./navbar.module.css";
import { useSession, signIn, signOut } from "next-auth/react";
import {
  MdNotifications,
  MdOutlineChat,
  MdPublic,
  MdSearch,
  MdLogout,
} from "react-icons/md";

const Navbar = () => {
  const { data: session } = useSession();
  const pathname = usePathname();

  return (
    <div className={styles.container}>
      <div className={styles.title}>{pathname.split("/").pop()}</div>
      <div className={styles.menu}>


      </div>
    </div>
  );
};

export default Navbar;
