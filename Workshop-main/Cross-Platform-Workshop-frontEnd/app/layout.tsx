'use client'

import { Inter } from 'next/font/google'
import 'bootstrap/dist/css/bootstrap.css'
import AuthProvider from '@/app/component/Authprovider'
const inter = Inter({ subsets: ['latin'] })

export default function RootLayout({
  children,
}: {
  children: React.ReactNode
}) {
  return (
    <html lang="en">
      <AuthProvider>
        <body className={inter.className}>
          {children}
          </body>
      </AuthProvider>
    </html>
  )
}
