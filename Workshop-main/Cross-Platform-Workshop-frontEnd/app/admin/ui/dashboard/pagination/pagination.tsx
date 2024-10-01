"use client";

import styles from "./pagination.module.css";
import { usePathname, useRouter, useSearchParams } from "next/navigation";
import React from 'react';

interface PaginationProps {
  itemsPerPage: number;
  totalItems: number;
  currentPage: number;
  paginate: (pageNumber: number) => void;
}

const Pagination: React.FC<PaginationProps> = ({ itemsPerPage, totalItems, currentPage, paginate }) => {
  const pageNumbers = [];

  for (let i = 1; i <= Math.ceil(totalItems / itemsPerPage); i++) {
    pageNumbers.push(i);
  }

  return (
    <div className={styles.container}>
      <button
        className={`${styles.button}${currentPage === 1 ? 'disabled' : ''}`} 
        onClick={() => paginate(currentPage - 1)}
        disabled={currentPage === 1}
        >
        Previous
      </button>
      <button
        className={`${styles.button}${currentPage === Math.ceil(totalItems / itemsPerPage) ? 'disabled' : ''}`} 
        onClick={() => paginate(currentPage + 1)}
        disabled={currentPage === Math.ceil(totalItems / itemsPerPage)}
        >
        Next
      </button>
    </div>
  );
};

export default Pagination;
