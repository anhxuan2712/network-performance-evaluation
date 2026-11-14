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

echo "================================================================================"
echo "    BẮT ĐẦU CHẠY TỰ ĐỘNG HÓA 4 KỊCH BẢN MÔ PHỎNG MANET AODV TRÊN NS-2.35"
echo "================================================================================"

SCENARIO_NAMES=("SC01" "SC02" "SC03" "SC04")
SPEEDS=(0 5 10 15)
RUN_SEED=1

for i in "${!SCENARIO_NAMES[@]}"; do
    SC="${SCENARIO_NAMES[$i]}"
    SPEED="${SPEEDS[$i]}"
    TR_FILE="$TRACE_RAW_DIR/trace_${SC,,}_run01.tr"
    NAM_FILE="$TRACE_RAW_DIR/nam_${SC,,}_run01.nam"

    echo ""
    echo ">>> ĐANG CHẠY KỊCH BẢN $SC (Tốc độ tối đa: ${SPEED} m/s) <<<"
    echo "    - Trace output: $TR_FILE"
    echo "    - NAM output  : $NAM_FILE"

    ns "$TCL_DIR/manet_aodv_base.tcl" \
        -sc "$SC" \
        -speed "$SPEED" \
        -seed "$RUN_SEED" \
        -tr "$TR_FILE" \
        -nam "$NAM_FILE"

    echo ">>> ĐÃ HOÀN THÀNH KỊCH BẢN $SC <<<"
done

echo ""
echo "================================================================================"
echo "    HOÀN TẤT TOÀN BỘ 4 KỊCH BẢN MÔ PHỎNG!"
echo "    Dữ liệu trace thô đã được lưu đầy đủ trong: trace/raw/"
echo "================================================================================"
