// بسم الله الرحمن الرحيم
// la ilaha illa Allah Mohammed Rassoul Allah
/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [ "./*.html" ],
  theme: {
    extend: {
      colors: {
        // Primary is gold
        primary: {
          light: '#FFD966', // A lighter gold for highlights
          DEFAULT: '#C48D00', // Main gold, luxurious and majestic
          dark: '#8F6600', // A darker gold for depth
        },
        // Secondary colors for harmony
        secondary: {
          light: '#295D7E', // Lighter deep blue
          DEFAULT: '#1B3A4B', // Main deep blue for calm and contrast
          dark: '#10222E', // Darker blue for elegance
        },
        accent: {
          light: '#0A8F4F', // Lighter emerald green
          DEFAULT: '#046A38', // Main emerald green for spiritual richness
          dark: '#034C29', // Darker green for depth
        },
        background: {
          DEFAULT: '#F4EBD9', // Sand beige, neutral and calming
          dark: '#E6DBC8', // Slightly darker for contrast
        },
        text: {
          DEFAULT: '#2B2B2B', // Charcoal gray for high readability
          light: '#404040', // Softer gray for secondary text
        },
        muted: '#A6A6A6', // Muted gray for borders or placeholders
        highlight: '#FFD700', // Brighter gold for accents
      },
      borderRadius: {
        brand: '20px', // Custom rounded corners for the brand
      },
    },
  },
  plugins: [],
}

