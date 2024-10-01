import Image from 'next/image';
import Link from "next/link";
import styles from '../CSS/home.module.css';
import React from 'react';
import 'bootstrap/dist/css/bootstrap.min.css';
function Footer() {
  return (
  <div id="contact">
    <footer id="newsletter" className={styles.footer}>
      <div className="container">
        <div className="row">
          <div className="col-lg-8 offset-lg-2">
            <div className={styles.sectionHeading}>
              <h4>Join our mailing list to receive the news & latest trends</h4>
            </div>
          </div>
          <div className="col-lg-6 offset-lg-3">
            <form  className={styles.search} id="search" action="#" method="GET">
            </form>
          </div>
        </div>
        <div className="row">
          <div className="col-lg-3">
            <div className={styles.footerWidget}>
              <h4>About Us</h4>
              <ul>
                <li><Link className={styles.aCustom} href="#">Home</Link></li>
                <li><Link className={styles.aCustom} href="#">About</Link></li>
                <li><Link className={styles.aCustom} href="#">Review</Link></li>
                <li><Link className={styles.aCustom} href="#">Workshops</Link></li>
                <li><Link className={styles.aCustom} href="#">Contact</Link></li>
              </ul>
            </div>
          </div>
          <div className="col-lg-6"></div>
          <div className="col-lg-3">
            <div className={styles.footerWidget}>
              <h4>About Our Workshop</h4>
              <div className="logo">
                <Image src="/logo.png" alt="Company Logo" width={100} height={80} />
              </div>
              <p>
              Discover the boundless realm of knowledge and creativity at Workshop Infinity Connect! We take pride in being the nexus between eager learners and top-notch experts across various fields. With our diverse range of courses and a professional faculty, we commit to providing you with a unique and sustainable learning experience.</p>
            </div>
          </div>
          <div className="col-lg-12">
            <div className={styles.copyrightText}>
              <p>Copyright © 2022 Workshop Dev By Team 04. All Rights Reserved.
                {/* <br />Design: <Link className={styles.aCustom} href="https://templatemo.com/" target="_blank" title="css templates">TemplateMo</Link> */}
              </p>
            </div>
          </div>
        </div>
      </div>
    </footer>
    </div>

  );
}

export default Footer;
