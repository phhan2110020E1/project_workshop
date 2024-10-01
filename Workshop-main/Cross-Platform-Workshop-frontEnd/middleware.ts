import { withAuth, NextRequestWithAuth } from "next-auth/middleware"
import { NextResponse } from "next/server"
export default withAuth(
    function middleware(request: NextRequestWithAuth) {
        console.log("Role đang truy cập :",request.nextauth.token?.roles)
        console.log("Đường dẫn đang truy cập :",request.nextUrl.pathname)
        if (request.nextUrl.pathname.startsWith("/teacher")) 
        {
            if (Array.isArray(request.nextauth.token?.roles) && request.nextauth!.token!.roles.includes("SELLER")) 
            {
            } 
            else {
                return NextResponse.rewrite(new URL("/login", request.url));
            }
        }
        if (request.nextUrl.pathname.startsWith("/user")){
            if (Array.isArray(request.nextauth.token?.roles) && (request.nextauth!.token!.roles.includes("USER"))) {
   
            } 
            else {
                return NextResponse.rewrite(new URL("/login", request.url));
            }
        }
        if(request.nextUrl.pathname.startsWith("/admin")){
            if(Array.isArray(request.nextauth.token?.roles) && request.nextauth.token?.roles.includes("ADMIN"))
            {

            }
            else{
                return NextResponse.rewrite(new URL("/login", request.url));
            }
        }
    },{
        callbacks: {
            authorized: ({ token }) => !!token
        },
        secret: process.env.NEXTAUTH_SECRET
    }
)

export const config = { matcher: ["/teacher/:path*",
                                "/user/:path*",
                                "/admin/:path*"] }