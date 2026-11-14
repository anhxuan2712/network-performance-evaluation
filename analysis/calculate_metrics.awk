# ==============================================================================
# Script AWK tính toán các chỉ số hiệu năng mạng MANET từ file trace NS-2
# Các chỉ số: PDR, Packet Loss, Average Delay, Throughput, Routing Overhead
# Người phụ trách: Kiều Đức Dương (TV5)
# ==============================================================================

BEGIN {
    send_packets = 0;
    recv_packets = 0;
    routing_packets = 0;
    start_time = 1e6;
    stop_time = 0;
    total_delay = 0;
    total_bytes_received = 0;
}

{
    # Đọc định dạng trace NS-2 mới hoặc cũ
    # Thống nhất trường: event ($1), time ($2), node ($3), type ($4), ...
}

END {
    # Tính toán các chỉ số
    pdr = (send_packets > 0) ? (recv_packets / send_packets) * 100 : 0;
    plr = (send_packets > 0) ? ((send_packets - recv_packets) / send_packets) * 100 : 0;
    avg_delay = (recv_packets > 0) ? (total_delay / recv_packets) * 1000 : 0; # ms
    duration = stop_time - start_time;
    throughput = (duration > 0) ? (total_bytes_received * 8 / duration) / 1000 : 0; # kbps
    overhead = (recv_packets > 0) ? (routing_packets / recv_packets) : 0;

    printf("=== KẾT QUẢ PHÂN TÍCH HIỆU NĂNG ===\n");
    printf("Sent Packets        : %d\n", send_packets);
    printf("Received Packets    : %d\n", recv_packets);
    printf("Routing Packets     : %d\n", routing_packets);
    printf("PDR (%%)             : %.2f %%\n", pdr);
    printf("Packet Loss (%%)     : %.2f %%\n", plr);
    printf("Avg End-to-End Delay: %.2f ms\n", avg_delay);
    printf("Throughput          : %.2f kbps\n", throughput);
    printf("Routing Overhead    : %.4f\n", overhead);
}
