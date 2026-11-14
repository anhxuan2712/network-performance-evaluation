# Hướng Dẫn Sử Dụng Script Mô Phỏng Tcl Trên NS-2.35

**Thành viên phụ trách:** Nguyễn Phúc Vượng (TV3), Nguyễn Minh Trí (TV4)

---

## 1. Cấu trúc thư mục `tcl/`

- `manet_aodv_base.tcl`: Script Tcl mô phỏng cốt lõi mạng MANET 20 nút với giao thức định tuyến AODV. Script hỗ trợ nhận cờ dòng lệnh linh hoạt (`-sc`, `-speed`, `-seed`, `-tr`, `-nam`, `-mob`, `-traffic`) hoặc chạy tự động với giá trị mặc định.
- `run_simulation.sh`: Shell script tự động hóa chạy tuần tự cả 4 kịch bản `SC01` (0 m/s), `SC02` (5 m/s), `SC03` (10 m/s), `SC04` (15 m/s) và tự động xuất các file trace sang `../trace/raw/`.

---

## 2. Thông số mô phỏng chính

| Tham số | Giá trị |
|---|---|
| Số nút mạng (Number of Nodes) | 20 |
| Phạm vi khu vực (Topography) | 500m × 500m |
| Chuẩn MAC | IEEE 802.11 |
| Giao thức định tuyến (Routing) | AODV |
| Hàng đợi (Queue) | DropTail/PriQueue (50 packets) |
| Mô hình truyền sóng | TwoRayGround |
| Mô hình di chuyển (Mobility) | Random Waypoint (Pause time = 5.0s) |
| Tốc độ di chuyển tối đa | SC01: 0 m/s, SC02: 5 m/s, SC03: 10 m/s, SC04: 15 m/s |
| Lưu lượng (Traffic Pattern) | UDP / CBR (Packet size: 512 bytes, 4 luồng kết nối) |
| Thời gian mô phỏng | 100.0 giây |

---

## 3. Cách chạy mô phỏng

### Cách 1: Chạy tự động toàn bộ 4 kịch bản (Khuyến nghị)

```bash
cd tcl
chmod +x run_simulation.sh
./run_simulation.sh
```

Kết quả sẽ sinh ra 4 file trace (`.tr`) và 4 file đồ họa (`.nam`) trong thư mục `trace/raw/`:
- `trace_sc01_run01.tr`, `nam_sc01_run01.nam`
- `trace_sc02_run01.tr`, `nam_sc02_run01.nam`
- `trace_sc03_run01.tr`, `nam_sc03_run01.nam`
- `trace_sc04_run01.tr`, `nam_sc04_run01.nam`

### Cách 2: Chạy đơn lẻ một kịch bản với cờ tùy biến

```bash
cd tcl

# Chạy kịch bản SC01 (tốc độ 0 m/s):
ns manet_aodv_base.tcl -sc SC01 -speed 0 -seed 1 -tr ../trace/raw/trace_sc01_run01.tr -nam ../trace/raw/nam_sc01_run01.nam

# Chạy kịch bản SC03 (tốc độ 10 m/s):
ns manet_aodv_base.tcl -sc SC03 -speed 10 -seed 1 -tr ../trace/raw/trace_sc03_run01.tr -nam ../trace/raw/nam_sc03_run01.nam
```

### Cách 3: Nạp kịch bản di chuyển ngoài (tạo từ `setdest`) và luồng ngoài (từ `cbrgen`)

```bash
ns manet_aodv_base.tcl -sc SC02 -speed 5 -seed 1 \
   -mob ../scenarios/SC02_speed_5/mobility_sc02.txt \
   -traffic ../scenarios/SC02_speed_5/traffic_cbr.txt \
   -tr ../trace/raw/trace_sc02_run01.tr \
   -nam ../trace/raw/nam_sc02_run01.nam
```

---

## 4. Xem mô phỏng trực quan bằng NAM

Sau khi chạy xong, có thể mở file `.nam` bằng lệnh:
```bash
nam ../trace/raw/nam_sc01_run01.nam
```
- Các nút màu xanh lá (Green) là các nút nguồn phát lưu lượng (Source Nodes: 0, 2, 5, 8).
- Các nút màu đỏ (Red) là các nút đích tiếp nhận dữ liệu (Destination Nodes: 19, 16, 14, 12).
- Các nút màu xanh dương (Blue) là các nút trung gian chuyển tiếp định tuyến AODV.
