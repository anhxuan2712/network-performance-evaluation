# Hướng Dẫn Sử Dụng Script Mô Phỏng Tcl

**Người phụ trách:** Nguyễn Phúc Vượng (TV3)

---

## 1. Cấu trúc thư mục `tcl/`

- `manet_aodv_base.tcl`: Script Tcl trung tâm cấu hình simulator, wireless channel, node, giao thức AODV, lưu lượng UDP/CBR và liên kết kịch bản di chuyển.
- `run_simulation.sh`: Shell script thực thi tự động hóa chạy các kịch bản SC01 đến SC04.

## 2. Cách chạy mô phỏng thủ công

```bash
# Chạy mô phỏng cho một kịch bản cụ thể:
ns manet_aodv_base.tcl -sc SC01 -speed 0 -seed 1
```

## 3. Chạy tự động toàn bộ kịch bản

```bash
chmod +x run_simulation.sh
./run_simulation.sh
```
Trace đầu ra sẽ được lưu tự động tại `../trace/raw/`.
