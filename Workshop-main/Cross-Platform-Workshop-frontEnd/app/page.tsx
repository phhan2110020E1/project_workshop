'use client'
import Banner from '@/components/Banner';
import Services from '@/components/Service';
import Card from '@/components/CardSlide';
import About from '@/components/About';
import Testimonials from '@/components/Rate';
import PricingCarousel from '@/components/PricingCarousel';
import Footer from '@/components/Footer';
import Navbar from '@/components/Navbar';

export default function Home() {
  return (
    <div>
      <Navbar/>
      <Banner />
      <PricingCarousel />
      <About />
      <Testimonials />
      <Services />
      <Card/>
      <Footer />
    </div>
  )
}