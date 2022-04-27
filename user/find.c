#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"
#include "kernel/fs.h"

char*
fmtname(char *path)
{
  static char buf[DIRSIZ+1];
  char *p;

  // Find first character after last slash.
  for(p=path+strlen(path); p >= path && *p != '/'; p--)
    ;
  p++;

  // Return name as string.
  if(strlen(p) >= DIRSIZ)
    return p;
  memmove(buf, p, strlen(p));
  memset(buf+strlen(p), '\0', DIRSIZ-strlen(p));
  return buf;
}

void search(char *path, char *buf, int fd, struct stat st, char *fname)
{
  char *p;
  struct dirent de;
  struct stat st2;

  if(strlen(path) + 1 + DIRSIZ + 1 > 512){
    printf("find: path too long\n");
  }
  strcpy(buf, path);
  p = buf+strlen(buf);
  *p++ = '/';

  while(read(fd, &de, sizeof(de)) == sizeof(de)){
    if(de.inum == 0)
      continue;
    memmove(p, de.name, DIRSIZ);
    p[DIRSIZ] = 0;
    if(stat(buf, &st) < 0){
      printf("find: cannot stat %s\n", buf);
      continue;
    }

    // print file/folder name and indicate type
    if (strsub(fmtname(buf), fname) >= 0) {
      printf("%d    %s\n", st.type, buf);
    }

    // if folder: call search recursively
    if (st.type == T_DIR) {
      // ignore . and .. folders
      if (strcmp(fmtname(buf), ".") != 0 && strcmp(fmtname(buf), "..") != 0) {
        int fd2 = open(buf, 0);
        if(fstat(fd, &st2) < 0){
          fprintf(2, "find: cannot stat %s\n", path);
          close(fd);
          return;
        }
        
        search(buf, buf, fd2, st2, fname);
        close(fd2);
      }
    }
  }
}

void find(char *path, char *fname){
    char buf[512], *p;
    int fd;
    struct dirent de;
    struct stat st;

    if((fd = open(path, 0)) < 0){
        fprintf(2, "find: cannot open %s\n", path);
        return;
    }

    if(fstat(fd, &st) < 0){
        fprintf(2, "find: cannot stat %s\n", path);
        close(fd);
        return;
    }

    switch(st.type){
    case T_FILE:

        break;

    case T_DIR:
        if(strlen(path) + 1 + DIRSIZ + 1 > sizeof(buf)){
        printf("find: path too long\n");
        break;
        }
        strcpy(buf, path);
        p = buf+strlen(buf);
        *p++ = '/';
        while(read(fd, &de, sizeof(de)) == sizeof(de)){
          if(de.inum == 0)
              continue;
          memmove(p, de.name, DIRSIZ);
          p[DIRSIZ] = 0;
          if(stat(buf, &st) < 0){
              printf("ls: cannot stat %s\n", buf);
              continue;
          }
          //
          search(path, buf, fd, st, fname);
        }
        break;
    }
    close(fd);
}

int main(int argc, char *argv[]){
    if(argc < 2){
        fprintf(2, "at leat one argument is required\n");
        exit(0);
    }

    int i;
    for(i = 1; i < argc; i++){
        find(".", argv[i]);
    }

    exit(0);
}