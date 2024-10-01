
import Link from "next/link";
import styles from '../CSS/home.module.css';
import 'bootstrap/dist/css/bootstrap.min.css'; // Import CSS của Bootstrap
import Image from 'next/image';
import React, { useEffect, useState } from 'react';
import { useSession, signIn, signOut } from "next-auth/react";
import { useRouter } from 'next/navigation';
import { Link as ScrollLink, animateScroll as scroll } from 'react-scroll';

export default function Navbar() {
  const { data: session } = useSession();

  const NavLink = ({ text, target }: { text: string, target: string }) => (
    <li className={`${styles.navItem} nav-item mr-20`}>
      <ScrollLink
        activeClass="active"
        to={target}
        spy={true}
        smooth={true}
        offset={-70} // Điều chỉnh độ lệch khi cuộn đến phần đích
        duration={500}
        className={`${styles.navLink} nav-link text-dark font-roboto custom-bold`}
      >
        {text}
      </ScrollLink>
    </li>
  );
  const [dropdownVisible, setDropdownVisible] = useState(false);

  const toggleDropdown = () => {
    setDropdownVisible(!dropdownVisible);
  };
  const handleSignout = () => {
    signOut();
  };
  const renderUserMenu = () => {
    if (!session) {
      return (
        <Link href="/login" className={`${styles.gradientbutton} nav-link text-dark font-roboto custom-bold`}
          onClick={() => signIn("your-auth-provider")}>
          Sign In</Link>
      );
    } else {
      let profileLink = "/user/ui-components/forms"; // Mặc định là role "user"

      // Kiểm tra và cập nhật đường dẫn dựa trên vai trò của người dùng
      if (session.user.roles == 'SELLER') {
        profileLink = "/teacher/ui-components/buttons";
      } else if (session.user.roles == 'ADMIN') {
        profileLink = "/admin";
      }
      return (
        <div onClick={() => {
          toggleDropdown();
        }} className={`${styles.gradientbutton} user-menu`}>
          <img
            width="30"
            height="30"
            className={styles.roundedCircle}
            src={session.user.image || session.user.picture}
          />
          {dropdownVisible && (
            <div className={`dropdownMenu ${dropdownVisible ? 'visible' : ''}`}>
              <div className={styles.dropDown}>
                <label tabIndex={0} className="btn btn-active text-white btn-circle">
                  <svg xmlns="http://www.w3.org/2000/svg" className="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor"><path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M4 6h16M4 12h16M4 18h7" /></svg>
                </label>
                <ul tabIndex={0} className={`${styles.dropdownCustom} menu menu-compact dropdown-content p-2 shadow text-black bg-gray-50 rounded-box w-52`}>
                  <li  >
                    <Link className={styles.LinkDropDown} href={profileLink}>Profile</Link>
                  </li>
                  <li><Link href="" className={styles.LinkDropDown} onClick={handleSignout}>Log Out</Link></li>
                </ul>
              </div>

            </div>
          )}
        </div>
      );
    }
  };
  useEffect(() => {
    if (typeof document !== 'undefined') {
      const nav = document.querySelector('nav');

      if (nav !== null) {
        const handleScroll = () => {
          if (window.pageYOffset > 100) {
            nav.style.backgroundColor = 'rgba(255, 255, 255, 0.8)';
            nav.classList.add('shadow');
          } else {
            nav.style.backgroundColor = 'transparent';
            nav.classList.remove('shadow');
          }
        };

        window.addEventListener('scroll', handleScroll);

        return () => {
          window.removeEventListener('scroll', handleScroll);
        };
      }
    }
  }, []);

  return (
    <nav className={styles.navbar}>
      <nav className="navbar fixed-top navbar-expand-lg navbar-dark p-md-3 transparent-navbar">
        <div className={`${styles.logoContainer} container`} >
          <Link href="/" className="navbar-brand mx-auto">
            <Image src="/logo.png" alt="Chain App Dev" width={100} height={80} />
          </Link>
        </div>
        <div className="collapse navbar-collapse" id="navbarNav">
          <div className="container-fluid ml-auto mr-0">
            <ul className="navbar-nav">
              <NavLink text="Home" target="banner" />
              <NavLink text="About" target="about" />
              <NavLink text="Review" target="review" />
              <NavLink text="Workshops " target="workshops" />
              <NavLink text="Contact" target="contact" />
              {/* <li>
                <div className="nav-item gradient-button">
                  {session ? (
                    <UserLoggedIn session={session} signOut={signOut} />
                  ) : (
                    <UserNotLoggedIn signIn={signIn} />
                  )}
                </div>
              </li> */}
              <div className="user-section">{renderUserMenu()}</div>

            </ul>
          </div>
        </div>
      </nav>
    </nav>
  );
}
