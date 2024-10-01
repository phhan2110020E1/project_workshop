import { TextField } from '@mui/material';
import React, { useEffect, useState } from 'react';
import { Button, Col, Row } from 'react-bootstrap';
import dynamic from 'next/dynamic';
import styles from '../video.module.css';

const ReactPlayer = dynamic(() => import('react-player'), { ssr: false });

const VideoPublic = ({ selectedVideoUrl }) => {

    const [currentVideoUrl, setCurrentVideoUrl] = useState(selectedVideoUrl);
    useEffect(() => {
        setCurrentVideoUrl(selectedVideoUrl);
    }, [selectedVideoUrl]);
    
    return (
        <Row >
            <Col sm={12} md={12} lg={12}>
                <div className="mx-auto w-full space-y-6 p-2">
                    <Row>
                        <div className="player-container">
                            <ReactPlayer
                                url={currentVideoUrl}
                                controls={true}
                                playing={true}
                                muted={true}
                                width={'100%'}
                                height={666}
                            />
                        </div>
                    </Row>
                    <Row className={styles.footer}>
                        <div className="space-y-2">
                            <h2 className={styles.sectionHeading}>Comments</h2>
                            <form  className={styles.search}>
                            <fieldset>
                    <input type="text" name="comment" className="comment" placeholder="Leave your comment..." autoComplete="on" required />
                  </fieldset>
                  <Button
                               className={styles.searchButton}
                                type="submit"
                            >
                                Post Comment
                            </Button>
                            </form>
                            
                            
                        </div>
                    </Row>
                </div>
            </Col>
        </Row>
    );
}

export default VideoPublic;
