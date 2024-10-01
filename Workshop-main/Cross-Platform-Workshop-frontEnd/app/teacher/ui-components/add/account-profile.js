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

export const AccountProfile = ({ onMediaUpload, existingMediaInfos, formData }) => {
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

  const handleImageUpload = useCallback(async (event) => {
    const files = event.target.files;
  
    if (files && files[0]) {
      const selectedMedia = files[0];
      const mediaRef = ref(storage, `media/${uuidv4()}`);
  
      try {
        const uploadTask = uploadBytesResumable(mediaRef, selectedMedia);
  
        uploadTask.on(
          'state_changed',
          (snapshot) => {
            const progress = (snapshot.bytesTransferred / snapshot.totalBytes) * 100;
            console.log('Upload is ' + progress + '% done');
          },
          (error) => {
            console.error('Error uploading:', error);
          },
          async () => {
            try {
              const url = await getDownloadURL(uploadTask.snapshot.ref);
  
              const existingMedia = mediaData.mediaInfoList.find(
                (media) => media.urlMedia && media.urlMedia !== url
              );
  
              const newMediaInfo = {
                id:mediaData.mediaInfoList.length ,
                thumbnailSrc: null,
                title: '',
                urlImage: selectedMedia.type.includes('image') ? url : '',
                urlMedia: existingMedia ? existingMedia.urlMedia : '',
              };
  
              setMediaData((prevState) => ({
                ...prevState,
                mediaInfoList: [newMediaInfo, ...prevState.mediaInfoList.slice(1)],
              }));
  
              onMediaUpload(newMediaInfo);
              console.log('Media uploaded successfully.');
            } catch (error) {
              console.error('Error getting download URL:', error);
            }
          }
        );
      } catch (error) {
        console.error('Error uploading:', error);
      }
    } else {
      console.error('No media file selected.');
    }
  }, [onMediaUpload, mediaData.mediaInfoList]);
  
  const handleVideoUpload = useCallback(async (event) => {
    const files = event.target.files;
  
    if (files && files[0]) {
      const selectedMedia = files[0];
      const mediaRef = ref(storage, `media/${uuidv4()}`);
  
      try {
        const uploadTask = uploadBytesResumable(mediaRef, selectedMedia);
  
        uploadTask.on(
          'state_changed',
          (snapshot) => {
            const progress = (snapshot.bytesTransferred / snapshot.totalBytes) * 100;
            console.log('Upload is ' + progress + '% done');
          },
          (error) => {
            console.error('Error uploading:', error);
          },
          async () => {
            try {
              const url = await getDownloadURL(uploadTask.snapshot.ref);
  
              const existingMedia = mediaData.mediaInfoList.find(
                (media) => media.urlImage && media.urlImage !== url
              );
  
              const newMediaInfo = {
                // id: existingMedia ? existingMedia.id : uuidv4(),
                id: mediaData.mediaInfoList.length ,
                thumbnailSrc: null,
                title: '',
                urlImage: existingMedia ? existingMedia.urlImage : '',
                urlMedia: selectedMedia.type.includes('video') ? url : '',
              };
  
              setMediaData((prevState) => ({
                ...prevState,
                mediaInfoList: [newMediaInfo, ...prevState.mediaInfoList.slice(1)],
              }));
  
              onMediaUpload(newMediaInfo);
              console.log('Media uploaded successfully.');
            } catch (error) {
              console.error('Error getting download URL:', error);
            }
          }
        );
      } catch (error) {
        console.error('Error uploading:', error);
      }
    } else {
      console.error('No media file selected.');
    }
  }, [onMediaUpload, mediaData.mediaInfoList]);
  
  
  
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
                  formData[0].mediaInfoList &&
                  formData[0].mediaInfoList.length > 0
                ) {
                  const {
                    id,
                    urlMedia,
                    urlImage,
                    thumbnailSrc,
                    title,
                  } = formData[0].mediaInfoList[0];

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
                // <Card>
                //   <CardContent>
                //   <Box
                //       sx={{
                //         alignItems: 'center',
                //         display: 'flex',
                //         flexDirection: 'column',
                //       }}
                //     >
                //       {/* Hiển thị video nếu có */}
                //       {mediaData.mediaInfoList[0].urlMedia && mediaData.mediaInfoList[0].urlImage && (
                //         <video width="320" height="240" controls>
                //           <source src={mediaData.mediaInfoList[0].urlMedia} type="video/mp4" />
                //           Your browser does not support the video tag.
                //         </video>
                //       )}
                //     </Box>   
                //     <Box
                //       sx={{
                //         alignItems: 'center',
                //         display: 'flex',
                //         flexDirection: 'column',
                //       }}
                //     >
                //       {/* Hiển thị hình ảnh nếu có */}
                //       {mediaData.mediaInfoList[0].urlImage && !mediaData.mediaInfoList[0].urlMedia && (
                //         <img
                //           src={mediaData.mediaInfoList[0].urlImage}
                //           alt="Uploaded Image"
                //           style={{ maxWidth: '100%', marginTop: '10px' }}
                //         />
                //       )}
                //     </Box>
                //   </CardContent>
                //   <Divider />
                //   <CardActions>
                //     {/* Nút tải lên hình ảnh */}
                //     <Button fullWidth variant="text">
                //       <label htmlFor="image-upload">Upload Image</label>
                //       <input
                //         id="image-upload"
                //         type="file"
                //         style={{ display: 'none' }}
                //         onChange={handleImageUpload}
                //         accept="image/*"
                //       />
                //     </Button>

                //     {/* Nút tải lên video */}
                //     <Button fullWidth variant="text">
                //       <label htmlFor="video-upload">Upload Video</label>
                //       <input
                //         id="video-upload"
                //         type="file"
                //         style={{ display: 'none' }}
                //         onChange={handleVideoUpload}
                //         accept="video/*"
                //       />
                //     </Button>
                //   </CardActions>
                // </Card>
                <Card>
                <CardContent>
                  <Box
                    sx={{
                      alignItems: 'center',
                      display: 'flex',
                      flexDirection: 'column',
                    }}
                  >
                    {mediaData?.mediaInfoList?.[0]?.urlMedia && (
                      <video width="320" height="240" controls>
                        <source
                          src={mediaData.mediaInfoList[0].urlMedia} type="video/mp4" />
                        Your browser does not support the video tag.
                      </video>
                    )}
                  </Box>
                </CardContent>
                <Divider />
                <CardActions>
                  <Button fullWidth variant="text">
                    <label htmlFor="video-upload">
                      Upload video
                    </label>

                    <input
                      id="video-upload"
                      type="file"
                      style={{ display: 'none' }}
                      onChange={handleVideoUpload}
                      accept="video/*,image/*"
                      multiple // Allow selecting multiple files for uploading video and images
                    />
                  </Button>
                </CardActions>

                <Box
                  sx={{
                    alignItems: 'center',
                    display: 'flex',
                    flexDirection: 'column',
                  }}
                >
                  {mediaData.mediaInfoList && mediaData.mediaInfoList.length > 0 && (
                    <img
                      src={mediaData.mediaInfoList[0].urlImage}
                      alt="Selected Image"
                      style={{ width: '50%', height: 'auto', maxWidth: '320px' }}
                    />
                  )}

                </Box>
                <CardActions>
                  <Button fullWidth variant="text">
                    <label htmlFor="image-upload">
                      Upload image
                    </label>

                    <input
                      id="image-upload"
                      type="file"
                      style={{ display: 'none' }}
                      onChange={handleImageUpload}
                      accept="image/*"
                    />
                  </Button>
                </CardActions>
              </Card>
              );
            };