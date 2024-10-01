// Trong file courseData.ts

interface MediaInfoList {
  id: number;
  thumbnailSrc: string | null;
  title: string;
  urlImage: string;
  urlMedia: string;
}

interface discountDTOS {
  courseDiscount_id: number;
  quantity: number;
  // redemptionDate: Date;
  valueDiscount: number;
  name: string;
  description: string;
  remainingUses: number;
}

interface CourseLocation {
  courseLocation_id: number;
  schedule_Date: string;
  area: string;
}

interface CourseData {
  courseName: string;
  description: string;
  price: number;
  startDate: string;
  endDate: string;
  studentCount: number;
  type: string;
  MediaInfoList: MediaInfoList[];
  discountDTOS: discountDTOS[];
  courseLocation: CourseLocation[];
}

export default CourseData;
