import { Button, Container } from "react-bootstrap";
import dynamic from 'next/dynamic';
import Link from "next/link";
import styles from '../../[id]/courseDemo.module.css';
import { useEffect, useState } from "react";
import ApiService from "@/app/services/ApiService";
import { useSession } from 'next-auth/react';
import { v4 as uuidv4 } from 'uuid';

const ReactPlayer = dynamic(() => import('react-player'), { ssr: false });

export default function SideLeft({ course }) {
    const [isFree, setIsFree] = useState(false);
    const [isUserInCourse, setIsUserInCourse] = useState(false);
    const { data: session } = useSession();
    const apiService = new ApiService(session);
    const email = session?.user.email;

    useEffect(() => {
        const fetchData = async () => {
            console.log("Fetching data...");
            if (course && course.price !== undefined) {
                if (course.price === 0) {
                    setIsFree(true);
                } else {
                    try {
                        const response = await apiService.checkUserInCourse(email, course.id);
                        console.log("response.status", response.status);
                        if (response.status === 'true') {
                            setIsUserInCourse(true);
                            console.log("User is in the course");
                        } else if (response.status === 'false') {
                            setIsUserInCourse(false);
                            console.log("User is not in the course, prompt to buy");
                        }
                    } catch (error) {
                        console.error("Error checking user in course:", error);
                    }
                }
            }
        };

        fetchData();
    }, [course, email, apiService]);

    if (!course) {
        return null;
    }

    const randomToken = uuidv4();
    return (
        <Container className="p-2 ">
            <div className={styles.videothum}>
                <div className={styles.circularVideo}>
                    <ReactPlayer
                        url={course.courseMediaInfos[0].urlMedia}
                        controls={true}
                        playing={true}
                        muted={true}
                        width={'100%'}
                        height={333}
                    />
                </div>
            </div>
            <div className="text-center">
                <h1 className={styles.emm}>{isFree ? 'free' : 'premium'}</h1>
                {isFree ? (
                    <Link className={styles.borderButton} href={`/video/[id]`} as={`/video/${course.id}`}>
                        Xem Miễn Phí
                    </Link>
                ) : (
                    isUserInCourse ? (
                        <Link className={styles.borderButton} href={`/video/[id]`} as={`/video/${course.id}`}>
                            Xem Ngay
                        </Link>
                    ) : (
                        <Link className={styles.borderButton} href={`/demoPaypal/[id]`} as={`/demoPaypal/${course.id}`}>
                            Mua Ngay
                        </Link>
                    )
                )}
                <ul className={styles.list}>
                    <li>
                        <h6>Tổng Cộng có {course.courseMediaInfos.length} bài</h6>
                    </li>
                    <li>
                        <h6>Tổng Thời Lượng</h6>
                    </li>
                </ul>
            </div>
        </Container>
    );
}
