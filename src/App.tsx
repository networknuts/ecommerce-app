import React from 'react';
import { ShoppingBag, Search, ShoppingCart, User } from 'lucide-react';

function App() {
  return (
    <div className="min-h-screen bg-white">
      {/* Header */}
      <header className="border-b">
        <div className="container mx-auto px-4 py-4">
          <div className="flex items-center justify-between">
            <div className="flex items-center space-x-8">
              <div className="flex items-center">
                <ShoppingBag className="h-8 w-8" />
                <span className="ml-2 text-2xl font-bold">playfair</span>
              </div>
              <nav className="hidden md:flex space-x-6">
                <a href="/catalog" className="text-gray-600 hover:text-black">New Arrivals</a>
                <a href="/catalog?category=t-shirts" className="text-gray-600 hover:text-black">T-Shirts</a>
                <a href="/catalog?category=jeans" className="text-gray-600 hover:text-black">Jeans</a>
                <a href="/catalog?category=dresses" className="text-gray-600 hover:text-black">Dresses</a>
              </nav>
            </div>
            <div className="flex items-center space-x-6">
              <button className="text-gray-600 hover:text-black">
                <Search className="h-6 w-6" />
              </button>
              <button className="text-gray-600 hover:text-black">
                <ShoppingCart className="h-6 w-6" />
              </button>
              <button className="text-gray-600 hover:text-black">
                <User className="h-6 w-6" />
              </button>
            </div>
          </div>
        </div>
      </header>

      {/* Hero Section */}
      <section className="relative h-[600px] bg-gray-100">
        <img
          src="https://images.unsplash.com/photo-1441984904996-e0b6ba687e04?auto=format&fit=crop&w=2000"
          alt="Hero"
          className="w-full h-full object-cover"
        />
        <div className="absolute inset-0 bg-black bg-opacity-40 flex items-center justify-center">
          <div className="text-center text-white">
            <h1 className="text-5xl font-bold mb-4">Summer Collection 2024</h1>
            <p className="text-xl mb-8">Discover the latest trends in fashion</p>
            <a
              href="/catalog"
              className="bg-white text-black px-8 py-3 rounded-md hover:bg-gray-100 transition-colors"
            >
              Shop Now
            </a>
          </div>
        </div>
      </section>

      {/* Featured Categories */}
      <section className="py-16">
        <div className="container mx-auto px-4">
          <h2 className="text-3xl font-bold mb-8 text-center">Shop by Category</h2>
          <div className="grid grid-cols-1 md:grid-cols-3 gap-8">
            <div className="relative h-[400px] group cursor-pointer">
              <img
                src="https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?auto=format&fit=crop&w=800"
                alt="T-Shirts"
                className="w-full h-full object-cover"
              />
              <div className="absolute inset-0 bg-black bg-opacity-20 group-hover:bg-opacity-30 transition-all">
                <div className="absolute bottom-8 left-8">
                  <h3 className="text-white text-2xl font-bold">T-Shirts</h3>
                </div>
              </div>
            </div>
            <div className="relative h-[400px] group cursor-pointer">
              <img
                src="https://images.unsplash.com/photo-1542272604-787c3835535d?auto=format&fit=crop&w=800"
                alt="Jeans"
                className="w-full h-full object-cover"
              />
              <div className="absolute inset-0 bg-black bg-opacity-20 group-hover:bg-opacity-30 transition-all">
                <div className="absolute bottom-8 left-8">
                  <h3 className="text-white text-2xl font-bold">Jeans</h3>
                </div>
              </div>
            </div>
            <div className="relative h-[400px] group cursor-pointer">
              <img
                src="https://images.unsplash.com/photo-1572804013309-59a88b7e92f1?auto=format&fit=crop&w=800"
                alt="Dresses"
                className="w-full h-full object-cover"
              />
              <div className="absolute inset-0 bg-black bg-opacity-20 group-hover:bg-opacity-30 transition-all">
                <div className="absolute bottom-8 left-8">
                  <h3 className="text-white text-2xl font-bold">Dresses</h3>
                </div>
              </div>
            </div>
          </div>
        </div>
      </section>

      {/* Footer */}
      <footer className="bg-gray-100">
        <div className="container mx-auto px-4 py-12">
          <div className="grid grid-cols-1 md:grid-cols-4 gap-8">
            <div>
              <h4 className="text-lg font-bold mb-4">About Playfair</h4>
              <p className="text-gray-600">Modern fashion for the contemporary individual.</p>
            </div>
            <div>
              <h4 className="text-lg font-bold mb-4">Customer Service</h4>
              <ul className="space-y-2">
                <li><a href="#" className="text-gray-600 hover:text-black">Contact Us</a></li>
                <li><a href="#" className="text-gray-600 hover:text-black">Shipping Info</a></li>
                <li><a href="#" className="text-gray-600 hover:text-black">Returns</a></li>
                <li><a href="#" className="text-gray-600 hover:text-black">FAQ</a></li>
              </ul>
            </div>
            <div>
              <h4 className="text-lg font-bold mb-4">Quick Links</h4>
              <ul className="space-y-2">
                <li><a href="#" className="text-gray-600 hover:text-black">New Arrivals</a></li>
                <li><a href="#" className="text-gray-600 hover:text-black">Sale</a></li>
                <li><a href="#" className="text-gray-600 hover:text-black">Gift Cards</a></li>
                <li><a href="#" className="text-gray-600 hover:text-black">Store Locator</a></li>
              </ul>
            </div>
            <div>
              <h4 className="text-lg font-bold mb-4">Newsletter</h4>
              <p className="text-gray-600 mb-4">Subscribe to receive updates, access to exclusive deals, and more.</p>
              <input
                type="email"
                placeholder="Enter your email"
                className="w-full px-4 py-2 rounded-md border border-gray-300 focus:outline-none focus:ring-2 focus:ring-black"
              />
            </div>
          </div>
          <div className="border-t mt-12 pt-8">
            <p className="text-center text-gray-600">© 2024 Playfair. All rights reserved.</p>
          </div>
        </div>
      </footer>
    </div>
  );
}

export default App;