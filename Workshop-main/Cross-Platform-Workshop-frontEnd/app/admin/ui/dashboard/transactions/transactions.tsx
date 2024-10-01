'use client'
import Image from "next/image";
import styles from "./transactions.module.css";
import React, { useEffect, useState } from 'react';
import ApiService from '@/app/services/ApiService';
import { useSession } from 'next-auth/react';

interface TransactionData {
  id: number;
  type: string;
  status: boolean;
  transactionDate: string;
  amount: number;
  user_Name: string;
}

const Transactions = () => {
  const { data: session } = useSession();
  const apiService = new ApiService(session);
  const [transactions, setTransactions] = useState<TransactionData[]>([]);

  useEffect(() => {
    if (session) {
      const fetchData = async () => {
        try {
          const listTransactionResponse = await apiService.listTransactionAdmin(); // Adjust to the actual method in your ApiService
          if (listTransactionResponse.data) {
            console.log('data', listTransactionResponse);
            setTransactions(listTransactionResponse.data);
          }
        } catch (error) {
          console.error("Error fetching transaction:", error);
        }
      };
      fetchData();
    }
  }, [session]);

  return (
    <div className={styles.container}>
      <h2 className={styles.title}>Latest Transactions</h2>
      <table className={styles.table}>
      <thead className="text-center">
        <tr>
            <td>Name</td>
            <td>Type</td>
            <td>Status</td>
            <td>Date</td>
            <td>Amount</td>
          </tr>
        </thead>
        <tbody className="text-center">
        {transactions.slice(-4).reverse().map((transaction) => (
            <tr key={transaction.id}>
              <td>
                <div>
                  {transaction.user_Name}
                </div>
              </td>
              <td>{transaction.type}</td>
              <td>
              <span className={`${styles.status} ${styles.done}`}>{transaction.status}</span>
            </td>
              <td>
                {new Date(transaction.transactionDate).toLocaleString('en-US', {
                  year: 'numeric',
                  month: '2-digit',
                  day: '2-digit',
                  hour: '2-digit',
                  minute: '2-digit',
                  second: '2-digit',
                })}

              </td>
              <td>{transaction.amount}</td>
              <td></td>

              <td>
                <div className={styles.buttons}>
                </div>
              </td>
            </tr>
          ))}
        </tbody>
        
      </table>
    </div>
  );
};

export default Transactions;
