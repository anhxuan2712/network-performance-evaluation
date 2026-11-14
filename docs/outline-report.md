# ĐỀ CƯƠNG CHI TIẾT BÁO CÁO NGHIÊN CỨU

**Tên đề tài:** Nghiên cứu và đánh giá hiệu năng giao thức định tuyến AODV trong mạng MANET sử dụng NS-2  
**Người phụ trách chính:** Nguyễn Anh Xuân (TV1), Lê Tuấn Anh (TV6)

---

## Chương 1: Tổng quan đề tài
1.1. Bối cảnh và lý do nghiên cứu mạng MANET  
1.2. Mục tiêu nghiên cứu và câu hỏi nghiên cứu  
1.3. Đối tượng và phạm vi giới hạn của đề tài  
1.4. Phương pháp nghiên cứu và công cụ thực nghiệm  
1.5. Cấu trúc tổng thể của báo cáo  

## Chương 2: Cơ sở lý thuyết
2.1. Tổng quan về mạng ad-hoc di động (MANET)  
2.2. Giao thức định tuyến AODV (Ad hoc On-Demand Distance Vector)  
   - Cơ chế phát hiện tuyến (Route Discovery - RREQ, RREP)  
   - Cơ chế duy trì tuyến (Route Maintenance - RERR, HELLO)  
2.3. Các chỉ số đánh giá hiệu năng mạng  
   - Tỷ lệ phân phát gói tin (PDR)  
   - Tỷ lệ mất gói tin (Packet Loss Ratio)  
   - Độ trễ trung bình đầu cuối (Average End-to-End Delay)  
   - Thông lượng mạng (Throughput)  
   - Chi phí điều khiển định tuyến (Routing Overhead)  
2.4. Công cụ mô phỏng mạng NS-2 và trình diễn NAM  

## Chương 3: Thiết kế và xây dựng mô hình mô phỏng
3.1. Thiết lập thông số mạng mô phỏng (20 nút, 500m × 500m, IEEE 802.11)  
3.2. Cấu hình mô hình di chuyển Random Waypoint  
3.3. Cấu hình mô hình luồng dữ liệu ứng dụng UDP/CBR  
3.4. Thiết kế 4 kịch bản thực nghiệm biến đổi tốc độ (0, 5, 10, 15 m/s)  
3.5. Quy trình thu thập trace và quy tắc bóc tách dữ liệu  

## Chương 4: Kết quả thực nghiệm và phân tích đánh giá
4.1. Kết quả thực nghiệm từng kịch bản  
4.2. Bảng tổng hợp các chỉ số hiệu năng  
4.3. Phân tích đồ thị và xu hướng ảnh hưởng của tốc độ di chuyển  
   - Ảnh hưởng của tốc độ đến PDR và Packet Loss  
   - Ảnh hưởng của tốc độ đến Delay  
   - Ảnh hưởng của tốc độ đến Throughput  
   - Ảnh hưởng của tốc độ đến Routing Overhead  
4.4. Đánh giá tính tin cậy và hạn chế của mô hình  

## Chương 5: Kết luận và hướng phát triển
5.1. Tổng kết các kết quả đạt được  
5.2. Trả lời các câu hỏi nghiên cứu  
5.3. Đề xuất các hướng phát triển tiếp theo  
