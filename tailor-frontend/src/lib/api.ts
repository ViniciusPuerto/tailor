import axios, { AxiosRequestConfig } from 'axios';

const baseURL =
  typeof window === 'undefined'
    ? process.env.API_INTERNAL_URL || 'http://tailor_api:4000/api'
    : process.env.NEXT_PUBLIC_API_URL || 'http://localhost:4000/api';

const api = axios.create({
  baseURL,
  headers: {
    'Content-Type': 'application/json',
  },
});

// Attach token to every request (client side)
if (typeof window !== 'undefined') {
  api.interceptors.request.use((config) => {
    const token = localStorage.getItem('token');
    if (token) {
      config.headers = config.headers || {};
      config.headers['Authorization'] = `Bearer ${token}`;
    }
    return config;
  });
}

export default api; 