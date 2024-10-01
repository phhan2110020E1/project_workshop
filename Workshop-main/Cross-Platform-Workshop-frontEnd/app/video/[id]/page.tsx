'use client'

import { Container, Row, Col } from "react-bootstrap";
import "bootstrap/dist/css/bootstrap.min.css";
import VideoPublic from './component/VideoPlayer';
import SliderVideo from "./component/SliderVideo";
import { useEffect, useState } from "react";
import ApiService from "@/app/services/ApiService";
import { useSession } from 'next-auth/react';
import { v4 as uuidv4 } from 'uuid';
import Navbar from "@/components/Navbar";
import styles from '../[id]/video.module.css';
interface CourseType {
    id: number;
    name: string;
    description: string;
    link: string;
    price: number;
    courseMediaInfos:courseMediaInfos[];
  }
interface courseMediaInfos {
    id:number;
    thumbnailSrc:string;
    title:string;
    urlImage:string;
    urlMedia:string;
}
const teacher = ({ params }: { params: { id: any } }) => {
    const [selectedVideoUrl, setSelectedVideoUrl] = useState('');
    const { data: session } = useSession();
    const apiService = new ApiService(session);
    const [course, setCourse] = useState<CourseType>();
    const [video, setVideo] = useState<CourseType>();
    useEffect(() => {
            const fetchData = async () => {
                try {
                    const respone = await apiService.CoursePublicDetail(params.id);
                    if (respone.data) 
                    {   
                        console.log(respone.data);    
                        setCourse(respone.data);                    
                    }
                } catch (error) {
                    console.error("Error fetching request:", error);
                }
            };
            fetchData();
    },[]);
    return (
    <div className={styles.pricingItemRegular}>
        <Container fluid className="w-screen h-screen">
            <Row className="bg-slate-400">
                <Col sm={2}>
                    <Container>
                       <SliderVideo videos={course?.courseMediaInfos} onVideoSelect={setSelectedVideoUrl}/>
                    </Container>
                </Col>
                <Col sm={10}>
                    <VideoPublic selectedVideoUrl={selectedVideoUrl} />
                </Col>
            </Row>
        </Container>
        </div>
    )
}

export default teacher;