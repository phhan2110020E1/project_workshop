import Image from 'next/image';
import styles from '../CSS/home.module.css';
import React, { useEffect, useState } from 'react';
import 'bootstrap/dist/css/bootstrap.min.css';
import { Carousel } from 'react-bootstrap';
import { useRouter } from 'next/navigation';
import Link from 'next/link';
import { v4 as uuidv4 } from 'uuid';
import ApiService from '@/app/services/ApiService';
import { useSession } from 'next-auth/react';
const Card = () => {
    const [courses, setCourses] = useState<CourseType[]>([]); // Thay thế 'CourseType' bằng kiểu dữ liệu cụ thể bạn sử dụng
    const router = useRouter();
    interface CourseType {
        id: number;
        name: string;
        description: string;
        link: string;
        price: 0;
        startDate: string,
        courseMediaInfos: {
            urlImage: string;
        };
        // Các thuộc tính khác nếu có
    }
    const { data: session } = useSession();
    const apiService = new ApiService(session);

    useEffect(() => {
        const fetchData = async () => {
            try {
                const result = await apiService.listCoursePublic();
                if (Array.isArray(result.data)) {
                    const sortedCourses = result.data.sort((a: { startDate: string | number | Date; }, b: { startDate: string | number | Date; }) => new Date(b.startDate).getTime() - new Date(a.startDate).getTime());

                    setCourses(sortedCourses);

                } else {
                    console.error('Data is not an array:', result.data);
                }
            } catch (error) {
                console.error('Error fetching data:', error);
            }
        };

        fetchData();
    }, [session]);


    const chunkArray = (arr: CourseType[], chunkSize: number) => {
        const groups = [];
        for (let i = 0; i < arr.length; i += chunkSize) {
            groups.push(arr.slice(i, i + chunkSize));
        }
        return groups;
    };
    const randomToken = uuidv4();
    return (
        <div>
            <div className={styles.sectionHeadingPricing}>
                <h4>We Offer Exclusive <em className={styles.emm}>Pre-Order</em> Prices !</h4>
                <div className="d-flex justify-content-center">
                    <Image src="/heading-line-dec.png" alt="Ảnh" width={45} height={2} />

                </div>
                <div className="d-flex justify-content-center">
                    <p className={styles.pText}>
                        Check out our amazing pre-order deals – the best prices you can find anywhere. Get ready for a fantastic experience!</p>
                </div>

            </div>
            <Carousel interval={1000} controls={false}>
                {chunkArray(courses, 3).map((chunk, chunkIndex) => (
                    <Carousel.Item key={chunkIndex}>
                        <div className="card-group">
                            {chunk.map((course, index) => (
                                <div key={index} className={`card ${styles.cardCustom}`}>
                                    <div className="card-body">
                                        <div key={index} className={`card ${index === Math.floor(chunk.length / 2) ? styles.pricingItemPro : styles.pricingItemRegular}`}>
                                            <span className={styles.price}>${course.price}</span>
                                            <h4>{course.name}</h4>
                                            <div className="icon">
                                                <Image src={course.courseMediaInfos[0].urlImage} width={100} height={100} alt="" />
                                            </div>

                                            <ul>
                                                <li>{course.description}</li>
                                                <li>{course.description}</li>
                                                <li>{course.description}</li>
                                            </ul>
                                            <div className={styles.borderButton}>
                                                <Link href={`/courseDemo/[id]`} as={`/courseDemo/${course.id}`}>
                                                    Purchase This Workshop Now
                                                </Link>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            ))}
                        </div>
                    </Carousel.Item>
                ))}
            </Carousel>
        </div>
    );
};

export default Card;