export default interface UserInfoResponse {
    id: number;
    full_name: string;
    user_name: string;
    email: string;
    phoneNumber: string;
    image_url: string;
    gender: string;
    roles: string[];
    enable: boolean;
    userAddresses: UserAddress[];
}
export class UserAddress {
    id: number;
    address: string;
    city: string;
    state: string;
    postalCode: number;

    constructor(data: any) {
        this.id = data.id;
        this.address = data.address;
        this.city = data.city;
        this.state = data.state;
        this.postalCode = data.postalCode;
    }
}
