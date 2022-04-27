#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"
#include "kernel/fcntl.h"

int main(){
    int f = open("README", O_RDONLY);
    printf("output should be:\nxv6 i\nxv6 i\nxv6 i\nxv6 i\nis a \nre-im\n-------\n");

    char buf[5];

    read(f, buf, 5);
    printf("%s\n", buf);

    lseek(f, -5, SEEK_CUR);
    read(f, buf, 5);
    printf("%s\n", buf);

    lseek(f, 0, SEEK_SET);
    read(f, buf, 5);
    printf("%s\n", buf);

    lseek(f, -2226, SEEK_END);
    read(f, buf, 5);
    printf("%s\n", buf);

    lseek(f, -1, SEEK_CUR);
    read(f, buf, 5);
    printf("%s\n", buf);

    lseek(f, 1, SEEK_END);
    read(f, buf, 5);
    printf("%s\n", buf);
    
    exit(0);
}