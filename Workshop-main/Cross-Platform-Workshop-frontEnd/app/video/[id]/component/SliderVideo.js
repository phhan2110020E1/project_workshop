import Link from 'next/link';
import React, { useState } from 'react';
import styles from '../video.module.css';

const SliderVideo = ({ videos, onVideoSelect }) => {
    const [selectedVideoUrl, setSelectedVideoUrl] = useState('');

    const handleVionVideoSelectdeoSelect = (videoUrl) => {
        setSelectedVideoUrl(videoUrl);
    };
    console.log("videos", videos);
    return (
        <div className="flex flex-col items-center justify-start py-12 overflow-y-auto p-2">
            <h1 className="text-2xl font-bold mb-4 text-center">Course content</h1>
            <div className="space-y-6">
                {videos?.map((video) => (
                    console.log(video.thumbnailSrc),
                    <div key={video.id} className="space-y-2">
                        <Link
                            className={styles.videoContentText}
                            href="#"
                            onClick={() => onVideoSelect(video.urlMedia)}
                        >
                            <img
                                alt="Video Thumbnail"
                                className="object-cover"
                                height="100px" // Đặt chiều cao thành 100px
                                src={video.thumbnailSrc}
                            />
                            <div className={styles.videoContentText}
                            >
                                {video.title}
                            </div>
                        </Link>
                    </div>


                ))}
            </div>
        </div>
    );
};

export default SliderVideo;
