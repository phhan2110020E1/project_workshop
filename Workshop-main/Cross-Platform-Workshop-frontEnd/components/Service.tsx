import Image from 'next/image';
import Link from "next/link";
import styles from '../CSS/home.module.css';
import 'bootstrap/dist/css/bootstrap.min.css';

function Services() {
  return (
    <div id="services" className="services section">
      <div className="container">
        <div className="row d-flex justify-content-center align-items-center">
          <div className="col-lg-8 offset-lg-2">
            <Image src="/services-right-dec.png"className={styles.customimage} alt="Custom Image" width={1056} height={226} />

            <div className={`${styles.sectionHeadingService} wow fadeInDown`} data-wow-duration="1s" data-wow-delay="0.5s">
              <h4 className="text-center custom-spacing">
              Unlock Your <em className={styles.emm}>Creativity</em> with Our <em className={styles.emm}>Inspiring</em> Workshops!
              </h4>
              <div className="d-flex justify-content-center">
                <Image src="/heading-line-dec.png" alt="Ảnh" width={45} height={2} />
              </div>
              <p className={styles.pText}>
    Explore a world of creativity in our workshops! Join us for an immersive experience where you can unleash your artistic potential and learn new skills. Whether you're interested in design, photography, writing, or crafting, our workshops offer a diverse range of activities to spark your creativity.
</p>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}

export default Services;
