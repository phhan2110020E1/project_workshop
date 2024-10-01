import Image from "next/image";
import thumb from "../../public/next.svg";
import { FaReact } from "react-icons/fa";
import { SiTypescript } from "react-icons/si";
import { AiOutlineClockCircle } from "react-icons/ai";
import { VscChecklist } from "react-icons/vsc";
import { FaPlay } from "react-icons/fa";

import styles from '../buttons/button.module.css';

export default function Card_temp_2() {
    
    return (
        <div className="card-container">
          {/* <div className={styles.Badge}>
            <h1>FREE</h1>
          </div> */}
          <div className={styles.thumbnailContainer}>
            <div className="thumbnail">
              <Image
                src={thumb}
                alt="thumbnail"
              />
            </div>
          </div>
          <div className={styles.contentContainer}>
            <p className={styles.advancedTitle}>Advanced</p>
            <h1 className={styles.cardTitle}>
              React Native with TypeScript tutorial.
            </h1>
            <div className={styles.iconContainer}>
              <div className={styles.iconCustom}>
                <FaReact size={20} color="#61DBFB" />
                <h1 className={styles.darkIcon}>React Native</h1>
              </div>
              <div className={styles.iconCustom}>
                <SiTypescript size={20} color="#007acc" />
                <h1 className={styles.darkIcon}>TypeScript</h1>
              </div>
              </div>
            <div className={styles.iconContainer}>

              <div className={styles.iconCustom}>
                <AiOutlineClockCircle size={20} className="dark-icon" />
                <h1 className={styles.darkIcon}>32 Hour</h1>
              </div>
              <div className={styles.iconCustom}>
                <VscChecklist size={20} className="dark-icon" />
                <h1 className={styles.darkIcon}>5 Part</h1>
              </div>
            </div>
            <div  className={styles.actionContainer}>
              <button className={styles.actionButton}>
                <FaPlay className="animate-ping" size={10} color="#fff" />
                <h3 className={styles.StartText}>
                  Start Learning Now
                </h3>
              </button>
            </div>
          </div>
        </div>
      );
}
