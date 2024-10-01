'use client';
import {
    Box,
    Button,
    Container,
    Pagination,
    Stack,
    SvgIcon,
    Typography,
    Unstable_Grid2 as Grid
} from '@mui/material';
import PageContainer from '@/app/user/components/container/PageContainer';
import React, { useEffect, useState } from "react";
import "react-responsive-carousel/lib/styles/carousel.min.css";
import 'bootstrap/dist/css/bootstrap.min.css';
import { CompanyCard } from './company-card.js';
import ApiService from '@/app/services/ApiService';
import { useSession } from 'next-auth/react';
import Link from 'next/link';
import AddIcon from '@mui/icons-material/Add';
interface Course {
    id: number;
}

const Buttons: React.FC = () => {
    const [courses, setCourses] = useState<Course[]>([]);
    const [loading, setLoading] = useState(true);
    const { data: session } = useSession();

    useEffect(() => {
        const fetchData = async () => {
            try {
                const apiService = new ApiService(session);
                const response = await apiService.listCoursesFromApi();
                if (response.status === "success") {
                    setCourses(response.data);
                    console.log('Courses:', response.data);

                }
            } catch (error) {
                console.error('Lỗi khi tải dữ liệu:', error);
            } finally {
                setLoading(false);
            }
        };

        if (session) {
            fetchData();
        }
    }, [session]);

    const itemsPerPage = 6;

    // Phân trang dữ liệu
    const pageCount = Math.ceil(courses.length / itemsPerPage);
    const [currentPage, setCurrentPage] = useState(1);
    const handlePageChange = (event: React.ChangeEvent<unknown>, page: number) => {
        setCurrentPage(page);
    };

    const startIndex = (currentPage - 1) * itemsPerPage;
    const visibleCourses = courses.slice(startIndex, startIndex + itemsPerPage);


    return (
        <PageContainer title="button" description="this is button">
            <Box
                component="main"
                sx={{
                    flexGrow: 1,
                    py: 8
                }}
            >
                <Container maxWidth="xl">
                    <Stack spacing={3}>
                        <Stack
                            direction="row"
                            justifyContent="space-between"
                            spacing={4}
                        >
                            <Stack spacing={1}>
                                <Typography variant="h4">
                                    Workshop
                                </Typography>
                                
                            </Stack>

                            <Link href="./add">
                                <Button
                                    style={{ backgroundColor: "#4b8ef1", color: "#ffffff" }}
                                    startIcon={<AddIcon fontSize="small" />}
                                    variant="contained"
                                >
                                    Add
                                </Button>

                            </Link>
                        </Stack>
                        {/* <CompaniesSearch /> */}
                        {loading ? (
                            <p>Đang tải...</p>
                        ) : courses.length > 0 ? (
                            <Grid container spacing={3}>
                                {visibleCourses.map((course, index) => (
                                    <Grid xs={12} md={6} lg={4} key={index}>
                                        {/* <div onClick={() => router.push(`./edit/${course.id}`)} > */}
                                        {/* <Link style={{ textDecoration: 'none', color: 'inherit' }} href={`./edit/${course.id}`} passHref> */}
                                        <CompanyCard courses={courses} courseId={course.id} />
                                        {/* </Link> */}
                                        {/* </div> */}
                                    </Grid>

                                ))}
                            </Grid>
                        ) : (
                            <p>Không có khóa học nào</p>
                        )}

                        <Box
                            sx={{
                                display: 'flex',
                                justifyContent: 'center'
                            }}
                        >
                            <Pagination
                                count={pageCount}
                                size="small"
                                page={currentPage}
                                onChange={(event, page) => handlePageChange(event, page)}
                            />
                        </Box>
                    </Stack>
                </Container>
            </Box>
        </PageContainer>
    );
};
export default Buttons;
