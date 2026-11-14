# ==============================================================================
# Script mô phỏng mạng MANET với giao thức định tuyến AODV trên NS-2.35
# Đề tài: Nghiên cứu và đánh giá hiệu năng giao thức định tuyến AODV trong MANET
# Người phụ trách: Nguyễn Phúc Vượng (TV3), Nguyễn Minh Trí (TV4)
# ==============================================================================
# Tham số chính:
# - Số node: 20 node
# - Kích thước khu vực: 500m x 500m
# - Giao thức MAC: IEEE 802.11
# - Giao thức định tuyến: AODV
# - Mô hình di chuyển: Random Waypoint (Pause time = 5s)
# - Lưu lượng: UDP / CBR (Packet size = 512 bytes)
# - Thời gian mô phỏng: 100 giây
# ==============================================================================

# 1. Thiết lập các thông số mặc định của mô phỏng
set val(chan)       Channel/WirelessChannel    ;# Kênh truyền không dây
set val(prop)       Propagation/TwoRayGround   ;# Mô hình truyền sóng Two-Ray Ground
set val(netif)      Phy/WirelessPhy            ;# Giao diện mạng vật lý
set val(mac)        Mac/802_11                 ;# Chuẩn MAC IEEE 802.11
set val(ifq)        Queue/DropTail/PriQueue    ;# Hàng đợi ưu tiên DropTail
set val(ll)         LL                         ;# Tầng liên kết dữ liệu (LL)
set val(ant)        Antenna/OmniAntenna        ;# Ăng-ten đẳng hướng Omni-directional
set val(ifqlen)     50                         ;# Chiều dài tối đa hàng đợi
set val(nn)         20                         ;# Số lượng nút mạng
set val(rp)         AODV                       ;# Giao thức định tuyến AODV
set val(x)          500                        ;# Kích thước chiều X khu vực (mét)
set val(y)          500                        ;# Kích thước chiều Y khu vực (mét)
set val(stop)       100.0                      ;# Thời gian kết thúc mô phỏng (giây)
set val(pause)      5.0                        ;# Thời gian tạm dừng di chuyển (giây)

# 2. Xử lý tham số dòng lệnh (Command Line Arguments)
# Cú pháp hỗ trợ:
#   ns manet_aodv_base.tcl -sc SC01 -speed 0 -seed 1 -tr trace.tr -nam trace.nam
# Hoặc chạy mặc định:
#   ns manet_aodv_base.tcl

set opt(sc)        "SC01"
set opt(speed)     0.0
set opt(seed)      1
set opt(tr)        "../trace/raw/trace_sc01_run01.tr"
set opt(nam)       "../trace/raw/nam_sc01_run01.nam"
set opt(mob_file)  ""
set opt(traf_file) ""

# Phân tích cờ dòng lệnh
for {set i 0} {$i < $argc} {incr i} {
    set flag [lindex $argv $i]
    if {$flag == "-sc"} {
        incr i
        set opt(sc) [lindex $argv $i]
    } elseif {$flag == "-speed"} {
        incr i
        set opt(speed) [expr double([lindex $argv $i])]
    } elseif {$flag == "-seed"} {
        incr i
        set opt(seed) [lindex $argv $i]
    } elseif {$flag == "-tr"} {
        incr i
        set opt(tr) [lindex $argv $i]
    } elseif {$flag == "-nam"} {
        incr i
        set opt(nam) [lindex $argv $i]
    } elseif {$flag == "-mob"} {
        incr i
        set opt(mob_file) [lindex $argv $i]
    } elseif {$flag == "-traffic"} {
        incr i
        set opt(traf_file) [lindex $argv $i]
    }
}

puts "=================================================="
puts "  KỊCH BẢN MÔ PHỎNG: $opt(sc)"
puts "  - Số nút mạng       : $val(nn)"
puts "  - Khu vực           : $val(x)m x $val(y)m"
puts "  - Tốc độ tối đa     : $opt(speed) m/s"
puts "  - Random Seed       : $opt(seed)"
puts "  - Thời gian mô phỏng: $val(stop) giây"
puts "  - File trace đầu ra : $opt(tr)"
puts "  - File NAM đầu ra   : $opt(nam)"
puts "=================================================="

# 3. Khởi tạo bộ sinh số ngẫu nhiên theo Seed
global defaultRNG
$defaultRNG seed $opt(seed)

# 4. Khởi tạo Simulator và cấu hình file Trace / NAM
set ns_ [new Simulator]

# Mở file ghi nhận trace
set tracefd [open $opt(tr) w]
$ns_ trace-all $tracefd

# Mở file ghi nhận hoạt ảnh NAM
set namtrace [open $opt(nam) w]
$ns_ namtrace-all-wireless $namtrace $val(x) $val(y)

# 5. Cấu hình địa hình (Topography) và đối tượng GOD
set topo [new Topography]
$topo load_flatgrid $val(x) $val(y)

create-god $val(nn)

# 6. Cấu hình thuộc tính cho các nút mạng di động (Node Configuration)
$ns_ node-config -adhocRouting $val(rp) \
                 -llType $val(ll) \
                 -macType $val(mac) \
                 -ifqType $val(ifq) \
                 -ifqLen $val(ifqlen) \
                 -antType $val(ant) \
                 -propType $val(prop) \
                 -phyType $val(netif) \
                 -channelType $val(chan) \
                 -topoInstance $topo \
                 -agentTrace ON \
                 -routerTrace ON \
                 -macTrace OFF \
                 -movementTrace OFF

# 7. Khởi tạo 20 nút mạng
for {set i 0} {$i < $val(nn)} {incr i} {
    set node_($i) [$ns_ node]
    $node_($i) random-motion 0 ;# Tắt di chuyển ngẫu nhiên mặc định của NS-2
}

# 8. Thiết lập vị trí ban đầu của các nút mạng
# Phân bố đều trong lưới 500m x 500m
for {set i 0} {$i < $val(nn)} {incr i} {
    set row [expr $i / 5]
    set col [expr $i % 5]
    set init_x [expr 50.0 + $col * 100.0]
    set init_y [expr 50.0 + $row * 110.0]
    set init_z 0.0

    $node_($i) set X_ $init_x
    $node_($i) set Y_ $init_y
    $node_($i) set Z_ $init_z
    
    # Thiết lập hiển thị trong NAM
    $ns_ initial_node_pos $node_($i) 20
}

# 9. Thiết lập mô hình di chuyển (Mobility Model)
# Nếu có file kịch bản di chuyển (setdest) thì nạp, ngược lại tạo di chuyển mẫu theo tốc độ kịch bản
if {$opt(mob_file) != "" && [file exists $opt(mob_file)]} {
    puts "--> Đang nạp kịch bản di chuyển từ: $opt(mob_file)"
    source $opt(mob_file)
} else {
    if {$opt(speed) > 0} {
        puts "--> Tự động tạo chuyển động Random Waypoint với tốc độ tối đa $opt(speed) m/s"
        # Sinh chuyển động mẫu qua các mốc thời gian
        set rng_x [new RNG]
        set rng_y [new RNG]
        $rng_x seed [expr $opt(seed) * 17]
        $rng_y seed [expr $opt(seed) * 31]
        
        set rand_x [new RandomVariable/Uniform]
        $rand_x set min_ 10.0
        $rand_x set max_ 490.0
        $rand_x use-rng $rng_x

        set rand_y [new RandomVariable/Uniform]
        $rand_y set min_ 10.0
        $rand_y set max_ 490.0
        $rand_y use-rng $rng_y

        for {set i 0} {$i < $val(nn)} {incr i} {
            set t 10.0
            while {$t < $val(stop)} {
                set dest_x [$rand_x value]
                set dest_y [$rand_y value]
                $ns_ at $t "$node_($i) setdest $dest_x $dest_y $opt(speed)"
                set t [expr $t + 20.0 + $val(pause)]
            }
        }
    } else {
        puts "--> Kịch bản tốc độ 0 m/s: Các nút giữ nguyên vị trí cố định (Topology tĩnh)"
    }
}

# 10. Thiết lập luồng lưu lượng dữ liệu (Traffic Pattern - UDP/CBR)
# Kích thước gói: 512 bytes, Lưu lượng gửi: UDP/CBR
if {$opt(traf_file) != "" && [file exists $opt(traf_file)]} {
    puts "--> Đang nạp kịch bản lưu lượng từ: $opt(traf_file)"
    source $opt(traf_file)
} else {
    puts "--> Khởi tạo 4 luồng lưu lượng UDP/CBR giữa các nút mạng:"
    # Định nghĩa các cặp gửi nhận (Source -> Dest):
    # Luồng 1: Node 0  -> Node 19
    # Luồng 2: Node 2  -> Node 16
    # Luồng 3: Node 5  -> Node 14
    # Luồng 4: Node 8  -> Node 12
    set connections {
        {0 19 10.0 90.0 512 0.05}
        {2 16 12.0 90.0 512 0.05}
        {5 14 15.0 90.0 512 0.05}
        {8 12 18.0 90.0 512 0.05}
    }

    set conn_idx 0
    foreach conn $connections {
        set src [lindex $conn 0]
        set dst [lindex $conn 1]
        set start_time [lindex $conn 2]
        set stop_time [lindex $conn 3]
        set pkt_size [lindex $conn 4]
        set interval [lindex $conn 5]

        # Tạo UDP Agent tại nút nguồn
        set udp_($conn_idx) [new Agent/UDP]
        $ns_ attach-agent $node_($src) $udp_($conn_idx)

        # Tạo Null Agent (đích tiếp nhận) tại nút đích
        set null_($conn_idx) [new Agent/Null]
        $ns_ attach-agent $node_($dst) $null_($conn_idx)

        # Kết nối hai agent
        $ns_ connect $udp_($conn_idx) $null_($conn_idx)

        # Tạo ứng dụng CBR gắn vào UDP Agent
        set cbr_($conn_idx) [new Application/Traffic/CBR]
        $cbr_($conn_idx) set packetSize_ $pkt_size
        $cbr_($conn_idx) set interval_ $interval
        $cbr_($conn_idx) set random_ 1
        $cbr_($conn_idx) attach-agent $udp_($conn_idx)

        # Lên lịch gửi và dừng lưu lượng
        $ns_ at $start_time "$cbr_($conn_idx) start"
        $ns_ at $stop_time "$cbr_($conn_idx) stop"

        # Phân biệt màu sắc trực quan trong NAM
        $ns_ at 0.0 "$node_($src) color green"
        $ns_ at 0.0 "$node_($dst) color red"
        $udp_($conn_idx) set fid_ [expr $conn_idx + 1]

        puts "    Luồng $conn_idx: Node $src (Source) -> Node $dst (Destination) | Start: ${start_time}s, Interval: ${interval}s"
        incr conn_idx
    }
}

# 11. Đặt mốc kết thúc và định dạng NAM
for {set i 0} {$i < $val(nn)} {incr i} {
    $ns_ at $val(stop) "$node_($i) reset"
}

# Thủ tục kết thúc mô phỏng
proc finish {} {
    global ns_ tracefd namtrace opt
    $ns_ flush-trace
    close $tracefd
    close $namtrace
    puts "=================================================="
    puts "  Mô phỏng hoàn thành thành công!"
    puts "  Trace file: $opt(tr)"
    puts "  NAM file  : $opt(nam)"
    puts "=================================================="
    exit 0
}

$ns_ at $val(stop) "finish"
$ns_ at [expr $val(stop) + 0.01] "puts \"NS-2 Exiting...\"; $ns_ halt"

# 12. Bắt đầu thực thi mô phỏng
puts "--> Đang bắt đầu mô phỏng NS-2..."
$ns_ run
