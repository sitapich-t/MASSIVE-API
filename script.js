// import http from 'k6/http';
// import { check, sleep } from 'k6';

// export const options = {
//   vus: 5,         // จำนวน Virtual Users
//   duration: '10s', // ระยะเวลาทดสอบ 10 วินาที
// };

// export default function () {
//   // เปลี่ยน URL ให้ชี้ไปยัง Endpoint จริงของ NestJS
//   const res = http.get('http://127.0.0.1:3000/');

//   check(res, {
//     'status is 200': (r) => r.status === 200,
//   });

//   sleep(1);
// }


import http from 'k6/http';
import { check, sleep } from 'k6';

export const options = {
  stages: [
    { duration: '10s', target: 20 }, // Ramp-up ขึ้นไปเป็น 20 VUs ใน 10 วินาที
    { duration: '20s', target: 50 }, // คงระดับไว้ที่ 50 VUs อีก 20 วินาที
    { duration: '10s', target: 0 },  // Ramp-down ลงเหลือ 0 VUs
  ],
};

export default function () {
  const res = http.get('http://127.0.0.1:3000/');
  check(res, { 'status is 200': (r) => r.status === 200 });
  sleep(1);
}