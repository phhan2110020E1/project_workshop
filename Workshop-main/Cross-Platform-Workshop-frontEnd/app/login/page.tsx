'use client'
import { Formik, Field, Form, ErrorMessage , FormikHelpers } from 'formik';
import styles from './login-form.module.css';
import * as Yup from 'yup';
import { signIn, useSession } from "next-auth/react"
import { Container, Row, Col } from 'react-bootstrap'
import { AiFillGithub } from "react-icons/ai"
import { BsFacebook } from "react-icons/bs"
import { BiLogoGmail } from "react-icons/bi"
import { BsDiscord } from 'react-icons/bs';
import { useEffect, useState } from 'react';
import { useRouter } from 'next/navigation';
import Link from 'next/link';

type Values = {
    email: string;
    password: string;
};
const currentUrl = typeof window !== 'undefined' ? window.location.search : "";
function getQueryParamValue(queryString: string, paramName: string) {
    const urlParams = new URLSearchParams(queryString);
    return urlParams.get(paramName);
}
const callbackUrl = getQueryParamValue(currentUrl, 'callbackUrl');
console.log(callbackUrl);

// Khai báo biến cờ
let reloadCount = 0;

const LoginForm = () => {
    const router = useRouter();
    const [shouldReload, setShouldReload] = useState(false);
    useEffect(() => {
        if (shouldReload) {
            // Tăng biến đếm load lại
            reloadCount++;
            // Kiểm tra nếu trang đã load lại đủ lần, thì tắt cờ
            if (reloadCount >= 2) {
                setShouldReload(false);
                reloadCount = 0; // Đặt lại biến đếm
            }
        }
    }, [shouldReload]);
    const handleSubmit = async (values: Values, { setSubmitting }: FormikHelpers<Values>) => {
        const requestHeaders: HeadersInit = new Headers();
        requestHeaders.set('Content-Type', 'application/json');
        try {
            const response = await signIn("credentials", {
                email: values.email,
                password: values.password,
                redirect: true,
                callbackUrl: callbackUrl || '/'
            })
            setShouldReload(true);
            router.push(callbackUrl || '/');
        } catch (error) {
            console.error('Lỗi khi gọi API đăng nhập:', error);
        } finally {
            setSubmitting(false);
        }
    };
    return (
        <Container className={styles.pricingItemRegular}>
            <Row className={' p-5 my-5'}>
                <Col col='10' md='6'>
                    <img src="https://mdbcdn.b-cdn.net/img/Photos/new-templates/bootstrap-login-form/draw2.svg" className="img-fluid" alt="Phone image" />
                </Col>
                <Col col='4' md='6' >
                    <div className={' p-3'}>
                        <h1 className="display-6 mb-3 text-center">Login</h1>
                        <Formik
                            initialValues={{
                                email: '',
                                password: '',
                            }}
                            validationSchema={Yup.object({
                                email: Yup.string().required('Vui lòng nhập Email'),
                                password: Yup.string().required('Vui lòng nhập mật khẩu'),
                            })}
                            onSubmit={handleSubmit}
                        >
                            <Form>
                                <div className="mb-3">
                                    <Field className={`form-control ${styles.inputField}`} id="email" name="email" placeholder="Email" aria-describedby="usernameHelp" />
                                    <ErrorMessage name="email" component="div" className={styles.error} />
                                </div>
                                <div className="mb-3">
                                    <Field className={`form-control ${styles.inputField}`} id="password" name="password" placeholder="Password" type="password" />
                                    <ErrorMessage name="password" component="div" className={styles.error} />
                                </div>
                                <div className="mb-3 d-flex justify-content-between align-items-center">
                                    <div>
                                        <div className={styles.custom_checkbox}>
                                            <input type="checkbox" className="form-check-input-lg me-2" />
                                            <label htmlFor="customCheck">Remember me</label>
                                        </div>
                                    </div>
                                    <h6><Link href={'/forgotpassword'}>Forgot password?</Link></h6>
                                </div>
                                <button className={`${styles.gradientbutton} mb-4 w-100 btn btn-primary`}
                                    type="submit">Login</button>
                                <h6>Don't have an account? <Link href={'/register'}>Register</Link></h6>
                                <h2 className="lead fw-normal mb-0 me-3 text-center">Sign in with</h2>
                                <div className={styles.div_media}>
                                    <button onClick={() => signIn("facebook", { redirect: true, callbackUrl: callbackUrl || '/' })} className='btn btn-lg me-2'>
                                        <BsFacebook fab="true" icon='facebook-f' />
                                    </button>
                                    <button onClick={() => signIn("github", { redirect: true, callbackUrl: callbackUrl || '/' })} className='btn  btn-lg me-2'>
                                        <AiFillGithub fab="tru  e" icon='github' />
                                    </button>
                                    <button onClick={() => signIn("google", { redirect: true, callbackUrl: callbackUrl || '/' })} className='btn  btn-lg me-2'>
                                        <BiLogoGmail fab="true" icon='mail' />
                                    </button>
                                    {/* <button onClick={() => signIn("instagram",{callbackUrl:"/"})} className='btn  btn-lg me-2'>
                                        <BsInstagram fab="true" icon='instagram' />
                                    </button>
                                    <button onClick={() => signIn("reddit",{callbackUrl:"/"})} className='btn  btn-lg me-2'>
                                        <BsReddit fab="true" icon='reddit' />
                                    </button>
                                    <button onClick={() => signIn("linkedin",{callbackUrl:"/"})} className='btn  btn-lg me-2'>
                                        <BsLinkedin fab="true" icon='linkedin' />
                                    </button> */}

                                </div>
                            </Form>
                        </Formik>
                    </div>
                </Col>
            </Row>
        </Container>
    )
}
export default LoginForm;