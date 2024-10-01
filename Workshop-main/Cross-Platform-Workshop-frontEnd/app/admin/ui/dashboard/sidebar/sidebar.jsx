'use client'
import Image from "next/image";
import MenuLink from "./menuLink/menuLink";
import styles from "./sidebar.module.css";
import { useSession, signIn, signOut } from "next-auth/react";
import { SiGoogleclassroom } from "react-icons/si";
import * as React from 'react';

import {
  MdDashboard,
  MdSupervisedUserCircle,
  MdShoppingBag,
  MdAttachMoney,
  MdWork,
  MdAnalytics,
  MdPeople,
  MdOutlineSettings,
  MdPerson,
  MdLogout,
  MdRequestQuote,
  MdOutlineRateReview  
} from "react-icons/md";
import Link from "next/link";

const menuItems = [
  {
    title: "Pages",
    list: [
      {
        title: "Dashboard",
        path: "/admin/dashboard",
        icon: <MdDashboard />,
      },
      {
        title: "Profile",
        path: "/admin/profile",
        icon: <MdPerson/>,
      },
      {
        title: "Users",
        path: "/admin/dashboard/users",
        icon: <MdSupervisedUserCircle />,
      },
      {
        title: "Workshop",
        path: "/admin/dashboard/workshop",
        icon: <SiGoogleclassroom />,
      },
      {
        title: "Request",
        path: "/admin/dashboard/request",
        icon: <MdRequestQuote />,
      },
      {
        title: "Transaction",
        path: "/admin/dashboard/transaction",
        icon: <MdAttachMoney />,
      },
      {
        title: "Rating & Comment",
        path: "/admin/dashboard/rating&comment",
        icon: <MdOutlineRateReview />,
      },
    ],
  },
];

const Sidebar = () => {
  const { data: session } = useSession();
  console.log(session?.user);




  return (
    <div className={styles.container}>
      <div className={styles.user}>
        <Image
          className={styles.userImage}
          src={session?.user?.image || session?.user?.picture || "/noavatar.png"}
          alt=""
          width="50"
          height="50"
        />
        <div className={styles.userDetail}>
          <span className={styles.username}>{session?.user?.full_name}</span>
          <span className={styles.userTitle}>Administrator</span>
        </div>
      </div>
      <ul className={styles.list}>
        {menuItems.map((cat) => (
          <li key={cat.title}>
            <span className={styles.cat}>{cat.title}</span>
            {cat.list.map((item) => (
              <MenuLink item={item} key={item.title} />
            ))}
          </li>
        ))}
      </ul>
      <button className={styles.logout} onClick={() => session ? signOut() : signIn()}>
        <MdLogout />
        Logout
      </button>
    </div>
  );
};

export default Sidebar;
