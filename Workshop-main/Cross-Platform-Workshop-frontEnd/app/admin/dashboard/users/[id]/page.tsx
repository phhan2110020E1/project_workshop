'use client'
import ApiService from "@/app/services/ApiService";
import styles from "@/app/admin/ui/dashboard/users/singleUser/singleUser.module.css";
import Image from "next/image";
import React, { useEffect, useState } from "react";
import { useSession } from "next-auth/react";
import { LiaTransgenderSolid } from 'react-icons/lia';
import Link from "next/link";

interface UserData {
  id: number;
  full_name: string;
  user_name: string;
  email: string;
  phoneNumber: string;
  image_url: string | null;
  gender: string;
  roles: string[];
  enable: boolean;
  userAddresses: UserAddress[];
}

interface UserAddress {
  id: number | null;
  state: string;
  address: string;
  city: string;
  postalCode: number;
}

const SingleUserPage = ({ params }) => {
  const { id } = params;
  const { data: session } = useSession();
  const apiService = new ApiService(session);
  const [user, setUser] = useState<UserData | null>(null);

  useEffect(() => {
    const fetchUser = async () => {
      try {

        if (id && session) {
          const user = await apiService.getUserbyIdAdmin(id);
          setUser(user.data);
        }

      } catch (error) {
        console.error("Error fetching user details:", error);
      }
    };

    fetchUser();
  }, [session]);

  if (!user) {
    return <div>Loading...</div>;
  }
  console.log('user', user)

  return (
    <div className={styles.container}>
      <div className={styles.infoContainer}>
        <div className={styles.imgContainer}>
          <Image
            src={user.image_url || "/noavatar.png"}
            alt=""
            className={styles.userImage}
            fill
          />
        </div>
        {user.full_name}
      </div>
      <div className={styles.formContainer}>
        <form className={styles.form}>
          <input type="hidden" name="id" value={user.id} />
          <label>Username:</label>
          <h4>{user.full_name}</h4>
          <label>Role:</label>
          <h4>{user.roles}</h4>
          <label>Gender:</label>
          {user.gender !== null ? <h4>{user.gender}</h4> : <h4><LiaTransgenderSolid/></h4>}
          <label>Email:</label>
          <h4>{user.email}</h4>
          <label>Phone:</label>
          <h4>{user.phoneNumber}</h4>
          <label>Status:</label>
          <h4>{user.enable ? 'Actived' : 'Passived'}</h4>
          {/* Render user addresses */}
          {user.userAddresses.map((address, index) => (
            <div>
              <label>Address {index + 1}:</label>
              <h4>{address.address}, {address.city}, {address.state} - {address.postalCode}</h4>
            </div>
          ))}
          
        </form>
        <div className="button"> <Link href={'/admin/dashboard/users'}><button className={styles.btn1}>Back</button></Link>
        </div>
      </div>
    </div>
  );
};



export default SingleUserPage;
