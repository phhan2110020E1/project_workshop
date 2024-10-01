import Image from 'next/image';
import Link from "next/link";
import styles from '../CSS/home.module.css';
import React from 'react';
import 'bootstrap/dist/css/bootstrap.min.css';
const About = () => {
    return (
        <div id="about" className={`${styles.aboutUs}section`}>
            <div className="container">
                <div className="row">
                    <div className="col-lg-6 align-self-center">

                        <div className={`${styles.sectionHeadingService} wow fadeInDown`} data-wow-duration="1s" data-wow-delay="0.5s">
                            <h4>
                                About <em className={styles.emm}>What We Do</em> &amp; Who We Are
                            </h4>
                            <Image src="/heading-line-dec.png" alt="" width={45} height={2} />
                            <p className={styles.pText}>
                                Unlock your creativity with our engaging workshops. Whether you're a beginner or an experienced artist, there's something for everyone.
                            </p>
                        </div>
                        <div className="row">
                            <div className="col-lg-6">
                                <div className={`${styles.boxItem} box-item`}>
                                    <h4><a href="#">Playful Puppets</a></h4>
                                    <p>Create and animate puppets, fostering storytelling and creativity.</p>
                                </div>
                            </div>
                            <div className="col-lg-6">
                                <div className={`${styles.boxItem} box-item`}>                  
                                 <h4><a href="#">Time Capsule Making</a></h4>
                                    <p>Encourage kids to think about the future by creating time capsules with various creative elements.</p>
                                </div>
                            </div>
                            <div className="col-lg-6">
                                <div className={`${styles.boxItem} box-item`}>                  <h4><a href="#">Drawing and Painting</a></h4>
                                    <p>Express yourself through art and enhance your fine motor skills.</p>
                                </div>
                            </div>
                            <div className="col-lg-6">
                                <div className={`${styles.boxItem} box-item`}>                  <h4><a href="#">Imagination Clay</a></h4>
                                    <p>Mold, shape, and sculpt unique creations from soft, pliable clay.</p>
                                </div>
                            </div>
                            <div className="col-lg-12">
                                <p className={styles.pText}>
                                    Discover new skills, make friends, and let your creativity flow. Join our workshops now!
                                </p>
                                <div className="gradient-button">
                                    <Link className={styles.gradientbutton} id="modal_trigger" href="#modal">Explore Workshops</Link>

                                </div>
                                <span className={styles.pText}>*No Experience Required</span>
                            </div>
                        </div>
                    </div>
                    <div className="col-lg-6">
                        <div className="right-image">
                            <Image src="/about-right-dec.png" alt="" width={630} height={782} />
                        </div>
                    </div>
                </div>
            </div>
        </div>
    );
};

export default About;
