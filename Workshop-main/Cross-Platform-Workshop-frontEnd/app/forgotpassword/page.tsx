'use client'
import React, { useState, useEffect, ChangeEvent, FormEvent } from 'react';
import { Container, Row, Col, Form } from 'react-bootstrap';
import { AiFillGithub } from "react-icons/ai";
import { BsFacebook } from "react-icons/bs";
import { BiLogoGmail } from "react-icons/bi";
import { BsDiscord } from 'react-icons/bs';
import { signIn } from "next-auth/react";
import Link from 'next/link';
import styles from './login-form.module.css';
import './style.css'


const ForgotPasswordForm: React.FC = () => {
    const [formData, setFormData] = useState({
        Email: '',
    });
    const [successMessage, setSuccessMessage] = useState<string | null>(null);
    const [isLoading, setIsLoading] = useState(false);
    const [error, setError] = useState<string | null>(null);
    const [emailError, setEmailError] = useState<string | null>(null);


    const handleInputChange = (e: React.ChangeEvent<HTMLInputElement>) => {
        const { name, value } = e.target;
        if (name === 'Email') {
            setFormData({ ...formData, Email: value });

            // Validate email format
            const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            const isValidEmail = emailRegex.test(value);

            if (!isValidEmail) {
                setEmailError('Please enter a valid email address');
            } else {
                setEmailError(null);
            }
        }
    };
    const handleSuccessMessageTimeout = () => {
        setTimeout(() => {
            setSuccessMessage(null);
        }, 3000); // Set the duration in milliseconds (3 seconds in this case)
    };
    const handleErrorMessageTimeout = () => {
        setTimeout(() => {
            setError(null);
        }, 3000); // Set the duration in milliseconds (3 seconds in this case)
    };

    const handleSubmit = async (e: React.FormEvent) => {
        e.preventDefault();
        
        if (!formData.Email.trim()) {
            setError('Please enter your email address');
            handleErrorMessageTimeout();
            return;
        }
        setIsLoading(true);
        setError(null);

        try {
            const response = await fetch(`http://localhost:8089/auth/user/forgetPassword?Email=${formData.Email}`, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                    'Authorization': `Bearer`,
                },
            });

            console.log("response", response);

            if (response.ok) {
                const data = await response.json();
                // Set success message
                setSuccessMessage('Password reset successful! Please check your Email Get New Password');
                handleSuccessMessageTimeout();
            } else {
                const errorData = await response.json();
                if (response.status === 500) {
                    setError('Email not registered! Please check your Email'); // Xử lý lỗi 500
                    handleErrorMessageTimeout();
                } else {
                    console.error('Registration failed:', response.status, response.statusText);
                }
            }

        } catch (error) {
            console.error('Error:', error);
        } finally {
            setIsLoading(false); // Đặt isLoading thành false sau khi hoàn thành yêu cầu (thành công hoặc thất bại)
        }

        console.log('Đăng ký thành công!', formData);
    };
    console.log('Đăng ký thành công!', formData);



    return (
        <Container className={styles.pricingItemRegular}>
            <Row className={' p-4 my-5'}>
                <Col md={6}>
                    <img src="https://mdbcdn.b-cdn.net/img/Photos/new-templates/bootstrap-login-form/draw2.svg" className="img-fluid" alt="Phone image" />
                </Col>
                <Col md={6}>
                    <div>
                        <h1 className="display-6 mb-3 text-center">Forgot Password</h1>

                        <form onSubmit={handleSubmit}>
                            <div className="form-group row mb-2">
                                <label className="col-sm-3 col-form-label">Email:</label>
                                <div className="col-sm-9">
                                    <input
                                        type="email"
                                        className={`form-control ${emailError ? 'is-invalid' : ''}`}
                                        id="Email"
                                        name="Email"
                                        placeholder="Email"
                                        aria-describedby="emailHelp"
                                        onChange={handleInputChange}
                                        value={formData.Email}
                                    />
                                </div>
                            </div>



                            <button className={`${styles.gradientbutton} mb-4 w-100 btn btn-primary`} type="submit" disabled={isLoading}>{isLoading ? 'Resetting Password...' : 'Reset Password'}</button>
                        </form>
                        <h6>Do you have an account? <Link href={'/login'}>Login</Link></h6>
                        {/* Render success message dialog if there is a success message */}
                        {successMessage && (
                            <div className="alert alert-success mt-3" role="alert">
                                {successMessage}
                            </div>
                        )}
                        {emailError && (
                            <div className="invalid-feedback">{emailError}</div>
                        )}
                        {/* Hiển thị lỗi nếu có */}
                        {error && (
                            <div className="alert alert-danger mt-3" role="alert">
                                {error}
                            </div>
                        )}

                    </div>
                </Col>
            </Row>
        </Container>
    );
};

export default ForgotPasswordForm;
