#!/bin/bash
# ==============================================================================
# Script tự động hóa chạy mô phỏng 4 kịch bản MANET AODV trên NS-2.35
# Nhóm: 06 thành viên - Đề tài Đánh giá hiệu năng AODV
# ==============================================================================

set -e

BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TCL_DIR="$BASE_DIR/tcl"
TRACE_RAW_DIR="$BASE_DIR/trace/raw"

mkdir -p "$TRACE_RAW_DIR"

echo "=== BẮT ĐẦU CHẠY CÁC KỊCH BẢN MÔ PHỎNG NS-2 ==="

SCENARIOS=("SC01_speed_0" "SC02_speed_5" "SC03_speed_10" "SC04_speed_15")
SPEEDS=(0 5 10 15)

for i in "${!SCENARIOS[@]}"; do
    SC="${SCENARIOS[$i]}"
    SPEED="${SPEEDS[$i]}"
    echo "--> Đang thực thi kịch bản: $SC (Tốc độ tối đa: ${SPEED} m/s)..."
    
    # Lệnh chạy ns-2 (điều chỉnh tham số phù hợp với file tcl chính)
    # ns "$TCL_DIR/manet_aodv_base.tcl" "$SC" "$SPEED" "$TRACE_RAW_DIR"
done

echo "=== HOÀN THÀNH TẤT CẢ KỊCH BẢN MÔ PHỎNG ==="
