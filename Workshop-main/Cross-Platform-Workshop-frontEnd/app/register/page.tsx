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


const LoginForm: React.FC = () => {
    const [loading, setLoading] = useState(false);
    const [formData, setFormData] = useState({
        full_name: '',
        balance: 0,
        user_name: '',
        email: '',
        password: '',
        phoneNumber: '',
        gender: '',
        role: 'USER',
    });
    const [isSeller, setIsSeller] = useState(false);

    const handleInputChange = (e: React.ChangeEvent<HTMLInputElement>) => {
        const { name, value } = e.target;
        if (name === 'email') {
            setFormData({ ...formData, email: value });
        } else if (name === 'full_name') {
            setFormData({ ...formData, full_name: value });
        } else if (name === 'user_name') {
            setFormData({ ...formData, user_name: value });
        } else if (name === 'phoneNumber') {
            setFormData({ ...formData, phoneNumber: value });
        } else if (name === 'role') {
            setFormData({ ...formData, role: value });
        } else if (name === 'password') {
            setFormData({ ...formData, password: value });
        } else if (name === 'gender') {
            setFormData({ ...formData, gender: value });
        } else if (name === 'confirmpassword') {
            setConfirmPassword(value);
        }

    };

    const handleSubmit = async (e: React.FormEvent) => {
        e.preventDefault();
        if (!validateForm()) {
            return;
        }
        if (formData.password !== confirmPassword) {
            alert("Passwords do not match.");
            return;
        }
        setLoading(true);
        try {
            const response = await fetch('http://localhost:8089/auth/user/register', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify(formData),
            });
            console.log("response", response);

            if (response.ok) {
                const data = await response.json();
                console.log('Registration successful:', data);
                window.location.href = '/login';
            } else {
                console.error('Registration failed:', response.status, response.statusText);
            }

        } catch (error) {
            console.error('Error:', error);
        } finally {
            // Set loading back to false when the registration process is complete
            setLoading(false);
        }

        console.log('Đăng ký thành công!', formData);
    };

    const handleSwitchChange = () => {
        setIsSeller(!isSeller);
        setFormData({ ...formData, role: isSeller ? 'USER' : 'SELLER' });
    };

    const [confirmPassword, setConfirmPassword] = useState('');
    const [validationErrors, setValidationErrors] = useState<string[]>([]);
    const validateForm = () => {
        const errors: string[] = [];

        // Perform your validation checks here

        if (!formData.full_name.trim()) {
            errors.push('Full Name is required');
        }
        else if (!formData.user_name.trim()) {
            errors.push('User Name is required');
        }
        else if (!formData.email.trim()) {
            errors.push('Email is required');
        }
        else if (!formData.gender.trim()) {
            errors.push('Gender is required');
        }
        else if (!formData.phoneNumber.trim()) {
            errors.push('Phone Number is required');
        } else if (!formData.password.trim()) {
            errors.push('Password is required');
        }
        // Add more validation checks for other fields

        if (formData.password !== confirmPassword) {
            errors.push('Confirm Password do not match');
        }

        setValidationErrors(errors);
        return errors.length === 0;
    };

    return (
        <Container className={styles.pricingItemRegular}>
            <Row className={' p-4 my-5'}>
                <Col md={6}>
                    <img src="https://mdbcdn.b-cdn.net/img/Photos/new-templates/bootstrap-login-form/draw2.svg" className="img-fluid" alt="Phone image" />
                </Col>
                <Col md={6}>
                    <div>
                        <h1 className="display-6 mb-3 text-center">Register</h1>
                        <div className='d-flex justify-content-center mb-2'>
                            <Form.Check
                                type="switch"
                                id="roleSwitch"
                                label={isSeller ? "MENTOR" : "USER"}
                                name="role"
                                onChange={handleSwitchChange}
                                checked={isSeller}
                            />
                        </div>
                        <form onSubmit={handleSubmit}>
                            <div className="form-group row mb-2">
                                <label className="col-sm-3 col-form-label">Full Name:</label>
                                <div className="col-sm-9">
                                    <input
                                        type="text"
                                        className="form-control"
                                        id="full_name"
                                        name="full_name"
                                        placeholder="Full Name"
                                        aria-describedby="emailHelp"
                                        onChange={handleInputChange}
                                        value={formData.full_name}
                                    />
                                </div>
                            </div>
                            <div className="form-group row mb-2">
                                <label className="col-3 col-form-label">User Name:</label>
                                <div className="col-9">
                                    <input
                                        type="text"
                                        className="form-control"
                                        id="user_name"
                                        name="user_name"
                                        placeholder="User Name"
                                        aria-describedby="emailHelp"
                                        onChange={handleInputChange}
                                        value={formData.user_name}
                                    />
                                </div>
                            </div>
                            <div className="form-group row mb-2">
                                <label className="col-sm-3 col-form-label">Email:</label>
                                <div className="col-sm-9">
                                    <input
                                        type="email"
                                        className="form-control"
                                        id="email"
                                        name="email"
                                        placeholder="Email"
                                        aria-describedby="emailHelp"
                                        onChange={handleInputChange}
                                        value={formData.email}
                                    />
                                </div>
                            </div>
                            <div className="form-group mb-2">
                                <div className='row'>
                                    <div className="col-sm-2">
                                        <label className="col-sm-4 col-form-label">Gender:</label>
                                    </div>
                                    <div className="col-sm-6   mt-2">
                                        <Form.Check
                                            inline
                                            type="radio"
                                            label="Male"
                                            id="male"
                                            name="gender"
                                            value="male"
                                            onChange={handleInputChange}
                                            checked={formData.gender === 'male'}
                                        />
                                        <Form.Check
                                            inline
                                            type="radio"
                                            label="Female"
                                            id="female"
                                            name="gender"
                                            value="female"
                                            onChange={handleInputChange}
                                            checked={formData.gender === 'female'}
                                        />
                                    </div>
                                </div>
                            </div>
                            <div className="form-group row mb-2">
                                <label className="col-sm-3 col-form-label">Phone Number:</label>
                                <div className="col-sm-9">
                                    <input
                                        type="number"
                                        className="form-control"
                                        id="phoneNumber"
                                        name="phoneNumber"
                                        placeholder="Phone Number"
                                        aria-describedby="phoneNumber"
                                        onChange={handleInputChange}
                                        value={formData.phoneNumber}
                                    />
                                </div>
                            </div>
                            <div className="form-group row mb-2">
                                <label className="col-sm-3 col-form-label">Password:</label>
                                <div className="col-sm-9">
                                    <input
                                        type="password"
                                        className="form-control"
                                        id="password"
                                        name="password"
                                        placeholder="Password"
                                        onChange={handleInputChange}
                                        value={formData.password}
                                    />
                                </div>
                            </div>
                            <div className="form-group row mb-2">
                                <label className="col-sm-3 col-form-label">Confirm Password:</label>
                                <div className="col-sm-9">
                                    <input
                                        type="password"
                                        className="form-control"
                                        id="confirmpassword"
                                        name="confirmpassword"
                                        placeholder="Confirm Password"
                                        onChange={handleInputChange}
                                        value={confirmPassword}
                                    />
                                </div>
                            </div>
                            <button className={`${styles.gradientbutton} mb-4 w-100 btn btn-primary`} type="submit" disabled={loading}>{loading ? 'Registering...' : 'Register'}</button>
                        </form>
                        {validationErrors.length > 0 && (
                            <div className="alert alert-danger" role="alert">
                                {validationErrors.map((error, index) => (
                                    <p key={index}>{error}</p>
                                ))}
                            </div>
                        )}
                        <h6>Do you have an account? <Link href={'/login'}>Login</Link></h6>
                    </div>
                </Col>
            </Row>
        </Container>
    );
};

export default LoginForm;
