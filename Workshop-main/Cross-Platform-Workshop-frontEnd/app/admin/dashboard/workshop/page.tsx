
'use client'
import Image from "next/image";
import Link from "next/link";
import styles from "@/app/admin/ui/dashboard/products/products.module.css";
import Search from "@/app/admin/ui/dashboard/search/search";
import Pagination from "@/app/admin/ui/dashboard/pagination/pagination";
import React, { useEffect, useState } from 'react';
import ApiService from '@/app/services/ApiService';
import { useSession } from 'next-auth/react';
import { BiCheckCircle, BiXCircle } from 'react-icons/bi';
import { Modal, Card } from 'react-bootstrap';
import Style from "./workshop.module.css";
import { useRouter } from "next/navigation";

interface CoursesData {
  id: number;
  name: string;
  public: boolean;
  price: number;
  student_count: number;
  description: string;
  startDate: number;
  endDate: number;
  courseLocations: courseLocations[];
  studentEnrollments: studentEnrollments[];
}

interface LocationData {
  id: number;
  name: string;
  address: string;
  description: string;
  statusAvailable: string;
}

interface courseLocations {
  id: number | null;
  area: string;
  locationDTO: locationDTO
}

interface locationDTO {
  id: number;
  name: string;
  address: string;
  description: string;
  statusAvailable: string;
}

interface studentEnrollments {
  id: number | null;
  name: string;
  address: string;
  city: string;
  postalCode: number;
}

const CoursesPage = () => {
  const { data: session } = useSession();
  const apiService = new ApiService(session);
  const [courses, setCourses] = useState<CoursesData[]>([]);
  const [location, setLocation] = useState<LocationData[]>([]);
  const [location_id, setLocation_id] = useState<number>();
  const [locationIds, setLocationIds] = useState<{ [key: number]: number }>({});


  const [showDetails, setShowDetails] = useState(false);
  const [selectedUser, setSelectedUser] = useState<CoursesData | null>(null);
  const [currentPage, setCurrentPage] = useState<number>(1);
  const [coursesPerPage] = useState<number>(5);
  const [searchTerm, setSearchTerm] = useState("");
  const route = useRouter();
  useEffect(() => {
    if (session) {
      const fetchData = async () => {
        try {
          const listCourseResponse = await apiService.listCourseAdmin();
          if (listCourseResponse.data) {
            setCourses(listCourseResponse.data);
          }
        } catch (error) {
          console.error("Error fetching courses:", error);
        }
      };
      fetchData();
    }
  }, [session]);
  console.log('courses', courses);


  useEffect(() => {
    if (session) {
      const fetchData = async () => {
        try {
          const listlocationResponse = await apiService.listLocation();
          if (listlocationResponse.data) {
            setLocation(listlocationResponse.data);
          }
        } catch (error) {
          console.error("Error fetching courses:", error);
        }
      };
      fetchData();
    }
  }, [session]);

  const handleTogglePublicStatus = (id: number) => {
    console.log("vao2 ham2 handleTogglePublicStatus");

    apiService.changeStatusCourse(id).then(() => {
      setCourses((prevUsers) => {
        return prevUsers.map((course) => {
          if (course.id === id) {
            return { ...course, public: !course.public };
          }
          return course;
        });
      });
      window.location.reload();
    });
  };

  const handleUserDetails = (user: CoursesData) => {
    setSelectedUser(user); // Set the selected user
    setShowDetails(true); // Show the user details modal
  };

  const handleCloseDetails = () => {
    setSelectedUser(null); // Clear the selected user
    setShowDetails(false); // Hide the user details modal
  };

  const UpdateLocationWorkshop = async (course_location_id: number, location_id: number) => {
    console.log("UpdateLocationWorkshop");
    const updatelocationResponse = await apiService.UpdateLocation(course_location_id, location_id);
    console.log('updatelocationResponse', updatelocationResponse);
    console.log('location_id', location_id);
    route.refresh();

  }
  //search
  const filteredCourses = courses.filter((course) =>
    course.name.toLowerCase().includes(searchTerm.toLowerCase())
  );
  // Pagination logic
  const indexOfLastCourse = currentPage * coursesPerPage;
  const indexOfFirstCourse = indexOfLastCourse - coursesPerPage;
  const currentCourse = filteredCourses.slice(indexOfFirstCourse, indexOfLastCourse);

  const paginate = (pageNumber: number) => setCurrentPage(pageNumber);

  return (
    <div className={styles.container}>
      <div className={styles.top}>
        <Search
          placeholder="Search for a Workshop..."
          value={searchTerm}
          onChange={(e) => setSearchTerm(e.target.value)} />
      </div>
      {currentCourse.length > 0 && (
        <>
          <table className={styles.table}>
            <thead className="text-center">
              <tr>
                <th>Workshop Name</th>
                <th>Price</th>
                <th>Description</th>
                <th>Start Date</th>
                <th>End Date</th>
                <th>Status</th>
                <th>Total students</th>
                <th>Actions</th>
              </tr>
            </thead>
            <tbody className="text-center">
              {currentCourse.map((course) => (
                <tr key={course.id}>
                  <td>{course.name}</td>
                  <td>{course.price}$</td>
                  <td>{course.description}</td>
                  <td>{new Date(course.startDate).toLocaleString('en-US', {
                    year: 'numeric',
                    month: '2-digit',
                    day: '2-digit',
                    hour: '2-digit',
                    minute: '2-digit',
                    second: '2-digit',
                  })}</td>
                  <td>{new Date(course.endDate).toLocaleString('en-US', {
                    year: 'numeric',
                    month: '2-digit',
                    day: '2-digit',
                    hour: '2-digit',
                    minute: '2-digit',
                    second: '2-digit',
                  })}</td>
                  <td>{course.public ?
                    (
                      <i>Enabled<BiCheckCircle color="green" size={30} /></i>
                    ) : (
                      <i>Disabled<BiXCircle color="red" size={30} /></i>
                    )}
                  </td>
                  <td>{course.student_count}</td>
                  <td>
                    <div className={styles.buttons}>
                      <button className={`${styles.button} ${styles.view}`} onClick={() => handleUserDetails(course)}>
                        View
                      </button>
                    </div>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
          <Pagination
            itemsPerPage={coursesPerPage}
            totalItems={courses.length}
            paginate={paginate}
            currentPage={currentPage}
          />
        </>

      )}

      {/* User Details Modal */}
      <Modal show={showDetails} onHide={handleCloseDetails}>
        <Modal.Header className={Style.container} closeButton>
          <Modal.Title>Workshop Details</Modal.Title>
        </Modal.Header>
        <Modal.Body className={Style.container}>
          {selectedUser && (
            <Card className={Style.container}>
              <Card.Body className={Style.form}>
                <Card.Title><text>Workshop Name : {selectedUser.name}</text></Card.Title>
                <Card.Title><text>Price :{selectedUser.price}$</text></Card.Title>
                <Card.Text><text>Description: {selectedUser.description}</text></Card.Text>
                <Card.Text><text>Start Date: {new Date(selectedUser.startDate).toLocaleString('en-US', {
                    year: 'numeric',
                    month: '2-digit',
                    day: '2-digit',
                    hour: '2-digit',
                    minute: '2-digit',
                    second: '2-digit',
                  })}</text></Card.Text>
                <Card.Text><text>End Date: {new Date(selectedUser.endDate).toLocaleString('en-US', {
                    year: 'numeric',
                    month: '2-digit',
                    day: '2-digit',
                    hour: '2-digit',
                    minute: '2-digit',
                    second: '2-digit',
                  })}</text></Card.Text>
                <Card.Text><text>Status: {selectedUser.public ?
                  (
                    <i>Enabled<BiCheckCircle color="green" size={30} /></i>
                  ) : (
                    <i>Disabled<BiXCircle color="red" size={30} /></i>
                  )}</text>
                  <button className={Style.btn2} onClick={() => handleTogglePublicStatus(selectedUser.id)}>Change</button>
                </Card.Text>
                <Card.Title><text>Locations</text></Card.Title>


                <ul>
                  {selectedUser.courseLocations && selectedUser.courseLocations.length > 0 ? (
                    selectedUser.courseLocations.map((courselocation, index) => (
                      <div key={index}>
                        <text>{courselocation.area},

                          {courselocation.locationDTO.name && (
                            <div>
                              {courselocation.locationDTO.name}
                            </div>
                          )}

                          {(!courselocation.locationDTO.name) && (
                            <div>
                              <select
                                name=""
                                id={courselocation.id?.toString()}
                                value={locationIds[courselocation.id!] || ''}
                                onChange={(e) => setLocationIds(prevLocationIds => ({
                                  ...prevLocationIds,
                                  [courselocation.id!]: parseInt(e.target.value, 10),
                                }))}
                              >
                                {location && location.length > 0 ? (
                                  location.map((location, index) => (
                                    <option key={index} value={location.id}>
                                      {location.name}
                                    </option>
                                  ))
                                ) : (
                                  <p>location null</p>
                                )}

                              </select>
                              <button className={Style.btn1} onClick={() => UpdateLocationWorkshop(courselocation.id!, locationIds[courselocation.id!]!)}> Verify</button>

                            </div>
                          )}
                        </text>
                      </div>
                    ))
                  ) : (
                    <p><em>Không liệu khu vực.</em></p>
                  )}

                </ul>
                <Card.Title><text>Student Enrollments</text></Card.Title>
                <text><ul>
                  {selectedUser.studentEnrollments.map((teacher, index) => (
                    <li key={index}>
                      {teacher.name},
                    </li>
                  ))}
                </ul>
                </text>
              </Card.Body>
            </Card>
          )}
        </Modal.Body>
      </Modal >
    </div >
  );
};

export default CoursesPage;
