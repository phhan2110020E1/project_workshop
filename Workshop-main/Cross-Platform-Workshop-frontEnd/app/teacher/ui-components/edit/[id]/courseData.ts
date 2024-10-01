// Trong file courseData.ts

interface courseMediaInfos {
  id: number;
  thumbnailSrc: string | null;
  title: string;
  urlImage: string;
  urlMedia: string;
}

interface discountDTOS {
  id: number;
  quantity: number;
  redemptionDate: Date;
  valueDiscount: number;
  name: string;
  description: string;
  remainingUses: number;
}

interface courseLocations {
  id: number;
  schedule_Date: Date;
  area: string;
}

interface CourseData {
  id: number;
  name: string;
  description: string;
  price: number;
  startDate: Date;
  endDate: Date;
  student_count: number;
  type: string;
  courseMediaInfos: courseMediaInfos[];
  discountDTOS: discountDTOS[];
  courseLocations: courseLocations[];
}
//   interface CourseData {
//     courseName: string;
//     description: string;
//     price: number;
//     startDate: string;
//     endDate: string;
//     studentCount: number;
//     type: string;
//     courseMediaInfos: {
//       courseMedia_id: number;
//       urlMedia: string;
//       urlImage: string;
//       thumbnailSrc: string;
//       title: string;
//     }[];
//     discountDTOS: {
//       courseDiscount_id: number;
//       quantity: number;
//       redemptionDate: string;
//       valueDiscount: number;
//       name: string;
//       description: string;
//       remainingUses: number;
//     }[];
//     courseLocation: {
//       courseLocation_id: number;
//       schedule_Date: string;
//       area: string;
//     }[];
//   }
export default CourseData;
