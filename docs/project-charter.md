# PROJECT CHARTER
# NGHIÊN CỨU VÀ ĐÁNH GIÁ HIỆU NĂNG GIAO THỨC ĐỊNH TUYẾN AODV TRONG MẠNG MANET SỬ DỤNG NS-2

**Tên tiếng Anh:** Performance Evaluation of AODV Routing Protocol in MANET Using NS-2

**GitHub Repository:** https://github.com/anhxuan2712/MANET-AODV-NS2

**Phiên bản:** 1.2  
**Ngày cập nhật:** 14/11/2026  
**Trạng thái:** Đang chuẩn bị môi trường và triển khai mô phỏng

---

## 1. Thông tin dự án

| Hạng mục | Nội dung |
|---|---|
| Tên đề tài | Nghiên cứu và đánh giá hiệu năng giao thức định tuyến AODV trong mạng MANET sử dụng NS-2 |
| Lĩnh vực | Đánh giá hiệu năng mạng |
| Mô hình mạng | MANET (Mobile Ad Hoc Network) |
| Giao thức định tuyến | AODV |
| Công cụ mô phỏng | NS-2.35 |
| Hệ điều hành dự kiến | Ubuntu 24.04 |
| Số lượng thành viên | 6 |
| Kho mã nguồn | GitHub |
| Thời gian thực hiện | Khoảng 14 ngày |

## 2. Mục tiêu dự án

- Tìm hiểu kiến trúc và đặc điểm của mạng MANET.
- Nghiên cứu nguyên lý hoạt động của giao thức định tuyến AODV.
- Xây dựng mô hình mạng MANET trên NS-2.
- Thực hiện mô phỏng với các mức tốc độ di chuyển khác nhau của nút mạng.
- Thu thập và phân tích dữ liệu trace.
- Đánh giá hiệu năng AODV thông qua các chỉ số định lượng.
- Đưa ra nhận xét về ảnh hưởng của tốc độ di chuyển đến hiệu năng định tuyến.

## 3. Phạm vi nghiên cứu

**Phạm vi thực hiện:**

- Chỉ nghiên cứu giao thức định tuyến AODV.
- Sử dụng mô hình di chuyển Random Waypoint.
- Sử dụng lưu lượng UDP/CBR.
- Mô phỏng mạng gồm 20 nút.
- Thay đổi tốc độ di chuyển tối đa của nút mạng.
- Giữ các tham số khác cố định để đảm bảo tính so sánh.

**Ngoài phạm vi:**

- Không so sánh nhiều giao thức định tuyến.
- Không triển khai hệ thống MANET thực tế.
- Không nghiên cứu chuyên sâu các thuật toán tối ưu hóa AODV.

## 4. Môi trường và tham số mô phỏng dự kiến

| Tham số | Giá trị |
|---|---|
| NS-2 | 2.35 |
| Hệ điều hành | Ubuntu 24.04 |
| Số lượng nút | 20 |
| Kích thước khu vực | 500m × 500m |
| MAC | IEEE 802.11 |
| Routing Protocol | AODV |
| Mobility Model | Random Waypoint |
| Traffic | UDP/CBR |
| Packet Size | 512 bytes |
| Simulation Time | 100 giây |
| Pause Time | 5 giây |
| Queue | DropTail/PriQueue |
| Tốc độ di chuyển | 0, 5, 10, 15 m/s |

**Lưu ý:** Các thông số trên là cấu hình dự kiến. Khả năng tương thích của NS-2.35 với Ubuntu 24.04 và cách thiết lập trường hợp tốc độ 0 m/s phải được kiểm tra trong giai đoạn triển khai.

## 5. Các kịch bản mô phỏng

| Kịch bản | Số nút | Tốc độ tối đa |
|---|---:|---:|
| SC01 | 20 | 0 m/s |
| SC02 | 20 | 5 m/s |
| SC03 | 20 | 10 m/s |
| SC04 | 20 | 15 m/s |

Mỗi kịch bản chỉ thay đổi tốc độ di chuyển tối đa. Các tham số còn lại được giữ nguyên.

## 6. Các chỉ số đánh giá

1. **Packet Delivery Ratio (PDR):** Tỷ lệ gói tin dữ liệu gửi thành công đến đích.
2. **Packet Loss Ratio (PLR):** Tỷ lệ gói tin dữ liệu bị mất.
3. **Average End-to-End Delay:** Độ trễ trung bình đầu cuối của các gói tin nhận thành công.
4. **Throughput:** Thông lượng dữ liệu nhận được trong một đơn vị thời gian.
5. **Routing Overhead:** Chi phí gói tin điều khiển định tuyến phát sinh trong quá trình hoạt động.

Các chỉ số phải được tính từ trace theo định nghĩa thống nhất. Gói điều khiển AODV không được tính nhầm vào lưu lượng dữ liệu ứng dụng.

## 7. Phân công nhân sự

| Thành viên | Họ và tên | Nhiệm vụ |
|---|---|---|
| TV1 | Nguyễn Anh Xuân | Nhóm trưởng, nghiên cứu MANET/AODV, điều phối, tổng hợp nội dung và kiểm tra chất lượng |
| TV2 | Nguyễn Thành Đạt | Chuẩn bị môi trường Ubuntu, cài đặt NS-2.35, NAM, AWK và tài liệu cài đặt |
| TV3 | Nguyễn Phúc Vượng | Xây dựng mã Tcl, thiết lập topology, node, AODV, UDP/CBR và trace |
| TV4 | Nguyễn Minh Trí | Thiết lập kịch bản di chuyển, thực hiện các lần mô phỏng và quản lý kết quả đầu ra |
| TV5 | Kiều Đức Dương | Phân tích trace, viết AWK/Python, tính toán các chỉ số hiệu năng |
| TV6 | Lê Tuấn Anh | Trực quan hóa kết quả, xây dựng biểu đồ, tổng hợp báo cáo và slide |

Tất cả thành viên có trách nhiệm hiểu mô hình mô phỏng, nguyên lý AODV và ý nghĩa các chỉ số đánh giá.

## 8. Cấu trúc thư mục dự án

### 8.1. Sơ đồ cây thư mục chuẩn hóa

```text
MANET-AODV-NS2/
├── .gitignore                      # Cấu hình bỏ qua file trace lớn (*.tr, *.nam), file rác, virtualenv
├── README.md                       # Tài liệu tổng quan dự án, hướng dẫn thực hiện và ma trận thực nghiệm
├── docs/                           # Tài liệu quản lý, đề cương và nghiên cứu đề tài
│   ├── project-charter.md          # Bản điều lệ dự án, mục tiêu, phạm vi và phân công trách nhiệm
│   ├── setup-ns2-ubuntu.md         # Hướng dẫn cài đặt, cấu hình NS-2.35, NAM và AWK trên Ubuntu
│   ├── outline-report.md           # Đề cương chi tiết báo cáo kỹ thuật 5 chương
│   ├── meeting-notes.md            # Biên bản họp định kỳ và thống nhất nhóm
│   └── references.md               # Danh mục tài liệu tham khảo (RFC 3561, giáo trình, bài báo khoa học)
├── tcl/                            # Mã nguồn kịch bản mô phỏng mạng trên NS-2
│   ├── manet_aodv_base.tcl         # Script Tcl chính cấu hình mô hình mạng MANET, AODV, UDP/CBR
│   ├── run_simulation.sh           # Shell script tự động hóa chạy tuần tự 4 kịch bản mô phỏng
│   └── README.md                   # Hướng dẫn cách tham số hóa và thực thi mã Tcl
├── scenarios/                      # Cấu hình kịch bản mô phỏng phân theo tốc độ di chuyển
│   ├── SC01_speed_0/               # Kịch bản 1: Nút đứng yên (tốc độ tối đa 0 m/s)
│   │   ├── mobility_sc01.txt       # Kịch bản di chuyển (topology tĩnh)
│   │   └── traffic_cbr.txt         # Kịch bản luồng lưu lượng UDP/CBR (sinh bởi cbrgen)
│   ├── SC02_speed_5/               # Kịch bản 2: Tốc độ tối đa 5 m/s (di chuyển chậm)
│   │   ├── mobility_sc02.txt       # Kịch bản di chuyển Random Waypoint (sinh bởi setdest)
│   │   └── traffic_cbr.txt         # Kịch bản luồng lưu lượng UDP/CBR
│   ├── SC03_speed_10/              # Kịch bản 3: Tốc độ tối đa 10 m/s (di chuyển trung bình)
│   │   ├── mobility_sc03.txt
│   │   └── traffic_cbr.txt
│   └── SC04_speed_15/              # Kịch bản 4: Tốc độ tối đa 15 m/s (di chuyển nhanh)
│       ├── mobility_sc04.txt
│       └── traffic_cbr.txt
├── trace/                          # Dữ liệu xuất từ mô phỏng NS-2
│   ├── raw/                        # Lưu trữ file trace (.tr) và file mô phỏng NAM (.nam) nguyên bản
│   │   ├── trace_sc01_run01.tr
│   │   └── nam_sc01_run01.nam
│   └── processed/                  # Dữ liệu trace đã qua tiền xử lý, lọc bỏ header thừa và phân loại sự kiện
│       └── filtered_cbr_sc01.txt
├── analysis/                       # Công cụ phân tích trace và tính toán chỉ số hiệu năng
│   ├── calculate_metrics.awk       # Script AWK tính toán tổng hợp PDR, PLR, Delay, Throughput, Overhead
│   ├── analyze.py                  # Script Python tổng hợp thống kê kết quả đa lần chạy (mean, std)
│   ├── plot_charts.py              # Script Python tự động sinh các biểu đồ so sánh khoa học
│   └── requirements.txt            # Danh sách thư viện Python cần thiết (matplotlib, pandas, numpy, seaborn)
├── results/                        # Dữ liệu kết quả đầu ra phục vụ báo cáo
│   ├── metrics.csv                 # Bảng số liệu tổng hợp các chỉ số định lượng theo từng kịch bản
│   └── figures/                    # Biểu đồ so sánh chất lượng cao (.png, .pdf)
│       ├── fig_pdr.png             # Biểu đồ tỷ lệ phân phát gói tin thành công (PDR)
│       ├── fig_delay.png           # Biểu đồ độ trễ trung bình đầu cuối (End-to-End Delay)
│       ├── fig_throughput.png      # Biểu đồ thông lượng mạng (Throughput)
│       ├── fig_routing_overhead.png# Biểu đồ chi phí điều khiển định tuyến (Routing Overhead)
│       └── fig_packet_loss.png     # Biểu đồ tỷ lệ mất gói tin (Packet Loss Ratio)
├── screenshots/                    # Ảnh chụp minh chứng thực nghiệm và giao diện mô phỏng
│   ├── topology/                   # Ảnh trực quan hóa phân bố vị trí 20 nút trong khu vực 500m × 500m
│   ├── nam/                        # Ảnh chụp mô phỏng diễn tiến truyền gói tin và phát hiện tuyến trên NAM
│   └── terminal/                   # Ảnh chụp terminal chạy NS-2, phiên bản công cụ và kết quả script AWK
└── report/                         # Báo cáo nghiên cứu và sản phẩm thuyết trình
    ├── report.docx                 # Báo cáo khoa học hoàn chỉnh định dạng Word (theo cấu trúc 5 chương)
    ├── report.pdf                  # Bản PDF của báo cáo phục vụ nghiệm thu và in ấn
    └── slides.pptx                 # Slide thuyết trình bảo vệ đề tài
```

### 8.2. Bảng mô tả chức năng và phân công phụ trách thư mục

| Thư mục | Chức năng chính | Thành viên phụ trách |
|---|---|---|
| `docs/` | Lưu trữ tài liệu quy chuẩn, điều lệ, kế hoạch, hướng dẫn kỹ thuật và đề cương | TV1 (Leader), TV2 |
| `tcl/` | Chứa mã nguồn mô phỏng Tcl, kịch bản tạo nút, giao thức AODV và shell script chạy tự động | TV3 |
| `scenarios/` | Quản lý file di chuyển (mobility) và luồng dữ liệu (traffic) cho 4 kịch bản tốc độ | TV4 |
| `trace/` | Lưu trữ trace thô (`raw/`) và trace trích lọc (`processed/`), tuyệt đối không sửa đổi trace gốc | TV4, TV5 |
| `analysis/` | Chứa script AWK và Python để bóc tách trace, tính toán các chỉ số và vẽ biểu đồ | TV5, TV6 |
| `results/` | Lưu trữ bảng số liệu CSV chuẩn hóa và các hình vẽ biểu đồ đưa vào báo cáo | TV5, TV6 |
| `screenshots/` | Lưu trữ hình ảnh minh chứng kiểm thử môi trường, hoạt ảnh NAM và topology mạng | TV2, TV3, TV6 |
| `report/` | Chứa tài liệu báo cáo nghiên cứu hoàn chỉnh (Word/PDF) và slide trình chiếu | TV1, TV6 |

### 8.3. Quy tắc quản lý dữ liệu và mã nguồn

1. **Nguyên tắc bảo toàn dữ liệu gốc (Raw Data Integrity):**
   - File trace thô trong `trace/raw/` được sinh ra tự động bởi NS-2; tuyệt đối không mở chỉnh sửa thủ công hoặc ghi đè.
   - Mọi thao tác trích chọn, tính toán phải thực hiện thông qua script và lưu kết quả sang `trace/processed/` hoặc `results/`.
2. **Quy định kiểm soát phiên bản Git (.gitignore):**
   - File trace (`.tr`) và file NAM (`.nam`) có dung lượng rất lớn (hàng trăm MB đến vài GB), không được commit trực tiếp vào Git repository nhằm tránh làm phình dung lượng repo và gây lỗi đồng bộ.
   - Bắt buộc khai báo bỏ qua `trace/raw/*.tr`, `trace/raw/*.nam` trong `.gitignore`. Nhóm sẽ lưu trữ bản sao lưu trace thô trên đám mây (Google Drive/OneDrive) hoặc tái tạo lại bằng script `run_simulation.sh`.
3. **Quy ước đặt tên file đồng bộ:**
   - Script Tcl: `manet_aodv_<scenario>.tcl` (ví dụ: `manet_aodv_sc01.tcl`).
   - File trace: `trace_<scenario>_run<seed>.tr` (ví dụ: `trace_sc02_run01.tr`).
   - File NAM: `nam_<scenario>_run<seed>.nam` (ví dụ: `nam_sc02_run01.nam`).
   - Bảng kết quả: `metrics_<scenario>.csv`, `metrics.csv`.
   - Biểu đồ: `fig_<metric>.png` (ví dụ: `fig_pdr.png`, `fig_delay.png`).

## 9. Sản phẩm bàn giao

- Mã nguồn Tcl mô phỏng MANET sử dụng AODV.
- Các file trace của từng kịch bản.
- Công cụ AWK/Python phân tích dữ liệu.
- Bảng tổng hợp các chỉ số hiệu năng.
- Biểu đồ so sánh giữa các kịch bản.
- Báo cáo nghiên cứu.
- Slide thuyết trình.
- Repository GitHub lưu trữ mã nguồn và tài liệu dự án.

## 10. Kế hoạch thực hiện

| Giai đoạn | Công việc | Thời gian dự kiến |
|---|---|---|
| 1 | Chốt đề tài, phạm vi, phân công và khởi tạo repository | Ngày 1 |
| 2 | Cài đặt và kiểm tra NS-2.35 | Ngày 1–2 |
| 3 | Xây dựng mô hình mô phỏng Tcl | Ngày 3–4 |
| 4 | Kiểm tra topology và trace | Ngày 5–6 |
| 5 | Chạy các kịch bản mô phỏng | Ngày 7–9 |
| 6 | Phân tích và tính toán chỉ số | Ngày 9–11 |
| 7 | Xây dựng biểu đồ và hoàn thiện báo cáo | Ngày 11–13 |
| 8 | Kiểm thử, rà soát và thuyết trình | Ngày 14 |

## 11. Rủi ro và lưu ý

- NS-2.35 là phiên bản cũ, có thể gặp vấn đề tương thích với Ubuntu 24.04.
- NAM có thể gặp vấn đề hiển thị trên môi trường không có giao diện đồ họa.
- Cấu trúc trace cần được kiểm tra trước khi viết chương trình phân tích.
- Trường hợp tốc độ 0 m/s cần được xác minh cách mô phỏng phù hợp.
- Phải lưu lại cấu hình và seed của từng lần chạy để đảm bảo khả năng tái lập.
- Không được tự tạo hoặc điều chỉnh số liệu để làm đẹp kết quả.

## 12. Xác nhận dự án

| Vai trò | Người xác nhận | Trạng thái |
|---|---|---|
| Nhóm trưởng | Nguyễn Anh Xuân | Chờ xác nhận |
| Thành viên TV2 | Nguyễn Thành Đạt | Chờ xác nhận |
| Thành viên TV3 | Nguyễn Phúc Vượng | Chờ xác nhận |
| Thành viên TV4 | Nguyễn Minh Trí | Chờ xác nhận |
| Thành viên TV5 | Kiều Đức Dương | Chờ xác nhận |
| Thành viên TV6 | Lê Tuấn Anh | Chờ xác nhận |

**Ghi chú:** Project Charter là tài liệu thống nhất phạm vi, trách nhiệm và kế hoạch. Các thông số mô phỏng vẫn cần được kiểm chứng bằng thực nghiệm trước khi sử dụng làm kết quả chính thức.
