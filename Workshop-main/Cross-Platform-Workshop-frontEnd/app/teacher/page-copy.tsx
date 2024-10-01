'use client'

import styles from './login-form.module.css';
import { Container, Row, Col } from 'react-bootstrap'
import { useSession } from "next-auth/react";
const teacher = () => {
    const session  =useSession();

    return (
        <Container>
            <div className={styles.login_box + ' p-3'}>
                <h1>teacher page</h1>
            </div>
        </Container>
    )
}
export default teacher;