
'use client'
import styles from "@/app/admin/dashboard/rating&comment/rating&comment.module.css";
import Search from "@/app/admin/ui/dashboard/search/search";
import Pagination from "@/app/admin/ui/dashboard/pagination/pagination";
import React, { useEffect, useState } from 'react';
import ApiService from '@/app/services/ApiService';
import { useSession } from 'next-auth/react';
import Image from "next/image";
import { Rate } from "antd";


interface TransactionData {
  rating_id: number;
  targetType: string;
  workshop_name: string;
  workshop_img: string;
  mentor_name: string;
  mentor_img: string;
  user_comment_name: string;
  user_comment_img: string;
  rating: number;
  comment: string;
  status: boolean;
}
const RatingPage = () => {
  const { data: session } = useSession();
  const apiService = new ApiService(session);
  const [ratings, setRatings] = useState<TransactionData[]>([]);
  const [currentPage, setCurrentPage] = useState<number>(1);
  const [transactionsPerPage] = useState<number>(5);
  const [searchTerm, setSearchTerm] = useState<string>('');
  const [searchBy, setSearchBy] = useState<'Workshop' | 'Mentor'>('Workshop'); // Default to Workshop

  useEffect(() => {
    if (session) {
      const fetchData = async () => {
        try {
          const listRatingResponse = await apiService.listRatingAdmin(); // Adjust to the actual method in your ApiService
          if (listRatingResponse.data) {
            console.log('data', listRatingResponse);
            setRatings(listRatingResponse.data);
          }
        } catch (error) {
          console.error("Error fetching courses:", error);
        }
      };
      fetchData();
    }
  }, [session]);

  const handleButtonClick = (id: number) => {
    apiService.changeStatusRate(id).then(() => {
      setRatings((prevRate) => {
        return prevRate.map((rating) => {
          if (rating.rating_id === id) {
            rating.status = !rating.status;
          }
          return rating;
        });
      });
    });
  };


  // Pagination logic
  const indexOfLastRating = currentPage * transactionsPerPage;
  const indexOfFirstRating = indexOfLastRating - transactionsPerPage;
  const currentRating = ratings.slice(indexOfFirstRating, indexOfLastRating);

  const paginate = (pageNumber: number) => setCurrentPage(pageNumber);


  console.log('id', ratings);

  return (
    <div className={styles.container}>
      <div className={styles.top}>
        <Search placeholder="Search Workshop or Mentor..." value={searchTerm} onChange={(e) => setSearchTerm(e.target.value)} />
      </div>
      <div className={styles.targetType}>
        <button
          className={searchBy === 'Workshop' ? styles.button : styles.selectedButton}
          onClick={() => setSearchBy('Workshop')}
        >
          Workshop
        </button>
        <button
          className={searchBy === 'Mentor' ? styles.button : styles.selectedButton}
          onClick={() => setSearchBy('Mentor')}
        >
          Mentor
        </button>
      </div>
      {currentRating.length > 0 && (
        <>
          <table className={styles.table}>
            <thead className="text-center">
              <tr>
                {searchBy === 'Workshop' ? (
                  <>
                    <th>Workshop</th>
                    <th>Voters</th>
                  </>
                ) : (
                  <>
                    <th>Mentor</th>
                    <th>Voters</th>
                  </>
                )}
                <th>Rating & Comment</th>
                <th>Status</th>
                <th>Action</th>
              </tr>
            </thead>
            <tbody className="text-center">
              {currentRating
                .filter((rating) => {
                  const isWorkshop = searchBy === 'Workshop' && rating.targetType === 'WORKSHOP';
                  const isMentor = searchBy === 'Mentor' && rating.targetType === 'MENTOR';
                  
                  const containsSearchTerm =
                    (isWorkshop && rating.workshop_name.toLowerCase().includes(searchTerm.toLowerCase())) ||
                    (isMentor && rating.mentor_name.toLowerCase().includes(searchTerm.toLowerCase()));
                
                  return (isWorkshop || isMentor) && containsSearchTerm;
                }).map((rating) => (
                  <tr key={rating.rating_id}>
                    <td>
                      {searchBy === 'Workshop' ? (
                        // Display Workshop-specific data
                        <div className={styles.user}>
                          <Image
                            src={rating.workshop_img || '/noavatar.png'}
                            alt=""
                            width={40}
                            height={40}
                            className={styles.workshopImage}
                          />
                          {rating.workshop_name}
                        </div>
                      ) : (
                        // Display Mentor-specific data
                        <div className={styles.user}>
                          <Image
                            src={rating.mentor_img || '/noavatar.png'}
                            alt=""
                            width={40}
                            height={40}
                            className={styles.userImage}
                          />
                          {rating.mentor_name}
                        </div>
                      )}
                    </td>
                    <td>
                      <div className={styles.user}>
                        <Image
                          src={rating.user_comment_img || '/noavatar.png'}
                          alt=""
                          width={40}
                          height={40}
                          className={styles.userImage}
                        />
                        {rating.user_comment_name}
                      </div>
                    </td>
                    <td><Rate defaultValue={rating.rating} allowHalf disabled className={`${styles.status} ${styles.customRate}`} /><br />
                      {rating.comment}</td>

                    <td>
                      {rating.status ? 'Published' : 'Disabled'}
                    </td>
                    <td className={styles.change}>
                      <button className={`${styles.button} ${styles.delete}`} onClick={(e) => {
                        e.stopPropagation(); // Stop propagation to prevent the row click event
                        handleButtonClick(rating.rating_id);
                      }}>
                        Change_Status
                      </button>
                    </td>
                  </tr>
                ))}
            </tbody>
          </table>
          <Pagination
            itemsPerPage={transactionsPerPage}
            totalItems={ratings.length}
            paginate={paginate}
            currentPage={currentPage}
          />
        </>

      )
      }
    </div >
  );
};

export default RatingPage;
