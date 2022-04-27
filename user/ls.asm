
user/_ls:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <fmtname>:
#include "user/user.h"
#include "kernel/fs.h"

char*
fmtname(char *path)
{
   0:	7179                	addi	sp,sp,-48
   2:	f406                	sd	ra,40(sp)
   4:	f022                	sd	s0,32(sp)
   6:	ec26                	sd	s1,24(sp)
   8:	e84a                	sd	s2,16(sp)
   a:	e44e                	sd	s3,8(sp)
   c:	1800                	addi	s0,sp,48
   e:	84aa                	mv	s1,a0
  static char buf[DIRSIZ+1];
  char *p;

  // Find first character after last slash.
  for(p=path+strlen(path); p >= path && *p != '/'; p--)
  10:	00000097          	auipc	ra,0x0
  14:	30a080e7          	jalr	778(ra) # 31a <strlen>
  18:	02051793          	slli	a5,a0,0x20
  1c:	9381                	srli	a5,a5,0x20
  1e:	97a6                	add	a5,a5,s1
  20:	02f00693          	li	a3,47
  24:	0097e963          	bltu	a5,s1,36 <fmtname+0x36>
  28:	0007c703          	lbu	a4,0(a5)
  2c:	00d70563          	beq	a4,a3,36 <fmtname+0x36>
  30:	17fd                	addi	a5,a5,-1
  32:	fe97fbe3          	bgeu	a5,s1,28 <fmtname+0x28>
    ;
  p++;
  36:	00178493          	addi	s1,a5,1

  // Return blank-padded name.
  if(strlen(p) >= DIRSIZ)
  3a:	8526                	mv	a0,s1
  3c:	00000097          	auipc	ra,0x0
  40:	2de080e7          	jalr	734(ra) # 31a <strlen>
  44:	2501                	sext.w	a0,a0
  46:	47b5                	li	a5,13
  48:	00a7fa63          	bgeu	a5,a0,5c <fmtname+0x5c>
    return p;
  memmove(buf, p, strlen(p));
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
  return buf;
}
  4c:	8526                	mv	a0,s1
  4e:	70a2                	ld	ra,40(sp)
  50:	7402                	ld	s0,32(sp)
  52:	64e2                	ld	s1,24(sp)
  54:	6942                	ld	s2,16(sp)
  56:	69a2                	ld	s3,8(sp)
  58:	6145                	addi	sp,sp,48
  5a:	8082                	ret
  memmove(buf, p, strlen(p));
  5c:	8526                	mv	a0,s1
  5e:	00000097          	auipc	ra,0x0
  62:	2bc080e7          	jalr	700(ra) # 31a <strlen>
  66:	00001997          	auipc	s3,0x1
  6a:	b7298993          	addi	s3,s3,-1166 # bd8 <buf.0>
  6e:	0005061b          	sext.w	a2,a0
  72:	85a6                	mv	a1,s1
  74:	854e                	mv	a0,s3
  76:	00000097          	auipc	ra,0x0
  7a:	4a8080e7          	jalr	1192(ra) # 51e <memmove>
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
  7e:	8526                	mv	a0,s1
  80:	00000097          	auipc	ra,0x0
  84:	29a080e7          	jalr	666(ra) # 31a <strlen>
  88:	0005091b          	sext.w	s2,a0
  8c:	8526                	mv	a0,s1
  8e:	00000097          	auipc	ra,0x0
  92:	28c080e7          	jalr	652(ra) # 31a <strlen>
  96:	1902                	slli	s2,s2,0x20
  98:	02095913          	srli	s2,s2,0x20
  9c:	4639                	li	a2,14
  9e:	9e09                	subw	a2,a2,a0
  a0:	02000593          	li	a1,32
  a4:	01298533          	add	a0,s3,s2
  a8:	00000097          	auipc	ra,0x0
  ac:	32e080e7          	jalr	814(ra) # 3d6 <memset>
  return buf;
  b0:	84ce                	mv	s1,s3
  b2:	bf69                	j	4c <fmtname+0x4c>

00000000000000b4 <ls>:

void
ls(char *path)
{
  b4:	d9010113          	addi	sp,sp,-624
  b8:	26113423          	sd	ra,616(sp)
  bc:	26813023          	sd	s0,608(sp)
  c0:	24913c23          	sd	s1,600(sp)
  c4:	25213823          	sd	s2,592(sp)
  c8:	25313423          	sd	s3,584(sp)
  cc:	25413023          	sd	s4,576(sp)
  d0:	23513c23          	sd	s5,568(sp)
  d4:	1c80                	addi	s0,sp,624
  d6:	892a                	mv	s2,a0
  char buf[512], *p;
  int fd;
  struct dirent de;
  struct stat st;

  if((fd = open(path, 0)) < 0){
  d8:	4581                	li	a1,0
  da:	00000097          	auipc	ra,0x0
  de:	536080e7          	jalr	1334(ra) # 610 <open>
  e2:	06054f63          	bltz	a0,160 <ls+0xac>
  e6:	84aa                	mv	s1,a0
    fprintf(2, "ls: cannot open %s\n", path);
    return;
  }

  if(fstat(fd, &st) < 0){
  e8:	d9840593          	addi	a1,s0,-616
  ec:	00000097          	auipc	ra,0x0
  f0:	53c080e7          	jalr	1340(ra) # 628 <fstat>
  f4:	08054163          	bltz	a0,176 <ls+0xc2>
    fprintf(2, "ls: cannot stat %s\n", path);
    close(fd);
    return;
  }

  switch(st.type){
  f8:	da041783          	lh	a5,-608(s0)
  fc:	0007869b          	sext.w	a3,a5
 100:	4705                	li	a4,1
 102:	08e68a63          	beq	a3,a4,196 <ls+0xe2>
 106:	4709                	li	a4,2
 108:	02e69663          	bne	a3,a4,134 <ls+0x80>
  case T_FILE:
    printf("%s %d %d %l\n", fmtname(path), st.type, st.ino, st.size);
 10c:	854a                	mv	a0,s2
 10e:	00000097          	auipc	ra,0x0
 112:	ef2080e7          	jalr	-270(ra) # 0 <fmtname>
 116:	85aa                	mv	a1,a0
 118:	da843703          	ld	a4,-600(s0)
 11c:	d9c42683          	lw	a3,-612(s0)
 120:	da041603          	lh	a2,-608(s0)
 124:	00001517          	auipc	a0,0x1
 128:	9f450513          	addi	a0,a0,-1548 # b18 <malloc+0x116>
 12c:	00001097          	auipc	ra,0x1
 130:	81e080e7          	jalr	-2018(ra) # 94a <printf>
      }
      printf("%s %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);
    }
    break;
  }
  close(fd);
 134:	8526                	mv	a0,s1
 136:	00000097          	auipc	ra,0x0
 13a:	4c2080e7          	jalr	1218(ra) # 5f8 <close>
}
 13e:	26813083          	ld	ra,616(sp)
 142:	26013403          	ld	s0,608(sp)
 146:	25813483          	ld	s1,600(sp)
 14a:	25013903          	ld	s2,592(sp)
 14e:	24813983          	ld	s3,584(sp)
 152:	24013a03          	ld	s4,576(sp)
 156:	23813a83          	ld	s5,568(sp)
 15a:	27010113          	addi	sp,sp,624
 15e:	8082                	ret
    fprintf(2, "ls: cannot open %s\n", path);
 160:	864a                	mv	a2,s2
 162:	00001597          	auipc	a1,0x1
 166:	98658593          	addi	a1,a1,-1658 # ae8 <malloc+0xe6>
 16a:	4509                	li	a0,2
 16c:	00000097          	auipc	ra,0x0
 170:	7b0080e7          	jalr	1968(ra) # 91c <fprintf>
    return;
 174:	b7e9                	j	13e <ls+0x8a>
    fprintf(2, "ls: cannot stat %s\n", path);
 176:	864a                	mv	a2,s2
 178:	00001597          	auipc	a1,0x1
 17c:	98858593          	addi	a1,a1,-1656 # b00 <malloc+0xfe>
 180:	4509                	li	a0,2
 182:	00000097          	auipc	ra,0x0
 186:	79a080e7          	jalr	1946(ra) # 91c <fprintf>
    close(fd);
 18a:	8526                	mv	a0,s1
 18c:	00000097          	auipc	ra,0x0
 190:	46c080e7          	jalr	1132(ra) # 5f8 <close>
    return;
 194:	b76d                	j	13e <ls+0x8a>
    if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf){
 196:	854a                	mv	a0,s2
 198:	00000097          	auipc	ra,0x0
 19c:	182080e7          	jalr	386(ra) # 31a <strlen>
 1a0:	2541                	addiw	a0,a0,16
 1a2:	20000793          	li	a5,512
 1a6:	00a7fb63          	bgeu	a5,a0,1bc <ls+0x108>
      printf("ls: path too long\n");
 1aa:	00001517          	auipc	a0,0x1
 1ae:	97e50513          	addi	a0,a0,-1666 # b28 <malloc+0x126>
 1b2:	00000097          	auipc	ra,0x0
 1b6:	798080e7          	jalr	1944(ra) # 94a <printf>
      break;
 1ba:	bfad                	j	134 <ls+0x80>
    strcpy(buf, path);
 1bc:	85ca                	mv	a1,s2
 1be:	dc040513          	addi	a0,s0,-576
 1c2:	00000097          	auipc	ra,0x0
 1c6:	110080e7          	jalr	272(ra) # 2d2 <strcpy>
    p = buf+strlen(buf);
 1ca:	dc040513          	addi	a0,s0,-576
 1ce:	00000097          	auipc	ra,0x0
 1d2:	14c080e7          	jalr	332(ra) # 31a <strlen>
 1d6:	1502                	slli	a0,a0,0x20
 1d8:	9101                	srli	a0,a0,0x20
 1da:	dc040793          	addi	a5,s0,-576
 1de:	00a78933          	add	s2,a5,a0
    *p++ = '/';
 1e2:	00190993          	addi	s3,s2,1
 1e6:	02f00793          	li	a5,47
 1ea:	00f90023          	sb	a5,0(s2)
      printf("%s %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);
 1ee:	00001a17          	auipc	s4,0x1
 1f2:	952a0a13          	addi	s4,s4,-1710 # b40 <malloc+0x13e>
        printf("ls: cannot stat %s\n", buf);
 1f6:	00001a97          	auipc	s5,0x1
 1fa:	90aa8a93          	addi	s5,s5,-1782 # b00 <malloc+0xfe>
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
 1fe:	a801                	j	20e <ls+0x15a>
        printf("ls: cannot stat %s\n", buf);
 200:	dc040593          	addi	a1,s0,-576
 204:	8556                	mv	a0,s5
 206:	00000097          	auipc	ra,0x0
 20a:	744080e7          	jalr	1860(ra) # 94a <printf>
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
 20e:	4641                	li	a2,16
 210:	db040593          	addi	a1,s0,-592
 214:	8526                	mv	a0,s1
 216:	00000097          	auipc	ra,0x0
 21a:	3d2080e7          	jalr	978(ra) # 5e8 <read>
 21e:	47c1                	li	a5,16
 220:	f0f51ae3          	bne	a0,a5,134 <ls+0x80>
      if(de.inum == 0)
 224:	db045783          	lhu	a5,-592(s0)
 228:	d3fd                	beqz	a5,20e <ls+0x15a>
      memmove(p, de.name, DIRSIZ);
 22a:	4639                	li	a2,14
 22c:	db240593          	addi	a1,s0,-590
 230:	854e                	mv	a0,s3
 232:	00000097          	auipc	ra,0x0
 236:	2ec080e7          	jalr	748(ra) # 51e <memmove>
      p[DIRSIZ] = 0;
 23a:	000907a3          	sb	zero,15(s2)
      if(stat(buf, &st) < 0){
 23e:	d9840593          	addi	a1,s0,-616
 242:	dc040513          	addi	a0,s0,-576
 246:	00000097          	auipc	ra,0x0
 24a:	24a080e7          	jalr	586(ra) # 490 <stat>
 24e:	fa0549e3          	bltz	a0,200 <ls+0x14c>
      printf("%s %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);
 252:	dc040513          	addi	a0,s0,-576
 256:	00000097          	auipc	ra,0x0
 25a:	daa080e7          	jalr	-598(ra) # 0 <fmtname>
 25e:	85aa                	mv	a1,a0
 260:	da843703          	ld	a4,-600(s0)
 264:	d9c42683          	lw	a3,-612(s0)
 268:	da041603          	lh	a2,-608(s0)
 26c:	8552                	mv	a0,s4
 26e:	00000097          	auipc	ra,0x0
 272:	6dc080e7          	jalr	1756(ra) # 94a <printf>
 276:	bf61                	j	20e <ls+0x15a>

0000000000000278 <main>:

int
main(int argc, char *argv[])
{
 278:	1101                	addi	sp,sp,-32
 27a:	ec06                	sd	ra,24(sp)
 27c:	e822                	sd	s0,16(sp)
 27e:	e426                	sd	s1,8(sp)
 280:	e04a                	sd	s2,0(sp)
 282:	1000                	addi	s0,sp,32
  int i;

  if(argc < 2){
 284:	4785                	li	a5,1
 286:	02a7d963          	bge	a5,a0,2b8 <main+0x40>
 28a:	00858493          	addi	s1,a1,8
 28e:	ffe5091b          	addiw	s2,a0,-2
 292:	02091793          	slli	a5,s2,0x20
 296:	01d7d913          	srli	s2,a5,0x1d
 29a:	05c1                	addi	a1,a1,16
 29c:	992e                	add	s2,s2,a1
    ls(".");
    exit(0);
  }
  for(i=1; i<argc; i++)
    ls(argv[i]);
 29e:	6088                	ld	a0,0(s1)
 2a0:	00000097          	auipc	ra,0x0
 2a4:	e14080e7          	jalr	-492(ra) # b4 <ls>
  for(i=1; i<argc; i++)
 2a8:	04a1                	addi	s1,s1,8
 2aa:	ff249ae3          	bne	s1,s2,29e <main+0x26>
  exit(0);
 2ae:	4501                	li	a0,0
 2b0:	00000097          	auipc	ra,0x0
 2b4:	320080e7          	jalr	800(ra) # 5d0 <exit>
    ls(".");
 2b8:	00001517          	auipc	a0,0x1
 2bc:	89850513          	addi	a0,a0,-1896 # b50 <malloc+0x14e>
 2c0:	00000097          	auipc	ra,0x0
 2c4:	df4080e7          	jalr	-524(ra) # b4 <ls>
    exit(0);
 2c8:	4501                	li	a0,0
 2ca:	00000097          	auipc	ra,0x0
 2ce:	306080e7          	jalr	774(ra) # 5d0 <exit>

00000000000002d2 <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
 2d2:	1141                	addi	sp,sp,-16
 2d4:	e422                	sd	s0,8(sp)
 2d6:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 2d8:	87aa                	mv	a5,a0
 2da:	0585                	addi	a1,a1,1
 2dc:	0785                	addi	a5,a5,1
 2de:	fff5c703          	lbu	a4,-1(a1)
 2e2:	fee78fa3          	sb	a4,-1(a5)
 2e6:	fb75                	bnez	a4,2da <strcpy+0x8>
    ;
  return os;
}
 2e8:	6422                	ld	s0,8(sp)
 2ea:	0141                	addi	sp,sp,16
 2ec:	8082                	ret

00000000000002ee <strcmp>:

int
strcmp(const char *p, const char *q)
{
 2ee:	1141                	addi	sp,sp,-16
 2f0:	e422                	sd	s0,8(sp)
 2f2:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 2f4:	00054783          	lbu	a5,0(a0)
 2f8:	cb91                	beqz	a5,30c <strcmp+0x1e>
 2fa:	0005c703          	lbu	a4,0(a1)
 2fe:	00f71763          	bne	a4,a5,30c <strcmp+0x1e>
    p++, q++;
 302:	0505                	addi	a0,a0,1
 304:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 306:	00054783          	lbu	a5,0(a0)
 30a:	fbe5                	bnez	a5,2fa <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 30c:	0005c503          	lbu	a0,0(a1)
}
 310:	40a7853b          	subw	a0,a5,a0
 314:	6422                	ld	s0,8(sp)
 316:	0141                	addi	sp,sp,16
 318:	8082                	ret

000000000000031a <strlen>:
  return -1;
}

uint
strlen(const char *s)
{
 31a:	1141                	addi	sp,sp,-16
 31c:	e422                	sd	s0,8(sp)
 31e:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 320:	00054783          	lbu	a5,0(a0)
 324:	cf91                	beqz	a5,340 <strlen+0x26>
 326:	0505                	addi	a0,a0,1
 328:	87aa                	mv	a5,a0
 32a:	4685                	li	a3,1
 32c:	9e89                	subw	a3,a3,a0
 32e:	00f6853b          	addw	a0,a3,a5
 332:	0785                	addi	a5,a5,1
 334:	fff7c703          	lbu	a4,-1(a5)
 338:	fb7d                	bnez	a4,32e <strlen+0x14>
    ;
  return n;
}
 33a:	6422                	ld	s0,8(sp)
 33c:	0141                	addi	sp,sp,16
 33e:	8082                	ret
  for(n = 0; s[n]; n++)
 340:	4501                	li	a0,0
 342:	bfe5                	j	33a <strlen+0x20>

0000000000000344 <strsub>:
int strsub(const char *s, const char *sub){
 344:	7139                	addi	sp,sp,-64
 346:	fc06                	sd	ra,56(sp)
 348:	f822                	sd	s0,48(sp)
 34a:	f426                	sd	s1,40(sp)
 34c:	f04a                	sd	s2,32(sp)
 34e:	ec4e                	sd	s3,24(sp)
 350:	e852                	sd	s4,16(sp)
 352:	e456                	sd	s5,8(sp)
 354:	0080                	addi	s0,sp,64
 356:	8a2a                	mv	s4,a0
 358:	89ae                	mv	s3,a1
  for(i = 0; i < strlen(s); i++){
 35a:	84aa                	mv	s1,a0
 35c:	4901                	li	s2,0
 35e:	a019                	j	364 <strsub+0x20>
 360:	2905                	addiw	s2,s2,1
 362:	0485                	addi	s1,s1,1
 364:	8552                	mv	a0,s4
 366:	00000097          	auipc	ra,0x0
 36a:	fb4080e7          	jalr	-76(ra) # 31a <strlen>
 36e:	2501                	sext.w	a0,a0
 370:	04a97863          	bgeu	s2,a0,3c0 <strsub+0x7c>
    if(s[i] == sub[0]){
 374:	8aa6                	mv	s5,s1
 376:	0004c703          	lbu	a4,0(s1)
 37a:	0009c783          	lbu	a5,0(s3)
 37e:	fef711e3          	bne	a4,a5,360 <strsub+0x1c>
      for(j = 1; j < strlen(sub); j++){
 382:	854e                	mv	a0,s3
 384:	00000097          	auipc	ra,0x0
 388:	f96080e7          	jalr	-106(ra) # 31a <strlen>
 38c:	0005059b          	sext.w	a1,a0
 390:	ffe5061b          	addiw	a2,a0,-2
 394:	1602                	slli	a2,a2,0x20
 396:	9201                	srli	a2,a2,0x20
 398:	0609                	addi	a2,a2,2
 39a:	4785                	li	a5,1
 39c:	0007871b          	sext.w	a4,a5
 3a0:	fcb770e3          	bgeu	a4,a1,360 <strsub+0x1c>
        if(s[j+i] != sub[j]){
 3a4:	00fa86b3          	add	a3,s5,a5
 3a8:	00f98733          	add	a4,s3,a5
 3ac:	0006c683          	lbu	a3,0(a3)
 3b0:	00074703          	lbu	a4,0(a4)
 3b4:	fae696e3          	bne	a3,a4,360 <strsub+0x1c>
        if(j == strlen(sub) -1){
 3b8:	0785                	addi	a5,a5,1
 3ba:	fec791e3          	bne	a5,a2,39c <strsub+0x58>
 3be:	a011                	j	3c2 <strsub+0x7e>
  return -1;
 3c0:	597d                	li	s2,-1
}
 3c2:	854a                	mv	a0,s2
 3c4:	70e2                	ld	ra,56(sp)
 3c6:	7442                	ld	s0,48(sp)
 3c8:	74a2                	ld	s1,40(sp)
 3ca:	7902                	ld	s2,32(sp)
 3cc:	69e2                	ld	s3,24(sp)
 3ce:	6a42                	ld	s4,16(sp)
 3d0:	6aa2                	ld	s5,8(sp)
 3d2:	6121                	addi	sp,sp,64
 3d4:	8082                	ret

00000000000003d6 <memset>:

void*
memset(void *dst, int c, uint n)
{
 3d6:	1141                	addi	sp,sp,-16
 3d8:	e422                	sd	s0,8(sp)
 3da:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 3dc:	ca19                	beqz	a2,3f2 <memset+0x1c>
 3de:	87aa                	mv	a5,a0
 3e0:	1602                	slli	a2,a2,0x20
 3e2:	9201                	srli	a2,a2,0x20
 3e4:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 3e8:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 3ec:	0785                	addi	a5,a5,1
 3ee:	fee79de3          	bne	a5,a4,3e8 <memset+0x12>
  }
  return dst;
}
 3f2:	6422                	ld	s0,8(sp)
 3f4:	0141                	addi	sp,sp,16
 3f6:	8082                	ret

00000000000003f8 <strchr>:

char*
strchr(const char *s, char c)
{
 3f8:	1141                	addi	sp,sp,-16
 3fa:	e422                	sd	s0,8(sp)
 3fc:	0800                	addi	s0,sp,16
  for(; *s; s++)
 3fe:	00054783          	lbu	a5,0(a0)
 402:	cb99                	beqz	a5,418 <strchr+0x20>
    if(*s == c)
 404:	00f58763          	beq	a1,a5,412 <strchr+0x1a>
  for(; *s; s++)
 408:	0505                	addi	a0,a0,1
 40a:	00054783          	lbu	a5,0(a0)
 40e:	fbfd                	bnez	a5,404 <strchr+0xc>
      return (char*)s;
  return 0;
 410:	4501                	li	a0,0
}
 412:	6422                	ld	s0,8(sp)
 414:	0141                	addi	sp,sp,16
 416:	8082                	ret
  return 0;
 418:	4501                	li	a0,0
 41a:	bfe5                	j	412 <strchr+0x1a>

000000000000041c <gets>:

char*
gets(char *buf, int max)
{
 41c:	711d                	addi	sp,sp,-96
 41e:	ec86                	sd	ra,88(sp)
 420:	e8a2                	sd	s0,80(sp)
 422:	e4a6                	sd	s1,72(sp)
 424:	e0ca                	sd	s2,64(sp)
 426:	fc4e                	sd	s3,56(sp)
 428:	f852                	sd	s4,48(sp)
 42a:	f456                	sd	s5,40(sp)
 42c:	f05a                	sd	s6,32(sp)
 42e:	ec5e                	sd	s7,24(sp)
 430:	1080                	addi	s0,sp,96
 432:	8baa                	mv	s7,a0
 434:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 436:	892a                	mv	s2,a0
 438:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 43a:	4aa9                	li	s5,10
 43c:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 43e:	89a6                	mv	s3,s1
 440:	2485                	addiw	s1,s1,1
 442:	0344d863          	bge	s1,s4,472 <gets+0x56>
    cc = read(0, &c, 1);
 446:	4605                	li	a2,1
 448:	faf40593          	addi	a1,s0,-81
 44c:	4501                	li	a0,0
 44e:	00000097          	auipc	ra,0x0
 452:	19a080e7          	jalr	410(ra) # 5e8 <read>
    if(cc < 1)
 456:	00a05e63          	blez	a0,472 <gets+0x56>
    buf[i++] = c;
 45a:	faf44783          	lbu	a5,-81(s0)
 45e:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 462:	01578763          	beq	a5,s5,470 <gets+0x54>
 466:	0905                	addi	s2,s2,1
 468:	fd679be3          	bne	a5,s6,43e <gets+0x22>
  for(i=0; i+1 < max; ){
 46c:	89a6                	mv	s3,s1
 46e:	a011                	j	472 <gets+0x56>
 470:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 472:	99de                	add	s3,s3,s7
 474:	00098023          	sb	zero,0(s3)
  return buf;
}
 478:	855e                	mv	a0,s7
 47a:	60e6                	ld	ra,88(sp)
 47c:	6446                	ld	s0,80(sp)
 47e:	64a6                	ld	s1,72(sp)
 480:	6906                	ld	s2,64(sp)
 482:	79e2                	ld	s3,56(sp)
 484:	7a42                	ld	s4,48(sp)
 486:	7aa2                	ld	s5,40(sp)
 488:	7b02                	ld	s6,32(sp)
 48a:	6be2                	ld	s7,24(sp)
 48c:	6125                	addi	sp,sp,96
 48e:	8082                	ret

0000000000000490 <stat>:

int
stat(const char *n, struct stat *st)
{
 490:	1101                	addi	sp,sp,-32
 492:	ec06                	sd	ra,24(sp)
 494:	e822                	sd	s0,16(sp)
 496:	e426                	sd	s1,8(sp)
 498:	e04a                	sd	s2,0(sp)
 49a:	1000                	addi	s0,sp,32
 49c:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 49e:	4581                	li	a1,0
 4a0:	00000097          	auipc	ra,0x0
 4a4:	170080e7          	jalr	368(ra) # 610 <open>
  if(fd < 0)
 4a8:	02054563          	bltz	a0,4d2 <stat+0x42>
 4ac:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 4ae:	85ca                	mv	a1,s2
 4b0:	00000097          	auipc	ra,0x0
 4b4:	178080e7          	jalr	376(ra) # 628 <fstat>
 4b8:	892a                	mv	s2,a0
  close(fd);
 4ba:	8526                	mv	a0,s1
 4bc:	00000097          	auipc	ra,0x0
 4c0:	13c080e7          	jalr	316(ra) # 5f8 <close>
  return r;
}
 4c4:	854a                	mv	a0,s2
 4c6:	60e2                	ld	ra,24(sp)
 4c8:	6442                	ld	s0,16(sp)
 4ca:	64a2                	ld	s1,8(sp)
 4cc:	6902                	ld	s2,0(sp)
 4ce:	6105                	addi	sp,sp,32
 4d0:	8082                	ret
    return -1;
 4d2:	597d                	li	s2,-1
 4d4:	bfc5                	j	4c4 <stat+0x34>

00000000000004d6 <atoi>:

int
atoi(const char *s)
{
 4d6:	1141                	addi	sp,sp,-16
 4d8:	e422                	sd	s0,8(sp)
 4da:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 4dc:	00054683          	lbu	a3,0(a0)
 4e0:	fd06879b          	addiw	a5,a3,-48
 4e4:	0ff7f793          	zext.b	a5,a5
 4e8:	4625                	li	a2,9
 4ea:	02f66863          	bltu	a2,a5,51a <atoi+0x44>
 4ee:	872a                	mv	a4,a0
  n = 0;
 4f0:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 4f2:	0705                	addi	a4,a4,1
 4f4:	0025179b          	slliw	a5,a0,0x2
 4f8:	9fa9                	addw	a5,a5,a0
 4fa:	0017979b          	slliw	a5,a5,0x1
 4fe:	9fb5                	addw	a5,a5,a3
 500:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 504:	00074683          	lbu	a3,0(a4)
 508:	fd06879b          	addiw	a5,a3,-48
 50c:	0ff7f793          	zext.b	a5,a5
 510:	fef671e3          	bgeu	a2,a5,4f2 <atoi+0x1c>
  return n;
}
 514:	6422                	ld	s0,8(sp)
 516:	0141                	addi	sp,sp,16
 518:	8082                	ret
  n = 0;
 51a:	4501                	li	a0,0
 51c:	bfe5                	j	514 <atoi+0x3e>

000000000000051e <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 51e:	1141                	addi	sp,sp,-16
 520:	e422                	sd	s0,8(sp)
 522:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 524:	02b57463          	bgeu	a0,a1,54c <memmove+0x2e>
    while(n-- > 0)
 528:	00c05f63          	blez	a2,546 <memmove+0x28>
 52c:	1602                	slli	a2,a2,0x20
 52e:	9201                	srli	a2,a2,0x20
 530:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 534:	872a                	mv	a4,a0
      *dst++ = *src++;
 536:	0585                	addi	a1,a1,1
 538:	0705                	addi	a4,a4,1
 53a:	fff5c683          	lbu	a3,-1(a1)
 53e:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 542:	fee79ae3          	bne	a5,a4,536 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 546:	6422                	ld	s0,8(sp)
 548:	0141                	addi	sp,sp,16
 54a:	8082                	ret
    dst += n;
 54c:	00c50733          	add	a4,a0,a2
    src += n;
 550:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 552:	fec05ae3          	blez	a2,546 <memmove+0x28>
 556:	fff6079b          	addiw	a5,a2,-1
 55a:	1782                	slli	a5,a5,0x20
 55c:	9381                	srli	a5,a5,0x20
 55e:	fff7c793          	not	a5,a5
 562:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 564:	15fd                	addi	a1,a1,-1
 566:	177d                	addi	a4,a4,-1
 568:	0005c683          	lbu	a3,0(a1)
 56c:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 570:	fee79ae3          	bne	a5,a4,564 <memmove+0x46>
 574:	bfc9                	j	546 <memmove+0x28>

0000000000000576 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 576:	1141                	addi	sp,sp,-16
 578:	e422                	sd	s0,8(sp)
 57a:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 57c:	ca05                	beqz	a2,5ac <memcmp+0x36>
 57e:	fff6069b          	addiw	a3,a2,-1
 582:	1682                	slli	a3,a3,0x20
 584:	9281                	srli	a3,a3,0x20
 586:	0685                	addi	a3,a3,1
 588:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 58a:	00054783          	lbu	a5,0(a0)
 58e:	0005c703          	lbu	a4,0(a1)
 592:	00e79863          	bne	a5,a4,5a2 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 596:	0505                	addi	a0,a0,1
    p2++;
 598:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 59a:	fed518e3          	bne	a0,a3,58a <memcmp+0x14>
  }
  return 0;
 59e:	4501                	li	a0,0
 5a0:	a019                	j	5a6 <memcmp+0x30>
      return *p1 - *p2;
 5a2:	40e7853b          	subw	a0,a5,a4
}
 5a6:	6422                	ld	s0,8(sp)
 5a8:	0141                	addi	sp,sp,16
 5aa:	8082                	ret
  return 0;
 5ac:	4501                	li	a0,0
 5ae:	bfe5                	j	5a6 <memcmp+0x30>

00000000000005b0 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 5b0:	1141                	addi	sp,sp,-16
 5b2:	e406                	sd	ra,8(sp)
 5b4:	e022                	sd	s0,0(sp)
 5b6:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 5b8:	00000097          	auipc	ra,0x0
 5bc:	f66080e7          	jalr	-154(ra) # 51e <memmove>
}
 5c0:	60a2                	ld	ra,8(sp)
 5c2:	6402                	ld	s0,0(sp)
 5c4:	0141                	addi	sp,sp,16
 5c6:	8082                	ret

00000000000005c8 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 5c8:	4885                	li	a7,1
 ecall
 5ca:	00000073          	ecall
 ret
 5ce:	8082                	ret

00000000000005d0 <exit>:
.global exit
exit:
 li a7, SYS_exit
 5d0:	4889                	li	a7,2
 ecall
 5d2:	00000073          	ecall
 ret
 5d6:	8082                	ret

00000000000005d8 <wait>:
.global wait
wait:
 li a7, SYS_wait
 5d8:	488d                	li	a7,3
 ecall
 5da:	00000073          	ecall
 ret
 5de:	8082                	ret

00000000000005e0 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 5e0:	4891                	li	a7,4
 ecall
 5e2:	00000073          	ecall
 ret
 5e6:	8082                	ret

00000000000005e8 <read>:
.global read
read:
 li a7, SYS_read
 5e8:	4895                	li	a7,5
 ecall
 5ea:	00000073          	ecall
 ret
 5ee:	8082                	ret

00000000000005f0 <write>:
.global write
write:
 li a7, SYS_write
 5f0:	48c1                	li	a7,16
 ecall
 5f2:	00000073          	ecall
 ret
 5f6:	8082                	ret

00000000000005f8 <close>:
.global close
close:
 li a7, SYS_close
 5f8:	48d5                	li	a7,21
 ecall
 5fa:	00000073          	ecall
 ret
 5fe:	8082                	ret

0000000000000600 <kill>:
.global kill
kill:
 li a7, SYS_kill
 600:	4899                	li	a7,6
 ecall
 602:	00000073          	ecall
 ret
 606:	8082                	ret

0000000000000608 <exec>:
.global exec
exec:
 li a7, SYS_exec
 608:	489d                	li	a7,7
 ecall
 60a:	00000073          	ecall
 ret
 60e:	8082                	ret

0000000000000610 <open>:
.global open
open:
 li a7, SYS_open
 610:	48bd                	li	a7,15
 ecall
 612:	00000073          	ecall
 ret
 616:	8082                	ret

0000000000000618 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 618:	48c5                	li	a7,17
 ecall
 61a:	00000073          	ecall
 ret
 61e:	8082                	ret

0000000000000620 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 620:	48c9                	li	a7,18
 ecall
 622:	00000073          	ecall
 ret
 626:	8082                	ret

0000000000000628 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 628:	48a1                	li	a7,8
 ecall
 62a:	00000073          	ecall
 ret
 62e:	8082                	ret

0000000000000630 <link>:
.global link
link:
 li a7, SYS_link
 630:	48cd                	li	a7,19
 ecall
 632:	00000073          	ecall
 ret
 636:	8082                	ret

0000000000000638 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 638:	48d1                	li	a7,20
 ecall
 63a:	00000073          	ecall
 ret
 63e:	8082                	ret

0000000000000640 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 640:	48a5                	li	a7,9
 ecall
 642:	00000073          	ecall
 ret
 646:	8082                	ret

0000000000000648 <dup>:
.global dup
dup:
 li a7, SYS_dup
 648:	48a9                	li	a7,10
 ecall
 64a:	00000073          	ecall
 ret
 64e:	8082                	ret

0000000000000650 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 650:	48ad                	li	a7,11
 ecall
 652:	00000073          	ecall
 ret
 656:	8082                	ret

0000000000000658 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 658:	48b1                	li	a7,12
 ecall
 65a:	00000073          	ecall
 ret
 65e:	8082                	ret

0000000000000660 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 660:	48b5                	li	a7,13
 ecall
 662:	00000073          	ecall
 ret
 666:	8082                	ret

0000000000000668 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 668:	48b9                	li	a7,14
 ecall
 66a:	00000073          	ecall
 ret
 66e:	8082                	ret

0000000000000670 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 670:	1101                	addi	sp,sp,-32
 672:	ec06                	sd	ra,24(sp)
 674:	e822                	sd	s0,16(sp)
 676:	1000                	addi	s0,sp,32
 678:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 67c:	4605                	li	a2,1
 67e:	fef40593          	addi	a1,s0,-17
 682:	00000097          	auipc	ra,0x0
 686:	f6e080e7          	jalr	-146(ra) # 5f0 <write>
}
 68a:	60e2                	ld	ra,24(sp)
 68c:	6442                	ld	s0,16(sp)
 68e:	6105                	addi	sp,sp,32
 690:	8082                	ret

0000000000000692 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 692:	7139                	addi	sp,sp,-64
 694:	fc06                	sd	ra,56(sp)
 696:	f822                	sd	s0,48(sp)
 698:	f426                	sd	s1,40(sp)
 69a:	f04a                	sd	s2,32(sp)
 69c:	ec4e                	sd	s3,24(sp)
 69e:	0080                	addi	s0,sp,64
 6a0:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 6a2:	c299                	beqz	a3,6a8 <printint+0x16>
 6a4:	0805c963          	bltz	a1,736 <printint+0xa4>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 6a8:	2581                	sext.w	a1,a1
  neg = 0;
 6aa:	4881                	li	a7,0
 6ac:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 6b0:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 6b2:	2601                	sext.w	a2,a2
 6b4:	00000517          	auipc	a0,0x0
 6b8:	50450513          	addi	a0,a0,1284 # bb8 <digits>
 6bc:	883a                	mv	a6,a4
 6be:	2705                	addiw	a4,a4,1
 6c0:	02c5f7bb          	remuw	a5,a1,a2
 6c4:	1782                	slli	a5,a5,0x20
 6c6:	9381                	srli	a5,a5,0x20
 6c8:	97aa                	add	a5,a5,a0
 6ca:	0007c783          	lbu	a5,0(a5)
 6ce:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 6d2:	0005879b          	sext.w	a5,a1
 6d6:	02c5d5bb          	divuw	a1,a1,a2
 6da:	0685                	addi	a3,a3,1
 6dc:	fec7f0e3          	bgeu	a5,a2,6bc <printint+0x2a>
  if(neg)
 6e0:	00088c63          	beqz	a7,6f8 <printint+0x66>
    buf[i++] = '-';
 6e4:	fd070793          	addi	a5,a4,-48
 6e8:	00878733          	add	a4,a5,s0
 6ec:	02d00793          	li	a5,45
 6f0:	fef70823          	sb	a5,-16(a4)
 6f4:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 6f8:	02e05863          	blez	a4,728 <printint+0x96>
 6fc:	fc040793          	addi	a5,s0,-64
 700:	00e78933          	add	s2,a5,a4
 704:	fff78993          	addi	s3,a5,-1
 708:	99ba                	add	s3,s3,a4
 70a:	377d                	addiw	a4,a4,-1
 70c:	1702                	slli	a4,a4,0x20
 70e:	9301                	srli	a4,a4,0x20
 710:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 714:	fff94583          	lbu	a1,-1(s2)
 718:	8526                	mv	a0,s1
 71a:	00000097          	auipc	ra,0x0
 71e:	f56080e7          	jalr	-170(ra) # 670 <putc>
  while(--i >= 0)
 722:	197d                	addi	s2,s2,-1
 724:	ff3918e3          	bne	s2,s3,714 <printint+0x82>
}
 728:	70e2                	ld	ra,56(sp)
 72a:	7442                	ld	s0,48(sp)
 72c:	74a2                	ld	s1,40(sp)
 72e:	7902                	ld	s2,32(sp)
 730:	69e2                	ld	s3,24(sp)
 732:	6121                	addi	sp,sp,64
 734:	8082                	ret
    x = -xx;
 736:	40b005bb          	negw	a1,a1
    neg = 1;
 73a:	4885                	li	a7,1
    x = -xx;
 73c:	bf85                	j	6ac <printint+0x1a>

000000000000073e <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 73e:	7119                	addi	sp,sp,-128
 740:	fc86                	sd	ra,120(sp)
 742:	f8a2                	sd	s0,112(sp)
 744:	f4a6                	sd	s1,104(sp)
 746:	f0ca                	sd	s2,96(sp)
 748:	ecce                	sd	s3,88(sp)
 74a:	e8d2                	sd	s4,80(sp)
 74c:	e4d6                	sd	s5,72(sp)
 74e:	e0da                	sd	s6,64(sp)
 750:	fc5e                	sd	s7,56(sp)
 752:	f862                	sd	s8,48(sp)
 754:	f466                	sd	s9,40(sp)
 756:	f06a                	sd	s10,32(sp)
 758:	ec6e                	sd	s11,24(sp)
 75a:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 75c:	0005c903          	lbu	s2,0(a1)
 760:	18090f63          	beqz	s2,8fe <vprintf+0x1c0>
 764:	8aaa                	mv	s5,a0
 766:	8b32                	mv	s6,a2
 768:	00158493          	addi	s1,a1,1
  state = 0;
 76c:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 76e:	02500a13          	li	s4,37
 772:	4c55                	li	s8,21
 774:	00000c97          	auipc	s9,0x0
 778:	3ecc8c93          	addi	s9,s9,1004 # b60 <malloc+0x15e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
        s = va_arg(ap, char*);
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 77c:	02800d93          	li	s11,40
  putc(fd, 'x');
 780:	4d41                	li	s10,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 782:	00000b97          	auipc	s7,0x0
 786:	436b8b93          	addi	s7,s7,1078 # bb8 <digits>
 78a:	a839                	j	7a8 <vprintf+0x6a>
        putc(fd, c);
 78c:	85ca                	mv	a1,s2
 78e:	8556                	mv	a0,s5
 790:	00000097          	auipc	ra,0x0
 794:	ee0080e7          	jalr	-288(ra) # 670 <putc>
 798:	a019                	j	79e <vprintf+0x60>
    } else if(state == '%'){
 79a:	01498d63          	beq	s3,s4,7b4 <vprintf+0x76>
  for(i = 0; fmt[i]; i++){
 79e:	0485                	addi	s1,s1,1
 7a0:	fff4c903          	lbu	s2,-1(s1)
 7a4:	14090d63          	beqz	s2,8fe <vprintf+0x1c0>
    if(state == 0){
 7a8:	fe0999e3          	bnez	s3,79a <vprintf+0x5c>
      if(c == '%'){
 7ac:	ff4910e3          	bne	s2,s4,78c <vprintf+0x4e>
        state = '%';
 7b0:	89d2                	mv	s3,s4
 7b2:	b7f5                	j	79e <vprintf+0x60>
      if(c == 'd'){
 7b4:	11490c63          	beq	s2,s4,8cc <vprintf+0x18e>
 7b8:	f9d9079b          	addiw	a5,s2,-99
 7bc:	0ff7f793          	zext.b	a5,a5
 7c0:	10fc6e63          	bltu	s8,a5,8dc <vprintf+0x19e>
 7c4:	f9d9079b          	addiw	a5,s2,-99
 7c8:	0ff7f713          	zext.b	a4,a5
 7cc:	10ec6863          	bltu	s8,a4,8dc <vprintf+0x19e>
 7d0:	00271793          	slli	a5,a4,0x2
 7d4:	97e6                	add	a5,a5,s9
 7d6:	439c                	lw	a5,0(a5)
 7d8:	97e6                	add	a5,a5,s9
 7da:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
 7dc:	008b0913          	addi	s2,s6,8
 7e0:	4685                	li	a3,1
 7e2:	4629                	li	a2,10
 7e4:	000b2583          	lw	a1,0(s6)
 7e8:	8556                	mv	a0,s5
 7ea:	00000097          	auipc	ra,0x0
 7ee:	ea8080e7          	jalr	-344(ra) # 692 <printint>
 7f2:	8b4a                	mv	s6,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 7f4:	4981                	li	s3,0
 7f6:	b765                	j	79e <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 7f8:	008b0913          	addi	s2,s6,8
 7fc:	4681                	li	a3,0
 7fe:	4629                	li	a2,10
 800:	000b2583          	lw	a1,0(s6)
 804:	8556                	mv	a0,s5
 806:	00000097          	auipc	ra,0x0
 80a:	e8c080e7          	jalr	-372(ra) # 692 <printint>
 80e:	8b4a                	mv	s6,s2
      state = 0;
 810:	4981                	li	s3,0
 812:	b771                	j	79e <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 814:	008b0913          	addi	s2,s6,8
 818:	4681                	li	a3,0
 81a:	866a                	mv	a2,s10
 81c:	000b2583          	lw	a1,0(s6)
 820:	8556                	mv	a0,s5
 822:	00000097          	auipc	ra,0x0
 826:	e70080e7          	jalr	-400(ra) # 692 <printint>
 82a:	8b4a                	mv	s6,s2
      state = 0;
 82c:	4981                	li	s3,0
 82e:	bf85                	j	79e <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 830:	008b0793          	addi	a5,s6,8
 834:	f8f43423          	sd	a5,-120(s0)
 838:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 83c:	03000593          	li	a1,48
 840:	8556                	mv	a0,s5
 842:	00000097          	auipc	ra,0x0
 846:	e2e080e7          	jalr	-466(ra) # 670 <putc>
  putc(fd, 'x');
 84a:	07800593          	li	a1,120
 84e:	8556                	mv	a0,s5
 850:	00000097          	auipc	ra,0x0
 854:	e20080e7          	jalr	-480(ra) # 670 <putc>
 858:	896a                	mv	s2,s10
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 85a:	03c9d793          	srli	a5,s3,0x3c
 85e:	97de                	add	a5,a5,s7
 860:	0007c583          	lbu	a1,0(a5)
 864:	8556                	mv	a0,s5
 866:	00000097          	auipc	ra,0x0
 86a:	e0a080e7          	jalr	-502(ra) # 670 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 86e:	0992                	slli	s3,s3,0x4
 870:	397d                	addiw	s2,s2,-1
 872:	fe0914e3          	bnez	s2,85a <vprintf+0x11c>
        printptr(fd, va_arg(ap, uint64));
 876:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 87a:	4981                	li	s3,0
 87c:	b70d                	j	79e <vprintf+0x60>
        s = va_arg(ap, char*);
 87e:	008b0913          	addi	s2,s6,8
 882:	000b3983          	ld	s3,0(s6)
        if(s == 0)
 886:	02098163          	beqz	s3,8a8 <vprintf+0x16a>
        while(*s != 0){
 88a:	0009c583          	lbu	a1,0(s3)
 88e:	c5ad                	beqz	a1,8f8 <vprintf+0x1ba>
          putc(fd, *s);
 890:	8556                	mv	a0,s5
 892:	00000097          	auipc	ra,0x0
 896:	dde080e7          	jalr	-546(ra) # 670 <putc>
          s++;
 89a:	0985                	addi	s3,s3,1
        while(*s != 0){
 89c:	0009c583          	lbu	a1,0(s3)
 8a0:	f9e5                	bnez	a1,890 <vprintf+0x152>
        s = va_arg(ap, char*);
 8a2:	8b4a                	mv	s6,s2
      state = 0;
 8a4:	4981                	li	s3,0
 8a6:	bde5                	j	79e <vprintf+0x60>
          s = "(null)";
 8a8:	00000997          	auipc	s3,0x0
 8ac:	2b098993          	addi	s3,s3,688 # b58 <malloc+0x156>
        while(*s != 0){
 8b0:	85ee                	mv	a1,s11
 8b2:	bff9                	j	890 <vprintf+0x152>
        putc(fd, va_arg(ap, uint));
 8b4:	008b0913          	addi	s2,s6,8
 8b8:	000b4583          	lbu	a1,0(s6)
 8bc:	8556                	mv	a0,s5
 8be:	00000097          	auipc	ra,0x0
 8c2:	db2080e7          	jalr	-590(ra) # 670 <putc>
 8c6:	8b4a                	mv	s6,s2
      state = 0;
 8c8:	4981                	li	s3,0
 8ca:	bdd1                	j	79e <vprintf+0x60>
        putc(fd, c);
 8cc:	85d2                	mv	a1,s4
 8ce:	8556                	mv	a0,s5
 8d0:	00000097          	auipc	ra,0x0
 8d4:	da0080e7          	jalr	-608(ra) # 670 <putc>
      state = 0;
 8d8:	4981                	li	s3,0
 8da:	b5d1                	j	79e <vprintf+0x60>
        putc(fd, '%');
 8dc:	85d2                	mv	a1,s4
 8de:	8556                	mv	a0,s5
 8e0:	00000097          	auipc	ra,0x0
 8e4:	d90080e7          	jalr	-624(ra) # 670 <putc>
        putc(fd, c);
 8e8:	85ca                	mv	a1,s2
 8ea:	8556                	mv	a0,s5
 8ec:	00000097          	auipc	ra,0x0
 8f0:	d84080e7          	jalr	-636(ra) # 670 <putc>
      state = 0;
 8f4:	4981                	li	s3,0
 8f6:	b565                	j	79e <vprintf+0x60>
        s = va_arg(ap, char*);
 8f8:	8b4a                	mv	s6,s2
      state = 0;
 8fa:	4981                	li	s3,0
 8fc:	b54d                	j	79e <vprintf+0x60>
    }
  }
}
 8fe:	70e6                	ld	ra,120(sp)
 900:	7446                	ld	s0,112(sp)
 902:	74a6                	ld	s1,104(sp)
 904:	7906                	ld	s2,96(sp)
 906:	69e6                	ld	s3,88(sp)
 908:	6a46                	ld	s4,80(sp)
 90a:	6aa6                	ld	s5,72(sp)
 90c:	6b06                	ld	s6,64(sp)
 90e:	7be2                	ld	s7,56(sp)
 910:	7c42                	ld	s8,48(sp)
 912:	7ca2                	ld	s9,40(sp)
 914:	7d02                	ld	s10,32(sp)
 916:	6de2                	ld	s11,24(sp)
 918:	6109                	addi	sp,sp,128
 91a:	8082                	ret

000000000000091c <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 91c:	715d                	addi	sp,sp,-80
 91e:	ec06                	sd	ra,24(sp)
 920:	e822                	sd	s0,16(sp)
 922:	1000                	addi	s0,sp,32
 924:	e010                	sd	a2,0(s0)
 926:	e414                	sd	a3,8(s0)
 928:	e818                	sd	a4,16(s0)
 92a:	ec1c                	sd	a5,24(s0)
 92c:	03043023          	sd	a6,32(s0)
 930:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 934:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 938:	8622                	mv	a2,s0
 93a:	00000097          	auipc	ra,0x0
 93e:	e04080e7          	jalr	-508(ra) # 73e <vprintf>
}
 942:	60e2                	ld	ra,24(sp)
 944:	6442                	ld	s0,16(sp)
 946:	6161                	addi	sp,sp,80
 948:	8082                	ret

000000000000094a <printf>:

void
printf(const char *fmt, ...)
{
 94a:	711d                	addi	sp,sp,-96
 94c:	ec06                	sd	ra,24(sp)
 94e:	e822                	sd	s0,16(sp)
 950:	1000                	addi	s0,sp,32
 952:	e40c                	sd	a1,8(s0)
 954:	e810                	sd	a2,16(s0)
 956:	ec14                	sd	a3,24(s0)
 958:	f018                	sd	a4,32(s0)
 95a:	f41c                	sd	a5,40(s0)
 95c:	03043823          	sd	a6,48(s0)
 960:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 964:	00840613          	addi	a2,s0,8
 968:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 96c:	85aa                	mv	a1,a0
 96e:	4505                	li	a0,1
 970:	00000097          	auipc	ra,0x0
 974:	dce080e7          	jalr	-562(ra) # 73e <vprintf>
}
 978:	60e2                	ld	ra,24(sp)
 97a:	6442                	ld	s0,16(sp)
 97c:	6125                	addi	sp,sp,96
 97e:	8082                	ret

0000000000000980 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 980:	1141                	addi	sp,sp,-16
 982:	e422                	sd	s0,8(sp)
 984:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 986:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 98a:	00000797          	auipc	a5,0x0
 98e:	2467b783          	ld	a5,582(a5) # bd0 <freep>
 992:	a02d                	j	9bc <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 994:	4618                	lw	a4,8(a2)
 996:	9f2d                	addw	a4,a4,a1
 998:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 99c:	6398                	ld	a4,0(a5)
 99e:	6310                	ld	a2,0(a4)
 9a0:	a83d                	j	9de <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 9a2:	ff852703          	lw	a4,-8(a0)
 9a6:	9f31                	addw	a4,a4,a2
 9a8:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 9aa:	ff053683          	ld	a3,-16(a0)
 9ae:	a091                	j	9f2 <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 9b0:	6398                	ld	a4,0(a5)
 9b2:	00e7e463          	bltu	a5,a4,9ba <free+0x3a>
 9b6:	00e6ea63          	bltu	a3,a4,9ca <free+0x4a>
{
 9ba:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 9bc:	fed7fae3          	bgeu	a5,a3,9b0 <free+0x30>
 9c0:	6398                	ld	a4,0(a5)
 9c2:	00e6e463          	bltu	a3,a4,9ca <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 9c6:	fee7eae3          	bltu	a5,a4,9ba <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 9ca:	ff852583          	lw	a1,-8(a0)
 9ce:	6390                	ld	a2,0(a5)
 9d0:	02059813          	slli	a6,a1,0x20
 9d4:	01c85713          	srli	a4,a6,0x1c
 9d8:	9736                	add	a4,a4,a3
 9da:	fae60de3          	beq	a2,a4,994 <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 9de:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 9e2:	4790                	lw	a2,8(a5)
 9e4:	02061593          	slli	a1,a2,0x20
 9e8:	01c5d713          	srli	a4,a1,0x1c
 9ec:	973e                	add	a4,a4,a5
 9ee:	fae68ae3          	beq	a3,a4,9a2 <free+0x22>
    p->s.ptr = bp->s.ptr;
 9f2:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 9f4:	00000717          	auipc	a4,0x0
 9f8:	1cf73e23          	sd	a5,476(a4) # bd0 <freep>
}
 9fc:	6422                	ld	s0,8(sp)
 9fe:	0141                	addi	sp,sp,16
 a00:	8082                	ret

0000000000000a02 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 a02:	7139                	addi	sp,sp,-64
 a04:	fc06                	sd	ra,56(sp)
 a06:	f822                	sd	s0,48(sp)
 a08:	f426                	sd	s1,40(sp)
 a0a:	f04a                	sd	s2,32(sp)
 a0c:	ec4e                	sd	s3,24(sp)
 a0e:	e852                	sd	s4,16(sp)
 a10:	e456                	sd	s5,8(sp)
 a12:	e05a                	sd	s6,0(sp)
 a14:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 a16:	02051493          	slli	s1,a0,0x20
 a1a:	9081                	srli	s1,s1,0x20
 a1c:	04bd                	addi	s1,s1,15
 a1e:	8091                	srli	s1,s1,0x4
 a20:	0014899b          	addiw	s3,s1,1
 a24:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 a26:	00000517          	auipc	a0,0x0
 a2a:	1aa53503          	ld	a0,426(a0) # bd0 <freep>
 a2e:	c515                	beqz	a0,a5a <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a30:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 a32:	4798                	lw	a4,8(a5)
 a34:	02977f63          	bgeu	a4,s1,a72 <malloc+0x70>
 a38:	8a4e                	mv	s4,s3
 a3a:	0009871b          	sext.w	a4,s3
 a3e:	6685                	lui	a3,0x1
 a40:	00d77363          	bgeu	a4,a3,a46 <malloc+0x44>
 a44:	6a05                	lui	s4,0x1
 a46:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 a4a:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 a4e:	00000917          	auipc	s2,0x0
 a52:	18290913          	addi	s2,s2,386 # bd0 <freep>
  if(p == (char*)-1)
 a56:	5afd                	li	s5,-1
 a58:	a895                	j	acc <malloc+0xca>
    base.s.ptr = freep = prevp = &base;
 a5a:	00000797          	auipc	a5,0x0
 a5e:	18e78793          	addi	a5,a5,398 # be8 <base>
 a62:	00000717          	auipc	a4,0x0
 a66:	16f73723          	sd	a5,366(a4) # bd0 <freep>
 a6a:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 a6c:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 a70:	b7e1                	j	a38 <malloc+0x36>
      if(p->s.size == nunits)
 a72:	02e48c63          	beq	s1,a4,aaa <malloc+0xa8>
        p->s.size -= nunits;
 a76:	4137073b          	subw	a4,a4,s3
 a7a:	c798                	sw	a4,8(a5)
        p += p->s.size;
 a7c:	02071693          	slli	a3,a4,0x20
 a80:	01c6d713          	srli	a4,a3,0x1c
 a84:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 a86:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 a8a:	00000717          	auipc	a4,0x0
 a8e:	14a73323          	sd	a0,326(a4) # bd0 <freep>
      return (void*)(p + 1);
 a92:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 a96:	70e2                	ld	ra,56(sp)
 a98:	7442                	ld	s0,48(sp)
 a9a:	74a2                	ld	s1,40(sp)
 a9c:	7902                	ld	s2,32(sp)
 a9e:	69e2                	ld	s3,24(sp)
 aa0:	6a42                	ld	s4,16(sp)
 aa2:	6aa2                	ld	s5,8(sp)
 aa4:	6b02                	ld	s6,0(sp)
 aa6:	6121                	addi	sp,sp,64
 aa8:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 aaa:	6398                	ld	a4,0(a5)
 aac:	e118                	sd	a4,0(a0)
 aae:	bff1                	j	a8a <malloc+0x88>
  hp->s.size = nu;
 ab0:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 ab4:	0541                	addi	a0,a0,16
 ab6:	00000097          	auipc	ra,0x0
 aba:	eca080e7          	jalr	-310(ra) # 980 <free>
  return freep;
 abe:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 ac2:	d971                	beqz	a0,a96 <malloc+0x94>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 ac4:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 ac6:	4798                	lw	a4,8(a5)
 ac8:	fa9775e3          	bgeu	a4,s1,a72 <malloc+0x70>
    if(p == freep)
 acc:	00093703          	ld	a4,0(s2)
 ad0:	853e                	mv	a0,a5
 ad2:	fef719e3          	bne	a4,a5,ac4 <malloc+0xc2>
  p = sbrk(nu * sizeof(Header));
 ad6:	8552                	mv	a0,s4
 ad8:	00000097          	auipc	ra,0x0
 adc:	b80080e7          	jalr	-1152(ra) # 658 <sbrk>
  if(p == (char*)-1)
 ae0:	fd5518e3          	bne	a0,s5,ab0 <malloc+0xae>
        return 0;
 ae4:	4501                	li	a0,0
 ae6:	bf45                	j	a96 <malloc+0x94>
