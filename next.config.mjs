/** @type {import('next').NextConfig} */
const nextConfig = {
  reactStrictMode: true,
  async redirects() {
    return [{ source: "/calculator", destination: "/finder", permanent: true }];
  },
};

export default nextConfig;
