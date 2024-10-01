'use client';
import {Grid, Box,} from '@mui/material';
import PageContainer from '@/app/user/components/container/PageContainer';
import BaseCard from '@/app/user/components/shared/BaseCard';
import { Carousel } from "react-responsive-carousel";
import Skeleton from "react-loading-skeleton";
import React, { useEffect, useState } from "react";
import "react-responsive-carousel/lib/styles/carousel.min.css";
import 'bootstrap/dist/css/bootstrap.min.css';
import Image from 'next/image';
import styles from '../buttons/button.module.css';
import pic1 from "../../public/images/course/workshop.png";
import pic2 from "../../public/images/course/wokshop2.png";
import pic3 from "../../public/images/course/workshop4.png";
import Card_temp_1 from './card_term'
import Card_temp_2 from './card_term2';
function ShopCarousel() {
    const [loading, setLoading] = useState(true);

    useEffect(() => {
        setTimeout(() => setLoading(false), 1000);
    }, []);

    if (loading) return <Skeleton className="h-24 md:h-64" />;
}
const Buttons = () => {
    const carouselItems = [1, 2, 3];
    return (

        <PageContainer title="button" description="this is button">
            <Carousel
                autoPlay
                infiniteLoop
                showStatus={false}
                showArrows={false}
                showThumbs={false}
                swipeable={true}
                transitionTime={500}
                interval={4000}
                className="rounded-2xl overflow-hidden shop shadow-lg"
            >
                <div className="relative">
                    <Image
                        src={pic1}
                        height={400}
                        alt="Course Carousel"
                    />
                </div>
                <div>
                    <Image
                        height={400}
                        src={pic2}
                        alt="Course Carousel"
                    />
                </div>
                <div>
                    <Image
                        height={400}
                        src={pic3}
                        alt="Course Carousel"
                    />
                </div>
            </Carousel>
            <Grid style={{ paddingTop: '50px' }} container spacing={3}>

                <BaseCard title="Free Course" >
                    <Box sx={{ "& button": { mr: 1 } }}>
                        <div id="carouselExampleCaptions" className="carousel carousel-dark slide" data-bs-ride="carousel">
                            <div className={styles.indicartorsCustom}>
                                <button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="0" className="active"
                                    aria-current="true" aria-label="Slide 1"></button>
                                <button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="1"
                                    aria-label="Slide 2"></button>
                                <button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="2"
                                    aria-label="Slide 3"></button>
                            </div>
                            <div className="carousel-inner">
                                <div className="carousel-item active">
                                    <div className={`${styles.cardGroup} card-group`}>
                                        <div className={`${styles.cardCustom} card`}>
                                            <div className={`${styles.cardBody} card-body`}>
                                                <Card_temp_1 />
                                            </div>
                                        </div>
                                        <div className={`${styles.cardCustom} card`}>
                                            <div className={`${styles.cardBody} card-body`}>

                                                <Card_temp_1 />
                                            </div>
                                        </div>
                                        <div className={`${styles.cardCustom} card`}>
                                            <div className={`${styles.cardBody} card-body`}>
                                                <Card_temp_1 />
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div className="carousel-item">
                                <div className={`${styles.cardGroup} card-group`}>
                                    <div className={`${styles.cardCustom} card`}>
                                        <div className={`${styles.cardBody} card-body`}>
                                            <Card_temp_1 />
                                        </div>
                                    </div>
                                    <div className={`${styles.cardCustom} card`}>
                                        <div className={`${styles.cardBody} card-body`}>
                                            <Card_temp_1 />
                                        </div>
                                    </div>
                                    <div className={`${styles.cardCustom} card`}>
                                        <div className={`${styles.cardBody} card-body`}>
                                            <Card_temp_1 />
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div className="carousel-item">
                                <div className={`${styles.cardGroup} card-group`}>
                                    <div className={`${styles.cardCustom} card`}>
                                        <div className={`${styles.cardBody} card-body`}>
                                            <Card_temp_1 />
                                        </div>
                                    </div>
                                    <div className={`${styles.cardCustom} card`}>
                                        <div className={`${styles.cardBody} card-body`}>
                                            <Card_temp_1 />
                                        </div>
                                    </div>
                                    <div className={`${styles.cardCustom} card`}>
                                        <div className={`${styles.cardBody} card-body`}>
                                            <Card_temp_1 />
                                        </div>
                                    </div>
                                </div>
                            </div>

                        </div>
                        <button className="carousel-control-prev" type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide="prev">
                            <span className="carousel-control-prev-icon" aria-hidden="true"></span>
                            <span className="visually-hidden">Previous</span>
                        </button>
                        <button className="carousel-control-next" type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide="next">
                            <span className="carousel-control-next-icon" aria-hidden="true"></span>
                            <span className="visually-hidden">Next</span>
                        </button>
                    </Box>
                </BaseCard>

                {/* <Grid item xs={12} lg={6}>
                    <BaseCard title="Outline Buttons">
                        <Box sx={{ "& button": { mr: 1 } }}>
                            Các nút nổi bật
                        </Box>
                    </BaseCard>
                </Grid>
                <Grid item xs={12} lg={6}>
                    <BaseCard title="Size Buttons">
                        <Box sx={{ "& button": { mx: 1 } }}>
                            Các nút kích thước
                        </Box>
                    </BaseCard>
                </Grid>
                <Grid item xs={12} lg={6}>
                    <BaseCard title="Icon Buttons">
                        <Stack spacing={2} direction="row">
                            Các nút biểu tượng
                        </Stack>
                    </BaseCard>
                </Grid>
                <Grid item xs={12} lg={6}>
                    <BaseCard title="Fab Buttons">
                        <Stack spacing={2} direction="row">
                            Các nút Fab
                        </Stack>
                    </BaseCard>
                </Grid>
                <Grid item xs={12} lg={6}>
                    <BaseCard title="Group Buttons">
                        <ButtonGroup variant="contained" aria-label="outlined primary button group">
                            <Button>One</Button>
                            <Button>Two</Button>
                            <Button>Three</Button>
                        </ButtonGroup>
                    </BaseCard>
                </Grid>
                <Grid item xs={12} lg={6}>
                    <BaseCard title="Group Outline Buttons">
                        <ButtonGroup variant="outlined" aria-label="outlined button group">
                            <Button>One</Button>
                            <Button>Two</Button>
                            <Button>Three</Button>
                        </ButtonGroup>
                    </BaseCard>
                </Grid> */}
            </Grid>


            <Grid style={{ paddingTop: '50px' }} container spacing={3}>

                <BaseCard title="Advanced Course" >
                    <Box sx={{ "& button": { mr: 1 } }}>
                        <div id="carouselExampleCaptions" className="carousel carousel-dark slide" data-bs-ride="carousel">
                            <div className={styles.indicartorsCustom}>
                                <button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="0" className="active"
                                    aria-current="true" aria-label="Slide 1"></button>
                                <button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="1"
                                    aria-label="Slide 2"></button>
                                <button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="2"
                                    aria-label="Slide 3"></button>
                            </div>
                            <div className="carousel-inner">
                                <div className="carousel-item active">
                                    <div className={`${styles.cardGroup} card-group`}>
                                        <div className={`${styles.cardCustom} card`}>
                                            <div className={`${styles.cardBody} card-body`}>
                                                <Card_temp_2 />
                                            </div>
                                        </div>
                                        <div className={`${styles.cardCustom} card`}>
                                            <div className={`${styles.cardBody} card-body`}>

                                                <Card_temp_2 />
                                            </div>
                                        </div>
                                        <div className={`${styles.cardCustom} card`}>
                                            <div className={`${styles.cardBody} card-body`}>
                                                <Card_temp_2 />
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div className="carousel-item">
                                <div className={`${styles.cardGroup} card-group`}>
                                    <div className={`${styles.cardCustom} card`}>
                                        <div className={`${styles.cardBody} card-body`}>
                                            <Card_temp_2 />
                                        </div>
                                    </div>
                                    <div className={`${styles.cardCustom} card`}>
                                        <div className={`${styles.cardBody} card-body`}>
                                            <Card_temp_2 />
                                        </div>
                                    </div>
                                    <div className={`${styles.cardCustom} card`}>
                                        <div className={`${styles.cardBody} card-body`}>
                                            <Card_temp_2 />
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div className="carousel-item">
                                <div className={`${styles.cardGroup} card-group`}>
                                    <div className={`${styles.cardCustom} card`}>
                                        <div className={`${styles.cardBody} card-body`}>
                                            <Card_temp_2 />
                                        </div>
                                    </div>
                                    <div className={`${styles.cardCustom} card`}>
                                        <div className={`${styles.cardBody} card-body`}>
                                            <Card_temp_2 />
                                        </div>
                                    </div>
                                    <div className={`${styles.cardCustom} card`}>
                                        <div className={`${styles.cardBody} card-body`}>
                                            <Card_temp_2 />
                                        </div>
                                    </div>
                                </div>
                            </div>

                        </div>
                        <button className="carousel-control-prev" type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide="prev">
                            <span className="carousel-control-prev-icon" aria-hidden="true"></span>
                            <span className="visually-hidden">Previous</span>
                        </button>
                        <button className="carousel-control-next" type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide="next">
                            <span className="carousel-control-next-icon" aria-hidden="true"></span>
                            <span className="visually-hidden">Next</span>
                        </button>
                    </Box>
                </BaseCard>
            </Grid>
        </PageContainer>
    );
};
export default Buttons;
