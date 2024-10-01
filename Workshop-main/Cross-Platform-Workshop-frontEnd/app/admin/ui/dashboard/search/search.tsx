'use client'
import { MdSearch } from "react-icons/md";
import { ChangeEvent } from "react";
import styles from "./search.module.css";

interface SearchProps {
  placeholder: string;
  value?: string;
  onChange?: (event: ChangeEvent<HTMLInputElement>) => void;
}

const Search: React.FC<SearchProps> = ({ placeholder, value, onChange }) => {
  return (
    <div className={styles.container}>
      <MdSearch />
      <input
        type="text"
        placeholder={placeholder}
        className={styles.input}
        value={value}
        onChange={onChange}
      />
    </div>
  );
};

export default Search;
