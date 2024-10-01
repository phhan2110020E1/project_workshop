'use client'
import { Container } from "react-bootstrap";
import Card from "../ui/dashboard/card/card";
import Chart from "../ui/dashboard/chart/chart";
import styles from "../ui/dashboard/dashboard.module.css";
import Transactions from "../ui/dashboard/transactions/transactions";
import ApiService from '@/app/services/ApiService';
import { useSession } from 'next-auth/react';
import React, { useEffect, useState } from 'react';

const Dashboard = () => {
  const [cards, setCard] = useState( [
    {
      id: '',
      title: '',
      subtitle: '',
      total_numbe: '',
      week_number: '',
      change: '',
    },
    {
      id: '',
      title: '',
      subtitle: '',
      total_numbe: '',
      week_number: '',
      change: '',
    },
    {
      id: '',
      title: '',
      subtitle: '',
      total_numbe: '',
      week_number: '',
      change: '',
    },
    {
      id: '',
      title: '',
      subtitle: '',
      total_number: '',
      week_number: '',
      change: '',
    },
  ]);
  const { data: session } = useSession();
 
  const apiService = new ApiService(session);
  useEffect(() => {
    const fetchData = async () => {
      
      if (apiService != null) {
        try {
          const result = await apiService.dashboard();
          console.log(result.data);
          if (result.status === "success") {
            setCard((prevCards) => [
              {
                ...prevCards[0],
                id: '0' ?? prevCardss[0].id,
                title: 'Total User' ??  prevCardss[0].title,
                subtitle: 'User on Month' ??  prevCardss[0].subtitle,
                total_number: result.data.totalAccount ?? prevCards[0].total_number,
                week_number: result.data.newStudentThisMonth + result.data.newTeacherThisMonth ?? prevCards[0].total_number,
                change: result.data.ratioUser ?? prevCardss[0].change,
              },
              {
                ...prevCards[1],
                id: '1' ?? prevCardss[1].id,
                title: 'Total Workshop' ??  prevCardss[1].title,
                subtitle: 'Workshop on Month' ??  prevCardss[1].subtitle,
                total_number: result.data.totalCourses ?? prevCards[1].total_number,
                week_number: result.data.newCoursesThisMonth  ?? prevCards[1].total_number,
                change: result.data.ratioCourse ?? prevCardss[1].change,
              },
              {
                ...prevCards[2],
                id: '2' ?? prevCardss[2].id,
                title: 'Total Workshop Pricing' ??  prevCardss[2].title,
                subtitle: 'Pricing on Month' ??  prevCardss[2].subtitle,
                total_number: result.data.totalCoursesPricing + "$" ?? prevCards[2].total_number,
                week_number: result.data.coursesPricingThisMonth + "$"  ?? prevCards[2].total_number,
                change: result.data.ratioRevenue ?? prevCardss[2].change,
              }
              ,
              {
                ...prevCards[3],
                id: '2' ?? prevCardss[3].id,
                title: 'Total Revenue' ??  prevCardss[3].title,
                subtitle: 'Revenue on Month' ??  prevCardss[3].subtitle,
                total_number: result.data.totalRevenue + "$" ?? prevCards[3].total_number,
                week_number: result.data.revenueThisMonth + "$"  ?? prevCards[3].total_number,
                change: result.data.ratioRevenue ?? prevCardss[3].change,
              }
            ]);
          } else {
            console.error('Data is not an object:', result.data);
          }
        } catch (error) {
          console.error('Error fetching data:', error);
        }
      }
    };

    if (apiService != null) {
      fetchData();
    }
  }, [session]);

  return (
 <Container>
     <div className={styles.wrapper}>
      <div className={styles.main}>
        <div className={styles.cards}>
        {cards.map((item, index) => (
            <Card item={item} key={index} />
          ))}
        </div>
        <Transactions />
        <Chart />
       
      
      </div>
    </div>
 </Container>
  );
};

export default Dashboard;

