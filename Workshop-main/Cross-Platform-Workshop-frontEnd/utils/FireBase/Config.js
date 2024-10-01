// Import the functions you need from the SDKs you need
import { initializeApp } from "firebase/app";
// import { getAnalytics } from "firebase/analytics";
import {getStorage} from 'firebase/storage';

const firebaseConfig = {
  apiKey: "AIzaSyC5J4aY1-xKNdndKpuVZO19ODQEyZ31M2w",
  authDomain: "workshopprojec04.firebaseapp.com",
  projectId: "workshopprojec04",
  storageBucket: "workshopprojec04.appspot.com",
  messagingSenderId: "497836715749",
  appId: "1:497836715749:web:b6acda08d27840de8d6e0c",
  measurementId: "G-L24W06MCJC"
};

// Initialize Firebase
const app = initializeApp(firebaseConfig);
export const FirebaseDb =getStorage(app)
// const analytics = getAnalytics(app);