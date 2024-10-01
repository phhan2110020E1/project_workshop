'use client'
import { Col, Container, Row } from "react-bootstrap";
import React, { useEffect, useState } from 'react';
import ApiService from "@/app/services/ApiService";
import { useSession } from 'next-auth/react';
import SideLeft from '../[id]/component/SideLeft'
import styles from '../[id]/courseDemo.module.css';
import Navbar from "@/components/Navbar";

interface CourseType {
    id: number;
    name: string;
    description: string;
    link: string;
    price: number;
    courseMediaInfos: courseMediaInfos[];
}
interface courseMediaInfos {
    id: number;
    thumbnailSrc: string;
    title: string;
    urlImage: string;
    urlMedia: string;
}
const CourseDemo = ({ params }: { params: { id: any } }) => {
    const { data: session } = useSession();
    const apiService = new ApiService(session);
    const [course, setCourse] = useState<CourseType>();
    const [isDropdownOpen, setDropdownOpen] = useState(false);
    const [selectedOption, setSelectedOption] = useState<string | null>(null);

    const handleDropdownToggle = () => {
        setDropdownOpen(!isDropdownOpen);
    };

    const handleOptionSelect = (option: string) => {
        setSelectedOption(option);
        setDropdownOpen(false);
    }; useEffect(() => {
        const fetchData = async () => {
            try {
                const respone = await apiService.CoursePublicDetail(params.id);
                if (respone.data) {
                    setCourse(respone.data);
                }
            } catch (error) {
                console.error("Error fetching request:", error);
            }
        };
        fetchData();
    }, []);

    return (
        <div>
            <Navbar />


            <Container fluid>
                <Row className="">
                    <hr></hr>
                    <br></br>
                    <br></br>
                    <br></br>
                    <br></br>
                    <Col className={styles.pricingItemRegular} sm={8}>
                        <Container className="p-5 pt-2">
                            <h1>{course?.name}</h1>
                            <h6>{course?.description}</h6>
                            <h3>Course Content</h3>
                        </Container>
                        <Container className="p-5 pt-2">
                            <div className={styles.dropdownContainer}>
                                <button className={styles.trigger} onClick={handleDropdownToggle}>
                                    <label htmlFor="dropdownCheckbox">
                                        1. Introduction to the course
                                    </label>
                                </button>
                                {isDropdownOpen && (
                                    <div className={styles.dropdownContent}>
                                        <div onClick={() => handleOptionSelect("option1")}>Installing Dev - C++</div>
                                        <div onClick={() => handleOptionSelect("option2")}>Using Dev - C++ Guide</div>
                                        <div onClick={() => handleOptionSelect("option3")}>Variables and Data Input/Output</div>
                                    </div>
                                )}
                            </div>
                        </Container>

                    </Col>

                    <Col sm={4}>
                        <SideLeft course={course} />
                    </Col>
                </Row>
            </Container>
        </div>
    )
}

export default CourseDemo;
