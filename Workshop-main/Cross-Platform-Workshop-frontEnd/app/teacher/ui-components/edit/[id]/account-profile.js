import React, { useState, useCallback, useEffect } from 'react';
import {
  Box,
  Button,
  Card,
  CardActions,
  CardContent,
  Divider,
} from '@mui/material';
import {
  ref,
  uploadBytesResumable,
  getDownloadURL,
  getStorage,
} from 'firebase/storage';
import { FirebaseDb } from '@/utils/FireBase/Config';
import { v4 as uuidv4 } from 'uuid';

const storage = getStorage();

export const AccountProfile = ({ onMediaUpload, existingVideoUrl, formData }) => {
  const [mediaData, setMediaData] = useState({
    mediaInfoList: [
      {
        id: 0,
        urlMedia: null,
        urlImage: null,
        thumbnailSrc: null,
        title: null,
      },
    ],
  });

  const handleMediaUpload  = useCallback(async (event) => {
    const files = event.target.files;

    if (files && files[0]) {
      const selectedMedia  = files[0];
      const mediaRef  = ref(storage, `media/${uuidv4()}`);

      try {
        const uploadTask = uploadBytesResumable(mediaRef, selectedMedia);

        uploadTask.on(
          'state_changed',
          (snapshot) => {
            const progress =
              (snapshot.bytesTransferred / snapshot.totalBytes) * 100;
            console.log('Upload is ' + progress + '% done');
          },
          (error) => {
            console.error('Error uploading:', error);
          },
          async () => {
            try {
              const url = await getDownloadURL(uploadTask.snapshot.ref);

              const newMediaInfo  = {
                id: mediaData.mediaInfoList.length,
                thumbnailSrc: null,
                title: '',
                urlImage: selectedMedia.type.startsWith('image') ? url : '',
                urlMedia: selectedMedia.type.startsWith('video') ? url : '',
              };
              setMediaData((prevState) => ({
                ...prevState,
                mediaInfoList: [
                  newMediaInfo,
                  ...prevState.mediaInfoList.slice(1),
                ],
              }));

              onMediaUpload(newMediaInfo);
              console.log('Media  uploaded successfully.');
            } catch (error) {
              console.error('Error getting download URL:', error);
            }
          }
        );
      } catch (error) {
        console.error('Error uploading:', error);
      }
    } else {
      console.error('No media  file selected.');
    }
  }, [onMediaUpload]);
  useEffect(() => {
    // Set existing media URLs when available
    if (existingMediaInfos && existingMediaInfos.length > 0) {
      const existingMediaInfo = existingMediaInfos[0];
      setMediaData((prevState) => ({
        ...prevState,
        mediaInfoList: [
          {
            id: existingMediaInfo.id || 0,
            urlMedia: existingMediaInfo.urlMedia || '',
            urlImage: existingMediaInfo.urlImage || '',
            thumbnailSrc: existingMediaInfo.thumbnailSrc || 0,
            title: existingMediaInfo.title || 0,
          },
        ],
      }));
    }
  }, [existingMediaInfos]);
  useEffect(() => {
    if (
      formData &&
      formData.length > 0 &&
      formData[0].courseMediaInfos &&
      formData[0].courseMediaInfos.length > 0
    ) {
      const {
        id,
        urlMedia,
        urlImage,
        thumbnailSrc,
        title,
      } = formData[0].courseMediaInfos[0];

      setMediaData({
        mediaInfoList: [
          {
            id: id || 0,
            urlMedia: urlMedia || '',
            urlImage: urlImage || '',
            thumbnailSrc: thumbnailSrc || 0,
            title: title || 0,
          },
        ],
      });
    }
  }, [formData]);
  
  
// console.log('mediaData nè',mediaData);
// console.log('Video URL:', mediaData?.mediaInfoList[0]?.urlMedia);

return (
  <Card>
    <CardContent>
      <Box
        sx={{
          alignItems: 'center',
          display: 'flex',
          flexDirection: 'column',
        }}
      >
        {mediaData.mediaInfoList[0].urlMedia && (
          <video width="320" height="240" controls>
            <source
              src={mediaData.mediaInfoList[0].urlMedia}
              type="video/mp4"
            />
            Your browser does not support the video tag.
          </video>
        )}
        {mediaData.mediaInfoList[0].urlImage && (
          <img
            src={mediaData.mediaInfoList[0].urlImage}
            alt="Uploaded Image"
            style={{ maxWidth: '100%', marginTop: '10px' }}
          />
        )}
      </Box>
    </CardContent>
    <Divider />
    <CardActions>
      <Button fullWidth variant="text">
        <label htmlFor="media-upload">Upload media</label>
        <input
          id="media-upload"
          type="file"
          style={{ display: 'none' }}
          onChange={handleMediaUpload}
          accept="video/*,image/*"
          multiple
        />
      </Button>
    </CardActions>
  </Card>
);
};