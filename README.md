# README -- Đề tài Đánh giá hiệu năng mạng MANET bằng NS-2

> **Tên đề tài:** Nghiên cứu và đánh giá hiệu năng giao thức định tuyến
> AODV trong mạng MANET sử dụng NS-2\
> **Nhóm:** 06 thành viên\
> **Thời gian dự kiến:** 14 ngày\
> **Công cụ chính:** NS-2.35, NAM, AWK/Python, Excel hoặc Google Sheets

------------------------------------------------------------------------

## 1. Mục tiêu đề tài

Xây dựng mô hình mạng MANET (Mobile Ad hoc Network) trên NS-2, sử dụng
giao thức định tuyến AODV và đánh giá ảnh hưởng của **tốc độ di chuyển
của các nút mạng** đến hiệu năng truyền dữ liệu.

Nhóm sẽ giữ nguyên các tham số mô phỏng khác và thay đổi tốc độ di
chuyển để so sánh kết quả. Qua đó, nhóm phân tích khả năng duy trì
tuyến, độ tin cậy và hiệu quả truyền dữ liệu của AODV trong môi trường
có tính di động.

### Câu hỏi nghiên cứu

1.  AODV hoạt động như thế nào trong mạng MANET?
2.  Khi tốc độ di chuyển của node tăng, PDR và Packet Loss thay đổi ra
    sao?
3.  Tốc độ di chuyển ảnh hưởng thế nào đến độ trễ đầu cuối và
    throughput?
4.  Chi phí điều khiển định tuyến của AODV thay đổi thế nào khi topology
    thường xuyên biến động?

### Phạm vi để đảm bảo hoàn thành trong 14 ngày

-   Chỉ nghiên cứu **một giao thức: AODV**.
-   Chỉ thay đổi **một biến độc lập chính: tốc độ di chuyển tối đa**.
-   Dùng mô hình di chuyển Random Waypoint.
-   Dùng lưu lượng UDP/CBR.
-   Không mở rộng sang so sánh AODV với DSDV/DSR trong phạm vi chính.
-   Không kết luận rằng kết quả mô phỏng là hiệu năng của mạng thực tế;
    kết quả chỉ đúng trong bộ tham số và mô hình đã thiết lập.

------------------------------------------------------------------------

## 2. Kịch bản mô phỏng dự kiến

  Tham số                   Giá trị đề xuất
  ------------------------- -------------------
  Simulator                 NS-2.35
  Routing protocol          AODV
  Số node                   20
  Khu vực mô phỏng          500 m × 500 m
  MAC                       IEEE 802.11
  Hàng đợi giao diện        DropTail/PriQueue
  Transport                 UDP
  Application traffic       CBR
  Kích thước gói            512 bytes
  Thời gian mô phỏng        100 giây
  Mobility model            Random Waypoint
  Pause time                5 giây
  Tốc độ di chuyển tối đa   0, 5, 10, 15 m/s

**Lưu ý:** Đây là bộ tham số khởi đầu. Cần chạy thử một kịch bản trước
để xác nhận NS-2 hoạt động, trace có dữ liệu gửi/nhận và mô hình có kết
nối. Nếu cần thay đổi tham số, ghi rõ lý do và cập nhật README trước khi
chạy toàn bộ.

### Ma trận thực nghiệm

  Mã       Số node   Tốc độ tối đa Các tham số khác
  ------ --------- --------------- ------------------
  SC01          20           0 m/s Giữ cố định
  SC02          20           5 m/s Giữ cố định
  SC03          20          10 m/s Giữ cố định
  SC04          20          15 m/s Giữ cố định

-   Chạy thử SC01 để kiểm tra mô hình.
-   Sau khi mô hình hợp lệ, chạy đủ SC01--SC04.
-   Khuyến nghị chạy mỗi kịch bản ít nhất 3 lần với seed ngẫu nhiên khác
    nhau nếu thời gian cho phép.
-   Không chỉ chọn một lần chạy đẹp. Báo cáo cần nêu rõ số lần chạy và
    cách tổng hợp kết quả.
-   Nếu chỉ đủ thời gian chạy một lần, phải ghi đó là hạn chế của nghiên
    cứu.

------------------------------------------------------------------------

## 3. Chỉ số đánh giá và cách tính

  -----------------------------------------------------------------------
  Chỉ số                  Công thức/định nghĩa    Đơn vị
  ----------------------- ----------------------- -----------------------
  Packet Delivery Ratio   Tổng số gói dữ liệu     \%
  (PDR)                   nhận được / tổng số gói 
                          dữ liệu gửi × 100%      

  Packet Loss Ratio       (Gói gửi − gói nhận) /  \%
                          gói gửi × 100%          

  Average End-to-End      Trung bình thời gian từ ms
  Delay                   lúc gửi đến lúc nhận    
                          của các gói nhận thành  
                          công                    

  Throughput              Tổng bit dữ liệu nhận   Kbit/s hoặc Mbit/s
                          thành công / khoảng     
                          thời gian đo            

  Routing Overhead        Số gói điều khiển định  gói/gói
                          tuyến / số gói dữ liệu  
                          nhận thành công         
  -----------------------------------------------------------------------

### Quy tắc xử lý trace

1.  Chỉ tính gói dữ liệu ứng dụng UDP/CBR khi tính PDR, Packet Loss và
    Throughput.
2.  Không tính gói AODV điều khiển (RREQ, RREP, RERR, HELLO nếu có) như
    gói dữ liệu ứng dụng.
3.  Với Delay, chỉ tính các gói có đủ sự kiện gửi và nhận tương ứng;
    ghép gói bằng định danh phù hợp trong trace.
4.  Với Throughput, thống nhất khoảng đo. Có thể dùng thời gian mô phỏng
    hoặc khoảng từ gói dữ liệu đầu tiên gửi đến gói dữ liệu cuối cùng
    nhận; phải ghi rõ cách chọn.
5.  Với Routing Overhead, định nghĩa rõ đang đếm số gói điều khiển hay
    số byte điều khiển. Không trộn hai đại lượng.
6.  Nếu không có gói nhận hoặc mẫu số bằng 0, ghi `N/A`, không tự gán
    bằng 0.
7.  Kiểm tra đơn vị và đối chiếu thủ công một số dòng trace trước khi
    tin kết quả script.

------------------------------------------------------------------------

## 4. Phân công công việc cho 6 thành viên

> Điền tên thành viên và ngày hoàn thành ngay khi nhóm thống nhất. Mỗi
> nhiệm vụ phải có sản phẩm bàn giao để leader kiểm tra.

  -----------------------------------------------------------------------
  Thành viên        Vai trò           Nhiệm vụ chính    Sản phẩm bàn giao
  ----------------- ----------------- ----------------- -----------------
  TV1 -- Leader     Điều phối và nội  Chốt phạm vi,     Kế hoạch, Chương
                    dung nền tảng     quản lý tiến độ,  1--2, checklist
                                      nghiên cứu        nghiệm thu
                                      MANET/AODV, thống 
                                      nhất tham số và   
                                      cách đo           

  TV2               Môi trường mô     Cài/kiểm tra      Môi trường chạy
                    phỏng             NS-2.35, NAM,     được, ảnh kiểm
                                      AWK; tạo mô phỏng tra, hướng dẫn
                                      mẫu; ghi lại      cài
                                      hướng dẫn cài đặt 

  TV3               Xây dựng Tcl      Viết Tcl tạo      File Tcl có chú
                                      node, wireless    thích, chạy được
                                      channel, MAC,     SC01
                                      queue, AODV,      
                                      CBR/UDP, trace và 
                                      NAM               

  TV4               Mobility và chạy  Thiết lập Random  Bộ trace, log
                    kịch bản          Waypoint, tham số chạy, bảng thông
                                      tốc độ; chạy      tin từng lần chạy
                                      SC01--SC04 và lưu 
                                      trace có tổ chức  

  TV5               Phân tích dữ liệu Viết AWK/Python   Script phân tích,
                                      xử lý trace và    CSV kết quả, kiểm
                                      tính các chỉ số   tra tính đúng
                                      đã thống nhất     

  TV6               Biểu đồ và biên   Vẽ biểu đồ, trình Biểu đồ, Chương
                    tập               bày kết quả, tổng 4--5, báo cáo và
                                      hợp hình ảnh và   slide
                                      định dạng báo     
                                      cáo/slide         
  -----------------------------------------------------------------------

### Trách nhiệm chung

-   TV3 và TV4 phối hợp để đảm bảo Tcl script phản ánh đúng từng kịch
    bản.
-   TV4 không đổi tham số ngoài tốc độ di chuyển nếu chưa được leader
    đồng ý.
-   TV5 công bố công thức, quy tắc lọc trace và đơn vị trước khi xử lý
    toàn bộ dữ liệu.
-   TV6 chỉ vẽ biểu đồ từ CSV đã được TV5 và leader kiểm tra.
-   TV1 chịu trách nhiệm kiểm tra tính nhất quán giữa mục tiêu, phương
    pháp, kết quả và kết luận.
-   Tất cả thành viên phải hiểu ít nhất topology, AODV, các chỉ số và
    kết luận chính để tham gia bảo vệ.

------------------------------------------------------------------------

## 5. Quy trình thực hiện từ đầu đến cuối

### Giai đoạn 1 -- Chốt đề tài và chuẩn bị (Ngày 1)

1.  Thống nhất tên đề tài, câu hỏi nghiên cứu và phạm vi.
2.  Chốt ma trận SC01--SC04.
3.  Chỉ định người phụ trách từng đầu việc.
4.  Tạo thư mục dự án và nơi lưu dữ liệu chung.
5.  Thống nhất phiên bản NS-2, hệ điều hành và cách đặt tên file.

**Điều kiện hoàn thành:** Cả nhóm hiểu rõ biến độc lập là tốc độ di
chuyển; các tham số còn lại được giữ cố định.

### Giai đoạn 2 -- Cài đặt và kiểm tra NS-2 (Ngày 1--2)

1.  Chuẩn bị môi trường Linux tương thích.
2.  Cài NS-2.35 và NAM theo hướng dẫn phù hợp với hệ điều hành.
3.  Kiểm tra lệnh `ns`, `nam` và `awk`.
4.  Chạy Tcl script tối giản để xác nhận NS-2 thực thi được.
5.  Lưu ảnh chụp và log kiểm tra.

**Điều kiện hoàn thành:** Chạy được Tcl script và tạo được file đầu ra;
nếu NAM không hoạt động trên môi trường headless thì vẫn phải lưu trace
và ghi rõ giới hạn hiển thị.

### Giai đoạn 3 -- Xây dựng mô hình AODV (Ngày 3--4)

1.  Khai báo simulator và trace.
2.  Khai báo wireless channel, propagation, network interface và MAC
    802.11.
3.  Khai báo queue và topography.
4.  Tạo 20 mobile nodes.
5.  Cấu hình routing protocol AODV.
6.  Tạo luồng UDP/CBR giữa các node.
7.  Thiết lập chuyển động Random Waypoint.
8.  Xuất trace và file NAM.
9.  Chạy thử SC01.

**Điều kiện hoàn thành:** Mô phỏng chạy hết thời gian, có sự kiện
gửi/nhận dữ liệu, file trace không rỗng và có thể quan sát mô hình hoặc
xác minh bằng trace.

### Giai đoạn 4 -- Kiểm tra và chạy thực nghiệm (Ngày 5--9)

1.  Chạy thử một kịch bản và kiểm tra trace.
2.  Sao chép cấu hình chuẩn để tạo SC01--SC04.
3.  Chỉ thay đổi tốc độ di chuyển tối đa giữa các kịch bản.
4.  Chạy từng kịch bản, lưu trace, log và seed.
5.  Nếu có thể, chạy ít nhất 3 lần/kịch bản với seed khác nhau.
6.  Ghi lại mọi lần chạy lỗi và lý do chạy lại; không xóa dữ liệu gốc.

**Điều kiện hoàn thành:** Có đủ trace và metadata cho tất cả kịch bản
được đưa vào báo cáo.

### Giai đoạn 5 -- Phân tích trace (Ngày 9--11)

1.  Thống nhất định dạng trace NS-2 đang sử dụng.
2.  Xác định trường sự kiện, thời gian, node, loại gói, kích thước và
    định danh gói.
3.  Viết AWK/Python để lọc gói ứng dụng và gói điều khiển.
4.  Tính PDR, Packet Loss, Delay, Throughput và Routing Overhead.
5.  Kiểm tra thủ công một số gói gửi/nhận.
6.  Xuất kết quả thành CSV.
7.  Nếu có nhiều lần chạy, tính trung bình và độ lệch chuẩn hoặc trình
    bày từng lần chạy.

**Điều kiện hoàn thành:** Có CSV, script phân tích và mô tả công thức đủ
để người khác chạy lại.

### Giai đoạn 6 -- Biểu đồ và viết báo cáo (Ngày 11--13)

Tạo tối thiểu các biểu đồ:

1.  Tốc độ di chuyển -- PDR.
2.  Tốc độ di chuyển -- Average End-to-End Delay.
3.  Tốc độ di chuyển -- Throughput.
4.  Tốc độ di chuyển -- Routing Overhead.
5.  Có thể bổ sung Packet Loss nếu dữ liệu đã được kiểm tra.

Mỗi biểu đồ cần có: - Tên biểu đồ. - Tên trục và đơn vị. - Chú giải nếu
có nhiều chuỗi dữ liệu. - Nhận xét xu hướng. - Giải thích dựa trên cơ
chế AODV và kết quả thực nghiệm. - Không khẳng định quan hệ nhân quả
vượt quá những gì thiết kế mô phỏng chứng minh.

### Giai đoạn 7 -- Rà soát và chuẩn bị bảo vệ (Ngày 14)

1.  Chạy lại ít nhất một kịch bản để xác minh khả năng tái lập.
2.  Kiểm tra số liệu trong CSV có khớp biểu đồ và báo cáo.
3.  Kiểm tra ảnh topology, trace và NAM.
4.  Hoàn thiện slide.
5.  Phân công phần thuyết trình và câu hỏi phản biện.
6.  Sao lưu toàn bộ source, trace, CSV và báo cáo.

------------------------------------------------------------------------

## 6. Cấu trúc thư mục dự án

``` text
MANET-AODV-NS2/
├── README.md
├── docs/
│   ├── outline-report.md
│   ├── references.md
│   └── meeting-notes.md
├── tcl/
│   ├── manet-aodv.tcl
│   └── README.md
├── scenarios/
│   ├── SC01_speed_0/
│   ├── SC02_speed_5/
│   ├── SC03_speed_10/
│   └── SC04_speed_15/
├── trace/
│   ├── raw/
│   └── processed/
├── analysis/
│   ├── calculate_metrics.awk
│   ├── analyze.py
│   └── requirements.txt
├── results/
│   ├── metrics.csv
│   └── figures/
├── screenshots/
│   ├── topology/
│   ├── nam/
│   └── terminal/
└── report/
    ├── report.docx
    └── slides.pptx
```

**Quy tắc:** Không sửa trực tiếp hoặc ghi đè trace gốc. Dữ liệu đã xử lý
phải được lưu riêng trong `trace/processed/` hoặc `results/`.

------------------------------------------------------------------------

## 7. Quy ước đặt tên file

  Loại      Quy ước                           Ví dụ
  --------- --------------------------------- -----------------------
  Tcl       `manet_aodv_<scenario>.tcl`       `manet_aodv_sc01.tcl`
  Trace     `trace_<scenario>_run<seed>.tr`   `trace_sc02_run02.tr`
  NAM       `nam_<scenario>_run<seed>.nam`    `nam_sc02_run02.nam`
  CSV       `metrics_<scenario>.csv`          `metrics_sc02.csv`
  Biểu đồ   `fig_<metric>.png`                `fig_pdr.png`

Mỗi lần chạy cần lưu metadata gồm: mã kịch bản, tốc độ, seed, thời gian
mô phỏng, phiên bản NS-2, trạng thái chạy và tên trace tương ứng.

------------------------------------------------------------------------

## 8. Cấu trúc báo cáo cuối kỳ

### Chương 1 -- Tổng quan

-   Bối cảnh và lý do chọn đề tài.
-   Mục tiêu nghiên cứu.
-   Đối tượng và phạm vi nghiên cứu.
-   Phương pháp nghiên cứu.
-   Bố cục báo cáo.

### Chương 2 -- Cơ sở lý thuyết

-   Tổng quan mạng MANET.
-   Đặc điểm và thách thức của MANET.
-   Kiến trúc và nguyên lý hoạt động AODV.
-   Cơ chế RREQ, RREP, RERR.
-   Các chỉ số đánh giá hiệu năng mạng.
-   Tổng quan NS-2.

### Chương 3 -- Xây dựng mô hình mô phỏng

-   Môi trường và phiên bản phần mềm.
-   Sơ đồ và tham số mô phỏng.
-   Cấu hình node, MAC, wireless channel.
-   Cấu hình AODV và UDP/CBR.
-   Mô hình di chuyển Random Waypoint.
-   Thiết kế các kịch bản thực nghiệm.
-   Quy trình thu thập và xử lý trace.

### Chương 4 -- Kết quả và đánh giá

-   Kết quả từng kịch bản.
-   Bảng số liệu các chỉ số.
-   Biểu đồ PDR, Delay, Throughput, Routing Overhead và Packet Loss.
-   So sánh giữa các mức tốc độ.
-   Giải thích kết quả và các yếu tố ảnh hưởng.
-   Hạn chế và độ tin cậy của thực nghiệm.

### Chương 5 -- Kết luận và hướng phát triển

-   Tổng kết kết quả đạt được.
-   Trả lời các câu hỏi nghiên cứu.
-   Hạn chế của mô hình.
-   Hướng phát triển: thay đổi số node, pause time, lưu lượng hoặc so
    sánh thêm DSDV/DSR.

------------------------------------------------------------------------

## 9. Checklist nghiệm thu

### Môi trường và mô hình

-   [ ] NS-2 chạy được Tcl script.
-   [ ] NAM mở được hoặc có phương án kiểm tra trace thay thế.
-   [ ] Mô hình có 20 node.
-   [ ] AODV được cấu hình đúng.
-   [ ] UDP/CBR tạo được lưu lượng.
-   [ ] Có trace gửi và nhận.

### Thực nghiệm

-   [ ] SC01 -- 0 m/s.
-   [ ] SC02 -- 5 m/s.
-   [ ] SC03 -- 10 m/s.
-   [ ] SC04 -- 15 m/s.
-   [ ] Tham số ngoài tốc độ di chuyển được giữ cố định.
-   [ ] Lưu trace gốc và metadata.
-   [ ] Có ghi nhận số lần chạy và seed.

### Phân tích

-   [ ] Có công thức tính từng chỉ số.
-   [ ] Có script xử lý trace.
-   [ ] Có CSV kết quả.
-   [ ] Đã kiểm tra thủ công dữ liệu mẫu.
-   [ ] Có tối thiểu 4 biểu đồ.
-   [ ] Nhận xét bám sát dữ liệu.

### Báo cáo và bảo vệ

-   [ ] Đủ 5 chương.
-   [ ] Có sơ đồ mô hình.
-   [ ] Có ảnh mô phỏng.
-   [ ] Có bảng và biểu đồ.
-   [ ] Có tài liệu tham khảo.
-   [ ] Có slide và phân công thuyết trình.
-   [ ] Tất cả thành viên hiểu phương pháp và kết quả.

------------------------------------------------------------------------

## 10. Rủi ro và phương án dự phòng

  -----------------------------------------------------------------------
  Rủi ro                              Phương án xử lý
  ----------------------------------- -----------------------------------
  NS-2 cài đặt lỗi                    Dùng một máy Ubuntu thống nhất để
                                      cài và chạy; lưu lại phiên bản môi
                                      trường

  NAM không hiển thị                  Ưu tiên trace và số liệu; NAM là
                                      công cụ trực quan bổ trợ

  Trace rỗng hoặc không có gói nhận   Kiểm tra kết nối, vị trí node, lưu
                                      lượng, thời gian mô phỏng và cấu
                                      hình Tcl

  Script AWK không đọc đúng trace     Kiểm tra định dạng trace thực tế
                                      trước khi viết bộ phân tích

  Không đủ thời gian chạy nhiều lần   Ưu tiên hoàn thành một lần chạy hợp
                                      lệ cho cả 4 kịch bản, sau đó lặp
                                      lại nếu còn thời gian; ghi rõ hạn
                                      chế

  Kết quả bất thường                  Kiểm tra seed, tham số, cách lọc
                                      gói và đơn vị; không sửa số liệu để
                                      tạo xu hướng mong muốn
  -----------------------------------------------------------------------

------------------------------------------------------------------------

## 11. Nguyên tắc làm việc nhóm

1.  Mọi thay đổi tham số mô phỏng phải được ghi lại.
2.  Không chỉnh sửa dữ liệu gốc để làm đẹp kết quả.
3.  Mọi biểu đồ phải truy xuất được về file CSV và trace nguồn.
4.  Mọi kết luận phải có số liệu hoặc cơ chế kỹ thuật hỗ trợ.
5.  Thành viên phụ trách phải bàn giao cả file nguồn, cách chạy và kết
    quả.
6.  Leader cập nhật tiến độ mỗi ngày và xử lý các đầu việc bị chậm.
7.  Ưu tiên hoàn thành một mô hình chạy đúng và có số liệu kiểm chứng
    trước khi mở rộng.

------------------------------------------------------------------------

## 12. Tài liệu tham khảo khởi đầu

-   NS-2 -- The Network Simulator: https://www.isi.edu/nsnam/ns/
-   The ns Manual: https://www.isi.edu/nsnam/ns/doc/
-   RFC 3561 -- Ad hoc On-Demand Distance Vector (AODV) Routing:
    https://www.rfc-editor.org/rfc/rfc3561
-   RFC 2501 -- Mobile Ad hoc Networking (MANET):
    https://www.rfc-editor.org/rfc/rfc2501

Khi viết báo cáo, nhóm cần đọc và trích dẫn tài liệu thực sự đã sử dụng;
không chỉ liệt kê URL.

------------------------------------------------------------------------

## 13. Trạng thái dự án

  Hạng mục                   Trạng thái
  -------------------------- -------------------------------
  Chốt đề tài                Đã đề xuất
  Chốt phạm vi và kịch bản   Đã đề xuất, nhóm cần xác nhận
  Phân công 6 thành viên     Chờ điền tên
  Cài NS-2                   Chưa thực hiện
  Xây dựng Tcl               Chưa thực hiện
  Chạy thực nghiệm           Chưa thực hiện
  Phân tích số liệu          Chưa thực hiện
  Hoàn thiện báo cáo         Chưa thực hiện

**Mốc ưu tiên:** Trong 2 ngày đầu, nhóm phải có NS-2 chạy được và một mô
phỏng mẫu tạo ra trace hợp lệ. Đây là cổng kiểm soát quan trọng nhất
trước khi đầu tư thời gian vào toàn bộ thực nghiệm.
