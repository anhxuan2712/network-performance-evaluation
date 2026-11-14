# Hướng Dẫn Cài Đặt Môi Trường Mô Phỏng NS-2.35 Trên Ubuntu

**Người phụ trách:** Nguyễn Thành Đạt (TV2)  
**Mục tiêu:** Chuẩn bị môi trường mô phỏng NS-2.35, trình diễn trực quan NAM và bộ công cụ xử lý trace (AWK).

---

## 1. Yêu cầu hệ thống

- Hệ điều hành: Ubuntu Linux (khuyến nghị 20.04 LTS hoặc Ubuntu 22.04 / 24.04 đã vá lỗi tương thích GCC).
- Các gói phụ thuộc chính: `build-essential`, `tcl8.5`, `tk8.5`, `libxmu-dev`, `libx11-dev`, `gcc-4.8`/`gcc-9` hoặc trình biên dịch tương thích.

## 2. Các bước cài đặt cơ bản

```bash
# 1. Cập nhật hệ thống
sudo apt update && sudo apt upgrade -y

# 2. Cài đặt các gói công cụ và thư viện cần thiết
sudo apt install -y build-essential autoconf automake libxmu-dev libx11-dev libxt-dev

# 3. Tải và giải nén ns-allinone-2.35
tar -zxvf ns-allinone-2.35.tar.gz
cd ns-allinone-2.35

# 4. Tiến hành cài đặt
./install
```

## 3. Cấu hình biến môi trường (`~/.bashrc`)

Thêm các dòng sau vào cuối file `~/.bashrc`:

```bash
# NS-2 Environment Variables
export NS_HOME=/path/to/ns-allinone-2.35
export PATH=$PATH:$NS_HOME/bin:$NS_HOME/tcl8.5.10/unix:$NS_HOME/tk8.5.10/unix
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$NS_HOME/otcl-1.14:$NS_HOME/lib
export TCL_LIBRARY=$NS_HOME/tcl8.5.10/library
```

Sau đó chạy lệnh:
```bash
source ~/.bashrc
```

## 4. Kiểm tra cài đặt

```bash
ns
# Nếu hiển thị dấu nhắc % là thành công, gõ exit để thoát

nam
# Nếu cửa sổ NAM khởi chạy là thành công

awk --version
# Kiểm tra phiên bản AWK
```
