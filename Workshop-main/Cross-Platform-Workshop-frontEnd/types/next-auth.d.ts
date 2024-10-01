import NextAuth from "next-auth/next";
declare module "next-auth" {
    interface Session {
        user: {
            id: number;
            full_name: string;
            user_name: string;
            email: string;
            roles: string;
            phoneNumber: string;
            gender: string;
            accessToken: string;
            refreshToken: string;
            image: string;
            picture:string;
            userAddresses: userAddresses[];
            type: string;
            balance:number;
        };
       
    }
    interface userAddresses{
        state: string;
        city: string;
        address: string;
        postalCode: PositiveInt;
    }
}

declare module "next-auth/jwt" {
    interface JWT extends DefaultJWT {
        role: string,
    }
}
