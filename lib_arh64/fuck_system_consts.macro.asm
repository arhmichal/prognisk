%ifndef FUCK_SYSTEM_CONSTS_MACRO__ASM
    %define FUCK_SYSTEM_CONSTS_MACRO__ASM

%define std_in      0
%define std_out     1

%define sys_read    0       ; length          = sys_write(out, str, len)
%define sys_write   1       ; length          = sys_read(in, buffor, size)
%define sys_open    2       ; file_descriptor = sys_open(fileName, operation_mode, access_mode)
%define sys_close   3       ; error_code      = sys_close(file_descriptor) ; close_file
%define sys_exit    60      ; sec_since_1970  = sys_time()
%define sys_time    201     ; sys_exit()

%macro sys_exec 1
    move    rax, %1
    syscall
%endmacro

    ; /usr/include/asm/fcntl.h      ; for e.g. sys_open( file )
    ; mov     rsi,      3o    ; operation_mode = O_ACCMODE ; Pełne prawa dostępu 
    ; mov     rsi,      0o    ; operation_mode = O_RDONLY ; Otwieranie tylko do odczytu. Dostępne dla sys_mq_open. 
    ; mov     rsi,      1o    ; operation_mode = O_WRONLY ; Otwieranie tylko do zapisu. Dostępne dla sys_mq_open. 
    ; mov     rsi,      2o    ; operation_mode = O_RDWR ; Otwieranie do odczytu i zapisu. Dostępne dla sys_mq_open. 
    ; mov     rsi,    100o    ; operation_mode = O_CREAT ; Utworzenie pliku. Dostępne dla sys_mq_open. 
    ; mov     rsi,    200o    ; operation_mode = O_EXCL ; Nie twórz pliku, jeśli już istnieje. Dostępne dla sys_mq_open. 
    ; mov     rsi,    400o    ; operation_mode = O_NOCTTY ; Jeśli podana nazwa pliku to terminal, to NIE zostanie on terminalem kontrolnym procesu. 
    ; mov     rsi,   1000o    ; operation_mode = O_TRUNC ; Obcięcie pliku 
    ; mov     rsi,   2000o    ; operation_mode = O_APPEND ; Dopisywanie do pliku 
    ; mov     rsi,   4000o    ; operation_mode = O_NONBLOCK ; Nie otwieraj, jeśli spowoduje to blokadę. Dostępne dla sys_mq_open. 
    ; mov     rsi,   4000o    ; operation_mode = O_NDELAY ; jak wyżej 
    ; mov     rsi,  10000o    ; operation_mode = O_SYNC ; specyficzne dla ext2 i urządzeń blokowych 
    ; mov     rsi,  20000o    ; operation_mode = FASYNC ; fcntl, dla zgodności z BSD 
    ; mov     rsi,  40000o    ; operation_mode = O_DIRECT ; podpowiedź bezpośredniego dostępu do dysku, obecnie ignorowana 
    ; mov     rsi, 100000o    ; operation_mode = O_LARGEFILE ; Pozwól na otwieranie plików >4GB 
    ; mov     rsi, 200000o    ; operation_mode = O_DIRECTORY ; musi być katalogiem 
    ; mov     rsi, 400000o    ; operation_mode = O_NOFOLLOW ; nie podążaj za linkami 

    ; /usr/include/linux/stat.h     ; for e.g. sys_open( file )
    ; mov     rdx, 4000o      ; access_mode = S_ISUID ; ustaw ID użytkownika przy wykonywaniu (suid) 
    ; mov     rdx, 2000o      ; access_mode = S_ISGID ; ustaw ID grupy przy wykonywaniu (sgid) 
    ; mov     rdx, 1000o      ; access_mode = S_ISVTX ; "sticky bit" - usuwać z takiego katalogu może tylko właściciel 
    ; mov     rdx,  400o      ; access_mode = S_IRUSR ; czytanie przez właściciela (S_IREAD) 
    ; mov     rdx,  200o      ; access_mode = S_IWUSR ; zapis przez właściciela (S_IWRITE) 
    ; mov     rdx,  100o      ; access_mode = S_IXUSR ; wykonywanie/przeszukiwanie katalogu przez właściciela (S_IEXEC) 
    ; mov     rdx,   40o      ; access_mode = S_IRGRP ; czytanie przez grupę 
    ; mov     rdx,   20o      ; access_mode = S_IWGRP ; zapis przez grupę 
    ; mov     rdx,   10o      ; access_mode = S_IXGRP ; wykonywanie/przeszukiwanie katalogu przez grupę 
    ; mov     rdx,    4o      ; access_mode = S_IROTH ; czytanie przez innych (R_OK) 
    ; mov     rdx,    2o      ; access_mode = S_IWOTH ; zapis przez innych (W_OK) 
    ; mov     rdx,    1o      ; access_mode = S_IWOTH ; wykonywanie/przeszukiwanie katalogu przez innych (X_OK) 
    ; mov     rdx, (S_IRWXU | S_IRWXG | S_IRWXO)              ; access_mode = S_IRWXUGO ; czytanie, pisanie i wykonywanie przez wszystkich 
    ; mov     rdx, (S_ISUID | S_ISGID | S_ISVTX | S_IRWXUGO)  ; access_mode = S_IALLUGO ; czytanie, pisanie i wykonywanie przez wszystkich + suid + sgid + sticky bit 
    ; mov     rdx, (S_IRUSR | S_IRGRP | S_IROTH)              ; access_mode = S_IRUGO ; czytanie dla wszystkich 
    ; mov     rdx, (S_IWUSR | S_IWGRP | S_IWOTH)              ; access_mode = S_IWUGO ; zapis dla wszystkich 
    ; mov     rdx, (S_IXUSR | S_IXGRP | S_IXOTH)              ; access_mode = S_IXUGO ; wykonywanie/przeszukiwanie katalogu dla wszystkich 



%endif
