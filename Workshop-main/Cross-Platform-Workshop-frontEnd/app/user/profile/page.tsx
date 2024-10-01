'use client'

import styles from './login-form.module.css';
import { Container, Row, Col } from 'react-bootstrap'
const teacher = () => {
    return (
        <Container>
            <div className={styles.login_box + ' p-3'}>
                <h1>User Infor</h1>
            </div>
        </Container>

    )
}
export default teacher;