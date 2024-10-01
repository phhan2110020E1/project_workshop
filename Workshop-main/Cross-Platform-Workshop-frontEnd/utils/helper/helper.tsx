export default function UserList() {

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


  const getUserById = (userId: number, userList: UserData[]) => {
    return userList.find(user => user.id === userId);
  };
}