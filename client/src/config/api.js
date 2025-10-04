// API Configuration
const API_BASE_URL = process.env.NODE_ENV === 'production' 
  ? '/api'  // In production, use nginx proxy
  : 'http://localhost:5000/api'; // In development, use direct backend

export default API_BASE_URL;