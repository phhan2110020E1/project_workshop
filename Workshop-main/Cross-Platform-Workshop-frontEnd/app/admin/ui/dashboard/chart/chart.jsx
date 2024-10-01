"use client"
import styles from './chart.module.css'
import {
  LineChart, Line, XAxis, YAxis, Tooltip, Legend, ResponsiveContainer,
  PolarGrid, PolarAngleAxis, PolarRadiusAxis, Radar, RadarChart
} from 'recharts';
import ApiService from '@/app/services/ApiService';
import { useSession } from 'next-auth/react';
import React, { useEffect, useState } from 'react';

const Chart = () => {
  const [datas, setDatas] = useState([
    {
      nameOfDay: '',
      requestApproved: '',
      requestPending: '',
      requestCancel: '',
      transactionDeposit: '',
      transactionWithdraw: '',
      transactionByWorkshop: '',
    }
  ]);
  const { data: session } = useSession();
  const apiService = new ApiService(session);
  useEffect(() => {
    const fetchData = async () => {
      if (apiService != null) {
        try {
          const result = await apiService.getWeeklyRecapbyIdAdmin();
          if (result.status === "success") {
            setDatas(result.data);
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
  console.log(datas);
  return (
    <div className={styles.container}>
      <h2 className={styles.title}>Weekly Recap</h2>

      <ResponsiveContainer width="100%" height="90%">
        <LineChart
          width={500}
          height={300}
          data={datas}
          margin={{
            top: 5,
            right: 30,
            left: 20,
            bottom: 5,
          }}
        >
          <XAxis dataKey="nameOfDay" />
          <YAxis />
          <Tooltip contentStyle={{ background: "#151c2c", border: "none" }} />
          <Legend />
          <Line type="monotone" dataKey="requestApproved" stroke="#8884d8" strokeDasharray="5 5" />
          <Line type="basis" dataKey="requestPending" stroke="#82ca9d" strokeDasharray="3 4 5 2" />
          <Line type="basisOpen" dataKey="requestCancel" stroke="#ff0000" strokeDasharray="2 2" /> 
          <Line type="natural" dataKey="transactionDeposit" stroke="#00ff00" strokeDasharray="8 4" /> 
          <Line type="linear" dataKey="transactionWithdraw" stroke="#ffff00" strokeDasharray="1 2 4 2" /> 
          <Line type="linear" dataKey="transactionByWorkshop" stroke="#ff00ff" strokeDasharray="10 3" /> 

        </LineChart>
      </ResponsiveContainer>
    </div>
  )
}

export default Chart